LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Unite_Traitement IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        RA, RB, RW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        WE : IN STD_LOGIC;

        OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

        ALUSrc, MemWr, WrSrc : IN STD_LOGIC; -- SIGNALS THAT WILL BE REPLACED LATER IN THE PROJECT

        Imm : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

        N, Z, C, V : OUT STD_LOGIC;

        B_out: STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF Unite_Traitement IS
    SIGNAL A, B, ALU_out, Imm_extended, Mux1_out, Mux2_out, Mem_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

    -- Assign B_out to the output B
    B_out <= B;
    
    -- Banc de Registres
    U_Registre : ENTITY work.Banc_Registres
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            W => Mux2_out,
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
            B => Mux1_out,
            S => ALU_out,
            N => N,
            Z => Z,
            C => C,
            V => V
        );

    -- Multiplexeur
    U_Multiplexeur1 : ENTITY work.Multiplexeur
        GENERIC MAP(
            N => 32
        )
        PORT MAP(
            A => B,
            B => Imm_extended,
            COM => ALUSrc,
            S => Mux1_out
        );

    -- Sign Extension
    U_Sign_Extension : ENTITY work.Sign_Extension
        GENERIC MAP(
            N => 8
        )
        PORT MAP(
            E => Imm,
            S => Imm_extended
        );

    -- Memory
    U_Memory : ENTITY work.Memory
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            Addr => ALU_out(5 DOWNTO 0),
            DataIn => B,
            DataOut => Mem_out,
            WrEn => MemWr
        );

    -- Multiplexeur
    U_Multiplexeur2 : ENTITY work.Multiplexeur
        GENERIC MAP(
            N => 32
        )
        PORT MAP(
            A => ALU_out,
            B => Mem_out,
            COM => WrSrc,
            S => Mux2_out
        );

END ARCHITECTURE;