LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Unite_Traitement IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        RA, RB, RW : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Adresses registre
        WE : IN STD_LOGIC; -- Write enable

        OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Code opération ALU

        N, Z, C, V : OUT STD_LOGIC -- Flags
    );
END ENTITY;

ARCHITECTURE rtl OF Unite_Traitement IS
    -- Signaux internes
    SIGNAL A, B, S : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL T : STD_LOGIC_VECTOR(31 DOWNTO 0); -- Temporaire pour l'ALU
BEGIN
    -- Banc de Registres
    U_Registre : ENTITY work.Banc_Registres
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            W => T,
            RA => RA,
            RB => RB,
            RW => RW,
            WE => WE,
            A => A,
            B => B
        );

    -- ALU
    U_ALU : ENTITY work.ALU
        PORT MAP(
            OP => OP,
            A => A,
            B => B,
            S => T,
            N => N,
            Z => Z,
            C => C,
            V => V
        );

END ARCHITECTURE;