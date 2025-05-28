LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RegAff IS
  PORT (
    Clk : IN STD_LOGIC;
    Reset : IN STD_LOGIC;
    En : IN STD_LOGIC;
    D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Q : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END ENTITY RegAff;

ARCHITECTURE rtl OF RegAff IS
  -- Fonction pour extraire un chiffre décimal d'un entier
  FUNCTION get_digit(val : INTEGER; pos : INTEGER) RETURN STD_LOGIC_VECTOR IS
    VARIABLE digit : INTEGER;
  BEGIN
    digit := (val / (10 ** pos)) MOD 10;
    RETURN STD_LOGIC_VECTOR(to_unsigned(digit, 4));
  END;
BEGIN
  PROCESS (Clk, Reset)
    VARIABLE val_int : INTEGER;
    VARIABLE digits : STD_LOGIC_VECTOR(23 DOWNTO 0);
  BEGIN
    IF Reset = '1' THEN
      Q <= (OTHERS => '0');
    ELSIF rising_edge(Clk) THEN
      IF En = '1' THEN
        val_int := to_integer(unsigned(D));
        digits(3 DOWNTO 0) := get_digit(val_int, 0); -- unités
        digits(7 DOWNTO 4) := get_digit(val_int, 1); -- dizaines
        digits(11 DOWNTO 8) := get_digit(val_int, 2); -- centaines
        digits(15 DOWNTO 12) := get_digit(val_int, 3); -- milliers
        digits(19 DOWNTO 16) := get_digit(val_int, 4); -- dizaines de milliers
        digits(23 DOWNTO 20) := get_digit(val_int, 5); -- centaines de milliers
        Q <= digits;
      END IF;
    END IF;
  END PROCESS;
END ARCHITECTURE rtl;