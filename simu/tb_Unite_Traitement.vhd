LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_Unite_Traitement IS
END ENTITY;

ARCHITECTURE behavior OF tb_Unite_Traitement IS
    COMPONENT Unite_Traitement IS
        PORT (
            CLK : IN STD_LOGIC;
            Reset : IN STD_LOGIC;

            RA, RB, RW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            WE : IN STD_LOGIC;
            OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            ALUSrc, MemWr, WrSrc : IN STD_LOGIC;
            Imm : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            N, Z, C, V : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Reset : STD_LOGIC := '0';
    SIGNAL RA, RB, RW : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL WE : STD_LOGIC;
    SIGNAL OP : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL ALUSrc : STD_LOGIC;
    SIGNAL MemWr : STD_LOGIC;
    SIGNAL WrSrc : STD_LOGIC;
    SIGNAL Imm : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL N, Z, C, V : STD_LOGIC;

    CONSTANT CLK_PERIOD : TIME := 10 ns;

BEGIN
    DUT : Unite_Traitement
    PORT MAP(
        CLK => CLK,
        Reset => Reset,
        RA => RA,
        RB => RB,
        RW => RW,
        WE => WE,
        OP => OP,
        ALUSrc => ALUSrc,
        MemWr => MemWr,
        WrSrc => WrSrc,
        Imm => Imm,
        N => N,
        Z => Z,
        C => C,
        V => V
    );

    CLK_PROCESS : PROCESS
    BEGIN
        WHILE true LOOP
            CLK <= '0';
            WAIT FOR CLK_PERIOD/2;
            CLK <= '1';
            WAIT FOR CLK_PERIOD/2;
        END LOOP;
    END PROCESS;

    STIMULUS : PROCESS
    BEGIN
        Reset <= '1';
        WAIT FOR CLK_PERIOD;
        Reset <= '0';

        RA <= "0000";
        Imm <= X"10";
        RW <= "0001";
        OP <= "000";
        ALUSrc <= '1';
        WE <= '1';
        WrSrc <= '0';
        WAIT FOR CLK_PERIOD;
        WE <= '0';

        RA <= "0000";
        Imm <= X"20";
        RW <= "0010";
        OP <= "000";
        ALUSrc <= '1';
        WE <= '1';
        WrSrc <= '0';
        WAIT FOR CLK_PERIOD;
        WE <= '0';

        RA <= "0001";
        RB <= "0010";
        RW <= "0011";
        OP <= "000";
        ALUSrc <= '0';
        WE <= '1';
        WrSrc <= '0';
        WAIT FOR CLK_PERIOD;
        WE <= '0';

        RA <= "0010";
        RB <= "0001";
        RW <= "0100";
        OP <= "010";
        ALUSrc <= '0';
        WE <= '1';
        WrSrc <= '0';
        WAIT FOR CLK_PERIOD;
        WE <= '0';

        RA <= "0010";
        Imm <= X"05";
        RW <= "0101";
        OP <= "000";
        ALUSrc <= '1';
        WE <= '1';
        WrSrc <= '0';
        WAIT FOR CLK_PERIOD;
        WE <= '0';

        RA <= "0010";
        Imm <= X"05";
        RW <= "0110";
        OP <= "010";
        ALUSrc <= '1';
        WE <= '1';
        WrSrc <= '0';
        WAIT FOR CLK_PERIOD;
        WE <= '0';

        RA <= "0001";
        RB <= "0001";
        RW <= "0111";
        OP <= "011";
        ALUSrc <= '0';
        WE <= '1';
        WrSrc <= '0';
        WAIT FOR CLK_PERIOD;
        WE <= '0';

        RA <= "0010";
        RB <= "0010";
        OP <= "011";
        ALUSrc <= '0';
        MemWr <= '1';
        WrSrc <= '0';
        WE <= '0';
        WAIT FOR CLK_PERIOD;
        MemWr <= '0';

        RA <= "0010";
        RB <= "0000";
        OP <= "011";
        ALUSrc <= '0';
        WrSrc <= '1';
        MemWr <= '0';
        RW <= "1000";
        WE <= '1';
        WAIT FOR CLK_PERIOD;
        WE <= '0';

        WAIT FOR 10 * CLK_PERIOD;
        ASSERT FALSE REPORT "Fin de simulation." SEVERITY FAILURE;
    END PROCESS;

END ARCHITECTURE;