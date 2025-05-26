LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Unite_Gestion_Instructions IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        nPCsel : IN STD_LOGIC;

        Offset : IN STD_LOGIC_VECTOR(23 DOWNTO 0);

        Instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Unite_Gestion_Instructions;

ARCHITECTURE rtl OF Unite_Gestion_Instructions IS
    SIGNAL PC, MuxPC_out, SignExt_out, Mux_in1, Mux_in2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    Mux_in1 <= STD_LOGIC_VECTOR(unsigned(PC) + 1);
    Mux_in2 <= STD_LOGIC_VECTOR(unsigned(PC) + 1 + unsigned(SignExt_out));

    -- Multiplexeur pour la selection de l'adresse du PC
    U_Multiplexeur_PC : ENTITY work.Multiplexeur
        GENERIC MAP(
            N => 32
        )
        PORT MAP(
            A => Mux_in1,
            B => Mux_in2,
            COM => nPCsel,
            S => MuxPC_out
        );

    -- Instruction Memory
    U_Instruction_Memory : ENTITY work.Instruction_Memory
        PORT MAP(
            PC => PC,
            Instruction => Instruction
        );

    -- Sign Extension pour l'offset
    U_Sign_Extension_Offset : ENTITY work.Sign_Extension
        GENERIC MAP(
            N => 24
        )
        PORT MAP(
            E => Offset,
            S => SignExt_out
        );

    -- PC
    U_PC : ENTITY work.PC
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            E => MuxPC_out,
            S => PC
        );
END ARCHITECTURE;