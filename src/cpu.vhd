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
        HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX4 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6)
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
    SIGNAL reg_display : STD_LOGIC_VECTOR(23 DOWNTO 0);

    TYPE HEX_array IS ARRAY (0 TO 5) OF STD_LOGIC_VECTOR(0 TO 6);
    SIGNAL HEX : HEX_array;
    SIGNAL RST : STD_LOGIC := '0';

BEGIN
    -- Assignation des sorties HEX
    RST <= NOT Reset;
    HEX0 <= HEX(0);
    HEX1 <= HEX(1);
    HEX2 <= HEX(2);
    HEX3 <= HEX(3);
    HEX4 <= HEX(4);
    HEX5 <= HEX(5);

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

    seven_seg : FOR i IN 0 TO 5 GENERATE
        seven_seg_inst : ENTITY work.SEVEN_SEG
            PORT MAP(
                Pol => '1',
                Segout => HEX(i)(0 TO 6),
                Data => reg_display(4 * (i + 1) - 1 DOWNTO 4 * i)
            );
    END GENERATE;

END ARCHITECTURE;