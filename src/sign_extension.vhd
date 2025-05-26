LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY sign_extension IS
    GENERIC (
        N : INTEGER := 8
    );
    PORT (
        E : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END sign_extension;

ARCHITECTURE rtl OF sign_extension IS
BEGIN
    PROCESS (E)
        VARIABLE ext : STD_LOGIC_VECTOR(31 - N DOWNTO 0);
    BEGIN
        IF E(N - 1) = '1' THEN
            ext := (OTHERS => '1');
        ELSE
            ext := (OTHERS => '0');
        END IF;
        S <= ext & E;
    END PROCESS;
END rtl;