LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CPU IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF CPU IS

    -- Signaux internes
    SIGNAL Instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Offset : STD_LOGIC_VECTOR(23 DOWNTO 0);
    SIGNAL Imm8 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL PSR : STD_LOGIC_VECTOR(31 DOWNTO 0); -- registre d’état, simulation simple ici
    SIGNAL N, Z, C, V : STD_LOGIC;

    -- Adresses de registre
    SIGNAL RA, RB, RW : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Signaux de contrôle (issus du décodeur)
    SIGNAL nPCSel, RegWr, ALUSrc, PSREn, MemWr, WrSrc, RegSel, RegAff : STD_LOGIC;
    SIGNAL ALUCtr : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    -- good
    U_Gestion : ENTITY work.Unite_Gestion_Instructions
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            nPCsel => nPCSel,
            Offset => Offset,
            Instruction => Instruction
        );

    U_Decodeur : ENTITY work.instruction_decryptor
        PORT MAP(
            InstructionIn => Instruction,
            PSR => PSR,
            nPCSel => nPCSel,
            RegWR => RegWr,
            ALUSrc => ALUSrc,
            ALUCtr => ALUCtr,
            PSREn => PSREn,
            MemWr => MemWr,
            WrSrc => WrSrc,
            RegSel => RegSel,
            RegAff => RegAff
        );

    -- Extraction des registres et champs immédiats de l’instruction
    RW <= Instruction(15 DOWNTO 12);
    RA <= Instruction(19 DOWNTO 16);
    RB <= Instruction(3 DOWNTO 0);
    Offset <= Instruction(23 DOWNTO 0);
    Imm8 <= Instruction(7 DOWNTO 0);

    U_Multiplexeur : ENTITY work.Multiplexeur
        GENERIC MAP(
            N => 32
        )
        PORT MAP(
            A => Rm,
            B => Rd,
            COM => RegSel,
            S => Mux_out
        );

    U_Traitement : ENTITY work.Unite_Traitement
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            RA => RA,
            RB => Mux_out,
            RW => RW,
            WE => RegWr,
            OP => ALUCtr,
            ALUSrc => ALUSrc,
            MemWr => MemWr,
            WrSrc => WrSrc,
            Imm => Imm8,
            N => N,
            Z => Z,
            C => C,
            V => V
        );

    -- good
    U_RegisterPSR : ENTITY work.register_PSR
        PORT MAP(
            N => N,
            Z => Z,
            C => C,
            V => V,
            PSREn => PSREn,
            PSR => PSR
        );

END ARCHITECTURE;