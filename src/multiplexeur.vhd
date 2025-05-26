LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Multiplexeur IS
    GENERIC (
        N : INTEGER := 32
    );
    PORT (
        A, B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        COM : IN STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
END Multiplexeur;

ARCHITECTURE rtl OF Multiplexeur IS
BEGIN
    PROCESS (A, B, COM)
    BEGIN
        IF COM = '0' THEN
            S <= A;
        ELSE
            S <= B;
        END IF;
    END PROCESS;
END rtl;