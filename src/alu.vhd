LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
    PORT (
        OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        N, Z, C, V : OUT STD_LOGIC
    );
END ALU;

ARCHITECTURE rtl OF ALU IS
    SIGNAL A_signed, B_signed : SIGNED(31 DOWNTO 0);
    SIGNAL A_ext, B_ext, R_ext : SIGNED(32 DOWNTO 0);
    SIGNAL R : SIGNED(31 DOWNTO 0);
    SIGNAL carry_bit, overflow_bit : STD_LOGIC;
    SIGNAL F : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    A_signed <= signed(A);
    B_signed <= signed(B);

    A_ext <= resize(A_signed, 33);
    B_ext <= resize(B_signed, 33);

    PROCESS (OP, A_signed, B_signed, A_ext, B_ext, R, R_ext)
    BEGIN
        carry_bit <= '0';
        overflow_bit <= '0';
        R_ext <= (OTHERS => '0');
        R <= (OTHERS => '0');

        CASE OP IS
            WHEN "000" =>
                R_ext <= A_ext + B_ext;
                R <= R_ext(31 DOWNTO 0);
                carry_bit <= R_ext(32);
                overflow_bit <= (NOT (A_signed(31) XOR B_signed(31))) AND (A_signed(31) XOR R(31));

            WHEN "001" =>
                R <= B_signed;

            WHEN "010" =>
                R_ext <= A_ext - B_ext;
                R <= R_ext(31 DOWNTO 0);
                carry_bit <= NOT R_ext(32);
                overflow_bit <= (A_signed(31) XOR B_signed(31)) AND (A_signed(31) XOR R(31));

            WHEN "011" =>
                R <= A_signed;

            WHEN "100" =>
                R <= A_signed OR B_signed;

            WHEN "101" =>
                R <= A_signed AND B_signed;

            WHEN "110" =>
                R <= A_signed XOR B_signed;

            WHEN "111" =>
                R <= NOT A_signed;

            WHEN OTHERS =>
                R <= (OTHERS => '0');
        END CASE;
    END PROCESS;

    S <= STD_LOGIC_VECTOR(R);
    F <= STD_LOGIC_VECTOR(R_ext(31 DOWNTO 0));
    N <= R(31);
    Z <= '1' WHEN R = 0 ELSE
        '0';
    C <= carry_bit;
    V <= overflow_bit;

END ARCHITECTURE;