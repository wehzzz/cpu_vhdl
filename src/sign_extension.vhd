LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity sign_extension is
    generic (
        N : integer := 32
    );
    Port (
        E : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        S : out STD_LOGIC_VECTOR(32 DOWNTO 0)
    );
end sign_extension;

architecture rtl of sign_extension is
begin
    process(E)
    begin
        if E(N-1) = '1' then
            S <= (others => '1') & E;
        else
            S <= (others => '0') & E;
        end if;
    end process;
end rtl;