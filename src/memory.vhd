LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY memory IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Addr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        DataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        WrEn : IN STD_LOGIC
    );
END memory;

ARCHITECTURE rtl OF memory IS
    TYPE table IS ARRAY(63 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    FUNCTION init_banc RETURN table IS
        VARIABLE result : table;
    BEGIN
        FOR i IN 63 DOWNTO 0 LOOP
            IF (i >= 16#20# AND i <= 16#2A#) THEN
                result(i) := "00000000000000000000000000000010";
            ELSE
                result(i) := (OTHERS => '0');
            END IF;        END LOOP;
        RETURN result;
    END init_banc;
    SIGNAL Banc : table := init_banc;
BEGIN
    DataOut <= Banc(to_integer(unsigned(Addr)));

    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            Banc <= init_banc;
        ELSIF rising_edge(CLK) THEN
            IF WrEn = '1' THEN
                Banc(to_integer(unsigned(Addr))) <= DataIn;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;