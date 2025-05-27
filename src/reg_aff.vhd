entity RegAff is
  port (
    Clk   : in  std_logic;
    Reset : in  std_logic;
    En    : in  std_logic;
    D     : in  std_logic_vector(31 downto 0);
    Q     : out STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
end entity RegAff;

architecture rtl of RegAff is
begin
  process (Clk, Reset)
  begin
    if Reset = '1' then
      Q <= (others => '0');
    elsif rising_edge(Clk) then
      if En = '1' then
        Q <= D(23 downto 0);
      end if;
    end if;
  end process;
end architecture rtl;