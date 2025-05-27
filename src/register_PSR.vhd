LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY register_PSR IS
    PORT (
        N, Z, C, V : IN STD_LOGIC;
        PSR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    );
END register_PSR;

ARCHITECTURE rtl OF instruction_decryptor IS
BEGIN
    PROCESS (N, Z, C, V)
    BEGIN
        PSR(3) <= N;
        PSR(2) <= Z;
        PSR(1) <= C;
        PSR(0) <= V;
    END PROCESS;
END ARCHITECTURE;