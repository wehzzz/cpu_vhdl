LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY register_PSR IS
    PORT (
        N, Z, C, V, PSREn : IN STD_LOGIC;
        PSR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    );
END register_PSR;

ARCHITECTURE rtl OF instruction_decryptor IS
BEGIN
    PROCESS (N, Z, C, V)
    BEGIN
        IF PSREn = '1' THEN
            PSR(31) <= N;
            PSR(30) <= Z;
            PSR(29) <= C;
            PSR(28) <= V;
        END IF;
    END PROCESS;
END ARCHITECTURE;