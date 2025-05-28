LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instruction_decryptor IS
    PORT (
        InstructionIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PSR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        nPCSel, RegWR, ALUSrc, PSREn, MemWr, WrSrc, RegSel, RegAff : OUT STD_LOGIC;
        AluCtr : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END instruction_decryptor;

ARCHITECTURE rtl OF instruction_decryptor IS
    TYPE enum_instruction IS (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
    SIGNAL instr_courante : enum_instruction;
BEGIN
    PROCESS (InstructionIn, PSR, instr_courante)
        VARIABLE opcode : STD_LOGIC_VECTOR(3 DOWNTO 0);
    BEGIN
        IF InstructionIn(27 DOWNTO 25) = "101" THEN
            IF InstructionIn(31 DOWNTO 28) = "1011" THEN
                instr_courante <= BLT;
            ELSE
                instr_courante <= BAL;
            END IF;
        ELSIF InstructionIn(27 DOWNTO 26) = "01" THEN
            IF InstructionIn(20) = '0' THEN
                instr_courante <= STR;
            ELSE
                instr_courante <= LDR;
            END IF;
        ELSE
            opcode := InstructionIn(24 DOWNTO 21);
            CASE opcode IS
                WHEN "1010" =>
                    instr_courante <= CMP;
                WHEN "1101" =>
                    instr_courante <= MOV;
                WHEN "0100" =>
                    IF InstructionIn(25) = '0' THEN
                        instr_courante <= ADDr;
                    ELSE
                        instr_courante <= ADDi;
                    END IF;
                WHEN OTHERS =>
                    instr_courante <= MOV;
            END CASE;
        END IF;

        CASE instr_courante IS
            WHEN MOV =>
                nPCSel <= '0';
                RegWR <= '1';
                ALUSrc <= '1';
                AluCtr <= "001";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';

            WHEN ADDi =>
                nPCSel <= '0';
                RegWR <= '1';
                ALUSrc <= '1';
                AluCtr <= "000";
                PSREn <= '1';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';

            WHEN ADDr =>
                nPCSel <= '0';
                RegWR <= '1';
                ALUSrc <= '0';
                AluCtr <= "000";
                PSREn <= '1';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';

            WHEN CMP =>
                nPCSel <= '0';
                RegWR <= '0';
                ALUSrc <= '1';
                AluCtr <= "010";
                PSREn <= '1';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';

            WHEN BAL =>
                nPCSel <= '1';
                RegWR <= '0';
                ALUSrc <= '0';
                AluCtr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';

            WHEN BLT =>
                nPCSel <= PSR(31);
                RegWR <= '0';
                ALUSrc <= '0';
                AluCtr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegSel <= '0';
                RegAff <= '0';

            WHEN LDR =>
                nPCSel <= '0';
                RegWR <= '1';
                ALUSrc <= '1';
                AluCtr <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '1';
                RegSel <= '0';
                RegAff <= '0';

            WHEN STR =>
                nPCSel <= '0';
                RegWR <= '0';
                ALUSrc <= '1';
                AluCtr <= "000";
                PSREn <= '0';
                MemWr <= '1';
                WrSrc <= '0';
                RegSel <= '1';
                RegAff <= '1';
        END CASE;
    END PROCESS;
END ARCHITECTURE;