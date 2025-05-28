LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CPU IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6)
    );
END ENTITY;

ARCHITECTURE rtl OF CPU IS

    -- Signaux internes
    SIGNAL Instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Imm24 : STD_LOGIC_VECTOR(23 DOWNTO 0);
    SIGNAL Imm8 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL PSR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL N, Z, C, V : STD_LOGIC;

    -- Adresses de registre
    SIGNAL Rn, Rd, Rm : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Signaux de contrôle (issus du décodeur)
    SIGNAL nPCSel, RegWr, ALUSrc, PSREn, MemWr, WrSrc, RegSel, RegAff : STD_LOGIC;
    SIGNAL ALUCtr : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL B_bus : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Mux_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reg_display : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Ajout des signaux pour les sorties des 4 digits hexadécimaux
    SIGNAL HEX_DIGIT : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

    SIGNAL RST : STD_LOGIC := '0';

BEGIN
    -- Assignation des sorties HEX
    RST <= NOT Reset;

    -- good
    U_Gestion : ENTITY work.Unite_Gestion_Instructions
        PORT MAP(
            CLK => CLK,
            Reset => RST,
            nPCsel => nPCSel,
            Offset => Imm24,
            Instruction => Instruction
        );

    -- good
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
    Rd <= Instruction(15 DOWNTO 12);
    Rn <= Instruction(19 DOWNTO 16);
    Rm <= Instruction(3 DOWNTO 0);
    Imm24 <= Instruction(23 DOWNTO 0);
    Imm8 <= Instruction(7 DOWNTO 0);

    -- good
    U_Multiplexeur : ENTITY work.Multiplexeur
        GENERIC MAP(
            N => 4
        )
        PORT MAP(
            A => Rm,
            B => Rd,
            COM => RegSel,
            S => Mux_out
        );

    -- good
    U_Traitement : ENTITY work.Unite_Traitement
        PORT MAP(
            CLK => CLK,
            Reset => RST,
            RA => Rn,
            RB => Mux_out,
            RW => Rd,
            WE => RegWr,
            OP => ALUCtr,
            ALUSrc => ALUSrc,
            MemWr => MemWr,
            WrSrc => WrSrc,
            Imm => Imm8,
            N => N,
            Z => Z,
            C => C,
            V => V,
            B_out => B_bus
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

    U_Display_Register : ENTITY work.RegAff
        PORT MAP(
            CLK => CLK,
            Reset => RST,
            En => RegAff,
            D => B_bus,
            Q => reg_display
        );

    -- Connexion des 16 bits de poids faible de reg_display à HEX_DIGIT
    HEX_DIGIT <= reg_display(15 DOWNTO 0);

    -- Instanciation des 4 décodeurs 7 segments pour les digits hexadécimaux
    U_HEX0 : ENTITY work.SEVEN_SEG PORT MAP(
        Pol => '1',
        Segout => HEX0,
        Data => HEX_DIGIT(3 DOWNTO 0)
        );
    U_HEX1 : ENTITY work.SEVEN_SEG PORT MAP(
        Pol => '1',
        Segout => HEX1,
        Data => HEX_DIGIT(7 DOWNTO 4)
        );
    U_HEX2 : ENTITY work.SEVEN_SEG PORT MAP(
        Pol => '1',
        Segout => HEX2,
        Data => HEX_DIGIT(11 DOWNTO 8)
        );
    U_HEX3 : ENTITY work.SEVEN_SEG PORT MAP(
        Pol => '1',
        Segout => HEX3,
        Data => HEX_DIGIT(15 DOWNTO 12)
        );

END ARCHITECTURE;