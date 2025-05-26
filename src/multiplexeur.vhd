LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity Multiplexeur is
    generic (
        N : integer := 32
    );
    Port (
        A, B, : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        COM : in std_logic;
        S : out STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
end Multiplexeur;

architecture rtl of Multiplexeur is
begin
    process(A, B, COM)
    begin
        if COM = '0' then
            S <= A;
        else
            S <= B;
        end if;
    end process;
end rtl;