LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_cpu IS
END tb_cpu;

ARCHITECTURE sim OF tb_cpu IS
    COMPONENT CPU IS
        PORT (
            CLK : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
            HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
            HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
            HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6);
            HEX4 : OUT STD_LOGIC_VECTOR(0 TO 6);
            HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6)
        );
    END COMPONENT;

    -- Test bench signals
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Reset : STD_LOGIC := '0';
    SIGNAL HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : STD_LOGIC_VECTOR(0 TO 6);

    CONSTANT CLK_PERIOD : TIME := 10 ns;

BEGIN
    -- Instantiate CPU
    UUT : CPU PORT MAP(
        CLK => CLK,
        Reset => Reset,
        HEX0 => HEX0,
        HEX1 => HEX1,
        HEX2 => HEX2,
        HEX3 => HEX3,
        HEX4 => HEX4,
        HEX5 => HEX5
    );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        WHILE NOW < 1000 ns LOOP -- Run for 1000 ns
            CLK <= '0';
            WAIT FOR CLK_PERIOD/2;
            CLK <= '1';
            WAIT FOR CLK_PERIOD/2;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Initial reset
        Reset <= '0';
        WAIT FOR CLK_PERIOD * 2;
        Reset <= '1';

        -- Initialize Data Memory (0x20 to 0x2A)
        -- This will be done through the instruction memory
        -- The actual data initialization should be in the instruction memory file

        -- Wait for program execution
        WAIT FOR CLK_PERIOD * 1000; -- Wait enough cycles for program to complete

        -- Program should complete here
        -- The result should be visible on the HEX displays

        -- End simulation
        ASSERT FALSE REPORT "Test completed" SEVERITY FAILURE;
        WAIT;
    END PROCESS;

END ARCHITECTURE;