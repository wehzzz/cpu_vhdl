LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity instruction_decryptor is
    PORT (
        InstructionIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PSR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        nPCSel, RegWR, ALUSrc, ALUCtr, PSREn, MemWr, WrSrc, RegSel, RegAff: OUT STD_LOGIC
    );
end instruction_decryptor;

architecture rtl of instruction_decryptor is
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
    signal instr_courante: enum_instruction;
begin
    process(InstructionIn, PSR)
        variable opcode: STD_LOGIC_VECTOR(3 DOWNTO 0);
    begin
        if InstructionIn(27 DOWNTO 25) = '101' then
            if InstructionIn(31 DOWNTO 28) = '1011' then
                instr_courante <= BLT;
            else
                instr_courante <= BAL;
            end if;
        elsif InstructionIn(27 DOWTO 26) = '01' then
            if InstructionIn(20) = '0' then
                instr_courante <= STR;
            else
                instr_courante <= LDR;
            end if;
        else
            opcode := InstructionIn(24 DOWNTO 21);
            case opcode is
                when "1101" =>
                    instr_courante <= MOV;
                when "0100" =>
                    if InstructionIn(25) = '0' then
                        instr_courante <= ADDr;
                    else
                        instr_courante <= ADDi;
                    end if;
                when others => 
                    instr_courante <= MOV;
            end case;
        end if;

        case instr_courante is
            when MOV =>
                nPCSel <= '0';
                RegWR  <= '1';
                ALUSrc <= '1';
                ALUCtr <= '001';
                PSREn  <= '0';
                MemWr  <= '0';
                WrSrc  <= '0';
                RegSel <= '0';
                RegAff <= '0';

            when ADDi =>
                nPCSel <= '0';
                RegWR  <= '1';
                ALUSrc <= '1';
                ALUCtr <= '000';
                PSREn  <= '1';
                MemWr  <= '0';
                WrSrc  <= '0';
                RegSel <= '0';
                RegAff <= '0';

            when ADDr =>
                nPCSel <= '0';
                RegWR  <= '1';
                ALUSrc <= '0';
                ALUCtr <= '000';
                PSREn  <= '1';
                MemWr  <= '0';
                WrSrc  <= '0';
                RegSel <= '0';
                RegAff <= '0';

            when CMP =>
                nPCSel <= '0';
                RegWR  <= '0';
                ALUSrc <= '1';
                ALUCtr <= '010';
                PSREn  <= '1';
                MemWr  <= '0';
                WrSrc  <= '0';
                RegSel <= '0';
                RegAff <= '0';

            when BAL =>
                nPCSel <= '1';
                RegWR  <= '0';
                ALUSrc <= '0';
                ALUCtr <= '000';
                PSREn  <= '0';
                MemWr  <= '0';
                WrSrc  <= '0';
                RegSel <= '0';
                RegAff <= '0';

            when BLT =>
                nPCSel <= PSR(31);
                RegWR  <= '0';
                ALUSrc <= '0';
                ALUCtr <= '000';
                PSREn  <= '0';
                MemWr  <= '0';
                WrSrc  <= '0';
                RegSel <= '0';
                RegAff <= '0';
            
            when LDR =>
                nPCSel <= '0';
                RegWR  <= '1';
                ALUSrc <= '1';
                ALUCtr <= '000';
                PSREn  <= '0';
                MemWr  <= '0';
                WrSrc  <= '1';
                RegSel <= '0';
                RegAff <= '0';
            
            when STR =>
                nPCSel <= '0';
                RegWR  <= '0';
                ALUSrc <= '1';
                ALUCtr <= '000';
                PSREn  <= '0';
                MemWr  <= '1';
                WrSrc  <= '0';
                RegSel <= '1';
                RegAff <= '1';
        end case;
    end process;
end architecture;