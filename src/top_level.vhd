LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY TOPLEVEL IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6)
    );
END ENTITY;

architecture rtl of TOPLEVEL is
    SIGNAL display : STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
    U_CPU : ENTITY work.CPU
        PORT MAP (
            CLK => CLK,
            Reset => Reset,
            reg_display => display
        );

    U_HEX0 : ENTITY work.SEVEN_SEG PORT MAP(
        Pol => '1',
        Segout => HEX0,
        Data => display(3 DOWNTO 0)
        );
    U_HEX1 : ENTITY work.SEVEN_SEG PORT MAP(
        Pol => '1',
        Segout => HEX1,
        Data => display(7 DOWNTO 4)
        );
    U_HEX2 : ENTITY work.SEVEN_SEG PORT MAP(
        Pol => '1',
        Segout => HEX2,
        Data => display(11 DOWNTO 8)
        );
    U_HEX3 : ENTITY work.SEVEN_SEG PORT MAP(
        Pol => '1',
        Segout => HEX3,
        Data => display(15 DOWNTO 12)
        );
end architecture rtl;