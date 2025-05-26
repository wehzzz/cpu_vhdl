LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.std_logic_textio.ALL;

ENTITY tb_Unite_Instructions IS
END tb_Unite_Instructions;

ARCHITECTURE behavior OF tb_Unite_Instructions IS

    COMPONENT Unite_Gestion_Instructions
        PORT (
            CLK : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            nPCsel : IN STD_LOGIC;
            Offset : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Reset : STD_LOGIC := '1';
    SIGNAL nPCsel : STD_LOGIC := '0';
    SIGNAL Offset : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');
    SIGNAL Instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- Instance du composant à tester
    DUT : Unite_Gestion_Instructions
    PORT MAP(
        CLK => CLK,
        Reset => Reset,
        nPCsel => nPCsel,
        Offset => Offset,
        Instruction => Instruction
    );

    -- Génération de l'horloge
    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            CLK <= '0';
            WAIT FOR clk_period / 2;
            CLK <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
    END PROCESS;

    -- Stimulus principal
    stim_proc : PROCESS
    BEGIN
        -- first reset
        Reset <= '1';
        WAIT FOR 1 ns;

        -- checking inst(0)
        ASSERT instruction = x"E3A01020" REPORT "Bad first instruction" SEVERITY error;
        WAIT FOR 4 ns;

        Reset <= '0';
        WAIT FOR 1 ns;

        -- PC should inc on clock tick so we check inst(1)
        ASSERT instruction = x"E3A02000" REPORT "Bad second instruction PC:" SEVERITY error;

        -- checking increasing PC with offset
        offset <= x"000001";
        nPCsel <= '1';
        -- waiting clock + 1ns offset
        WAIT FOR 10 ns;

        ASSERT instruction = x"E0822000" REPORT "Bad increase with offset actual: " SEVERITY error;

        Reset <= '1';

        ASSERT FALSE REPORT "Fin de simulation." SEVERITY FAILURE;
        WAIT;
    END PROCESS;

END behavior;