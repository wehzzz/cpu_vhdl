LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Banc_Registres IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        W : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RA : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        WE : IN STD_LOGIC;

        A : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        B : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF Banc_Registres IS
    TYPE table IS ARRAY(15 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    FUNCTION init_banc RETURN table IS
        VARIABLE result : table;
    BEGIN
        FOR i IN 14 DOWNTO 0 LOOP
            result(i) := (OTHERS => '0');
        END LOOP;
        result(15) := X"00000030";
        RETURN result;
    END init_banc; 
    SIGNAL Banc : table := init_banc;
BEGIN
    A <= Banc(to_integer(unsigned(RA)));
    B <= Banc(to_integer(unsigned(RB)));

    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            Banc <= init_banc;
        ELSIF rising_edge(CLK) THEN
            IF WE = '1' THEN
                Banc(to_integer(unsigned(RW))) <= W;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;