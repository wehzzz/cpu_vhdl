LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity Unite_Gestion_Instructions is
    Port (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        nPCsel: IN STD_LOGIC;

        Offset: IN STD_LOGIC_VECTOR(23 DOWNTO 0);

        Instruction: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    );
end Unite_Gestion_Instructions;

architecture rtl of Unite_Gestion_Instructions is
    signal PC, MuxPC_out, SignExt_out: std_logic_vector(31 downto 0);
begin
    -- Multiplexeur pour la selection de l'adresse du PC
    U_Multiplexeur_PC : entity work.Multiplexeur
        generic map (
            N => 32
        )
        port map (
            A => PC + 1,
            B => PC + 1 + SignExt_out,
            COM => nPCsel,
            S => MuxPC_out
        );

    -- Instruction Memory
    U_Instruction_Memory : entity work.Instruction_Memory
        port map (
            CLK => CLK,
            Reset => Reset,
            Address => PC,
            Instruction => Instruction
        );

    -- Sign Extension pour l'offset
    U_Sign_Extension_Offset : entity work.Sign_Extension
        generic map (
            N => 24
        )
        port map (
            E => Offset,
            S => SignExt_out
        );

    -- PC
    U_PC : entity work.PC
        port map (
            CLK => CLK,
            Reset => Reset,
            E => MuxPC_out,
            S => PC
        );
end architecture;