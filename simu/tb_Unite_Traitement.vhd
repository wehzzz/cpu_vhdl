LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_Unite_Traitement IS
END tb_Unite_Traitement;

ARCHITECTURE sim OF tb_Unite_Traitement IS
    COMPONENT Unite_Traitement IS
        PORT (
            CLK : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            RA, RB, RW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            WE : IN STD_LOGIC;
            OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            N, Z, C, V : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Signaux
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Reset : STD_LOGIC := '1';
    SIGNAL RA, RB, RW : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL WE : STD_LOGIC := '0';
    SIGNAL OP : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL N, Z, C, V : STD_LOGIC;

    CONSTANT CLK_PERIOD : TIME := 10 ns;

BEGIN

    -- Instance du DUT
    DUT : Unite_Traitement
    PORT MAP(
        CLK => CLK,
        Reset => Reset,
        RA => RA,
        RB => RB,
        RW => RW,
        WE => WE,
        OP => OP,
        N => N,
        Z => Z,
        C => C,
        V => V
    );

    -- Processus d'horloge
    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            CLK <= '0';
            WAIT FOR CLK_PERIOD / 2;
            CLK <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
    END PROCESS;

    -- Stimulus
    stim_proc : PROCESS
    BEGIN
        -- Attendre 2 cycles pour le reset
        WAIT FOR 20 ns;
        Reset <= '0';

        ----------------------------------------------------------------
        -- Test 1 : R(1) = R(15)
        RA <= "1111"; -- R15
        RB <= "0000"; -- Ne sert pas
        RW <= "0001"; -- R1
        OP <= "011"; -- 1 (copie de A vers S)
        WE <= '1'; -- Active l'écriture

        WAIT FOR CLK_PERIOD;

        ----------------------------------------------------------------
        -- Test 2 : R(1) = R(1) + R(15)
        WE <= '0';
        RA <= "0001"; -- R1
        RB <= "1111"; -- R15
        RW <= "0001"; -- R1
        OP <= "000"; -- ADD
        WE <= '1';
        WAIT FOR CLK_PERIOD;

        WE <= '0';
        -- Fin de simulation
        WAIT;

    END PROCESS;

END ARCHITECTURE;