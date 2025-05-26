LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        E: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        S: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end PC;

architecture rtl of PC is
    signal PC_value: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
begin
    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            PC_value <= (OTHERS => '0');
        ELSIF rising_edge(CLK) THEN
            PC_value <= E;
        END IF;
    END PROCESS;

    S <= PC_value;

end rtl;