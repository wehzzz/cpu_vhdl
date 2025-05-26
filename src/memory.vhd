entity memory is
    Port (
        CLK : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Addr : in STD_LOGIC_VECTOR(5 DOWNTO 0);
        DataIn : in STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataOut : out STD_LOGIC_VECTOR(31 DOWNTO 0)
        WrEn : in STD_LOGIC;
    );
end memory;

ARCHITECTURE rtl OF memory IS
    -- Declaration Type Tableau Memoire 
    TYPE table IS ARRAY(63 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    FUNCTION init_banc RETURN table IS
        VARIABLE result : table;
    BEGIN
        FOR i IN 63 DOWNTO 0 LOOP
            result(i) := (OTHERS => '0');
        END LOOP;
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