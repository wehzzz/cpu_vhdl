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
    process(InstructionIn)
        variable opcode: STD_LOGIC_VECTOR(3 DOWNTO 0);
    begin
        opcode := InstructionIn(24 DOWNTO 21);
        case opcode is
            when "1101" => -- MOV
                instr_courante <= MOV;
            when "0100" => -- ADDi
                instr_courante <= ADDi;
            when "0100" => -- ADDr
                instr_courante <= ADDr;
            when "0011" => -- CMP
                instr_courante <= CMP;
            when "0100" => -- LDR
                instr_courante <= LDR;
            when "0101" => -- STR
                instr_courante <= STR;
            when "1010" => -- BAL
                instr_courante <= BAL;
            when "1010" => -- BLT
                instr_courante <= BLT;
            when others =>
                instr_courante <= MOV; -- Default case
        end case;

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
                nPCSel <= N;
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