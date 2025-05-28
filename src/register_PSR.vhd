LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY register_PSR IS
    PORT (
        N, Z, C, V, PSREn : IN STD_LOGIC;
        PSR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END register_PSR;

ARCHITECTURE rtl OF register_PSR IS
    SIGNAL PSR_temp : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (N, Z, C, V, PSREn, PSR_temp)
    BEGIN
        PSR_temp(31) <= PSR(31);
        PSR_temp(30) <= PSR(30);
        PSR_temp(29) <= PSR(29);
        PSR_temp(28) <= PSR(28);
        IF PSREn = '1' THEN
            PSR_temp(31) <= N;
            PSR_temp(30) <= Z;
            PSR_temp(29) <= C;
            PSR_temp(28) <= V;
        END IF;
    END PROCESS;
    PSR <= PSR_temp;
END ARCHITECTURE;