LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY command_register IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        DataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        WE : IN STD_LOGIC
    );
END command_register;

ARCHITECTURE rtl OF command_register IS
    SIGNAL reg : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            reg <= (OTHERS => '0');
        ELSIF rising_edge(CLK) THEN
            IF WE = '1' THEN
                reg <= DataIn;
            END IF;
            DataOut <= reg;
        END IF;
    END PROCESS;

END ARCHITECTURE;