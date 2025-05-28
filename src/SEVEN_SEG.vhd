-- SevenSeg.vhd
-- ------------------------------
--   squelette de l'encodeur sept segment
-- ------------------------------

--
-- Notes :
--  * We don't ask for an hexadecimal decoder, only 0..9
--  * outputs are active high if Pol='1'
--    else active low (Pol='0')
--  * Order is : Segout(1)=Seg_A, ... Segout(7)=Seg_G
--
--  * Display Layout :
--
--       A=Seg(1)
--      -----
--    F|     |B=Seg(2)
--     |  G  |
--      -----
--     |     |C=Seg(3)
--    E|     |
--      -----
--        D=Seg(4)
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- ------------------------------
ENTITY SEVEN_SEG IS
  -- ------------------------------
  PORT (
    Data : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Expected within 0 .. 9
    Pol : IN STD_LOGIC; -- '0' if active LOW
    Segout : OUT STD_LOGIC_VECTOR(1 TO 7)); -- Segments A, B, C, D, E, F, G
END ENTITY SEVEN_SEG;

-- -----------------------------------------------
ARCHITECTURE COMB OF SEVEN_SEG IS
  -- ------------------------------------------------

BEGIN
  PROCESS (Data, Pol)
  BEGIN
    IF Pol = '1' THEN
      CASE Data IS
        WHEN "0000" => Segout <= "0000001"; -- 0
        WHEN "0001" => Segout <= "1001111"; -- 1
        WHEN "0010" => Segout <= "0010010"; -- 2
        WHEN "0011" => Segout <= "0000110"; -- 3
        WHEN "0100" => Segout <= "1001100"; -- 4
        WHEN "0101" => Segout <= "0100100"; -- 5
        WHEN "0110" => Segout <= "0100000"; -- 6
        WHEN "0111" => Segout <= "0001111"; -- 7
        WHEN "1000" => Segout <= "0000000"; -- 8
        WHEN "1001" => Segout <= "0000100"; -- 9
        WHEN "1010" => Segout <= "0001000"; -- A
        WHEN "1011" => Segout <= "1100000"; -- B
        WHEN "1100" => Segout <= "0110001"; -- C
        WHEN "1101" => Segout <= "1000010"; -- D
        WHEN "1110" => Segout <= "0110000"; -- E
        WHEN "1111" => Segout <= "0111000"; -- F
        WHEN OTHERS => Segout <= "1111111"; -- Blank
      END CASE;
    ELSE
      CASE Data IS
        WHEN "0000" => Segout <= "1111110"; -- 0
        WHEN "0001" => Segout <= "0110000"; -- 1
        WHEN "0010" => Segout <= "1101101"; -- 2
        WHEN "0011" => Segout <= "1111001"; -- 3
        WHEN "0100" => Segout <= "0110011"; -- 4
        WHEN "0101" => Segout <= "1011011"; -- 5
        WHEN "0110" => Segout <= "1011111"; -- 6
        WHEN "0111" => Segout <= "1110000"; -- 7
        WHEN "1000" => Segout <= "1111111"; -- 8
        WHEN "1001" => Segout <= "1111011"; -- 9
        WHEN "1010" => Segout <= "1110111"; -- A
        WHEN "1011" => Segout <= "0011111"; -- B
        WHEN "1100" => Segout <= "1001110"; -- C
        WHEN "1101" => Segout <= "0111101"; -- D
        WHEN "1110" => Segout <= "1001111"; -- E
        WHEN "1111" => Segout <= "1000111"; -- F
        WHEN OTHERS => Segout <= "0000000"; -- Blank
      END CASE;
    END IF;
  END PROCESS;
END ARCHITECTURE COMB;