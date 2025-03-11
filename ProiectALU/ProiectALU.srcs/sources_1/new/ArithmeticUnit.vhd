library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ArithmeticUnit is
Port (  
    A   : in  std_logic_vector(31 downto 0);
    B   : in  std_logic_vector(31 downto 0);
    Sel : in  std_logic_vector (2 downto 0);
    RA  : out std_logic_vector(63 downto 0);
    Cout : out std_logic;
    clk : in  std_logic;
    rst : in  std_logic;
    enable : in std_logic;
    Div_done:out std_logic;
    Mult_done: out std_logic
);
end ArithmeticUnit;

architecture Behavioral of ArithmeticUnit is

component cska32 is
Port (
    A: in std_logic_vector(31 downto 0);
    B: in std_logic_vector(31 downto 0);
    S: out std_logic_vector(31 downto 0);
    Cin: in std_logic;
    Cout: out std_logic
);
end component;

component multiplier_entity is
port(
    answer_out : out std_logic_vector(63 downto 0); -- Product
    ans_ready_out : out std_logic;
    a_in : in  std_logic_vector(31 downto 0); -- Multiplicand 
    b_in : in  std_logic_vector(31 downto 0); -- Multiplier
    start_calc_in : in  std_logic;
    clk : in  std_logic;
    rst : in  std_logic
);
end component;

component division_entity
Port (  
    clk: in  STD_LOGIC;
    reset: in  STD_LOGIC;
    start: in  STD_LOGIC;
    Dividend: in  STD_LOGIC_VECTOR(31 downto 0);
    Divisor: in  STD_LOGIC_VECTOR(31 downto 0);
    Quotient: out STD_LOGIC_VECTOR(31 downto 0);
    Remainder: out STD_LOGIC_VECTOR(31 downto 0);
    done: out STD_LOGIC
);
end component;

signal Cin_internal : std_logic;
signal S_internal: std_logic_vector(31 downto 0);
signal Cout_internal: std_logic;
signal B_comp2: std_logic_vector(31 downto 0);
signal Mult_result: std_logic_vector(63 downto 0);

signal Div_Quotient: std_logic_vector(31 downto 0);
signal Div_Remainder: std_logic_vector(31 downto 0);
signal RA_internal: std_logic_vector(63 downto 0);
signal Cout_internal_reg: std_logic;

signal div_done_int : std_logic := '0';
signal mul_done_int : std_logic := '0';

begin

add_sub: cska32 port map(
    A => A,
    B => B_comp2,
    S => S_internal,
    Cin => Cin_internal,
    Cout => Cout_internal
);

mult: multiplier_entity port map(
    answer_out => Mult_result,
    ans_ready_out => mul_done_int,
    a_in => A,
    b_in => B,
    start_calc_in  => enable, -- Activeazã doar dacã enable este 1
    clk => clk,
    rst => rst
);

div_unit: division_entity port map(
    clk => clk,
    reset => rst,
    start => enable, -- Activeazã doar dacã enable este 1
    Dividend => A,
    Divisor => B,
    Quotient => Div_Quotient,
    Remainder => Div_Remainder,
    done => div_done_int
);

Div_done <= div_done_int;
Mult_done <= mul_done_int;

process(clk, rst)
begin
    
    if rising_edge(clk) then
        if rst = '1' then
            RA_internal <= (others => '0');
            Cout_internal_reg <= '0';
        else
            case Sel is
                when "000" => -- Add
                    Cin_internal <= '0';
                    B_comp2 <= B;
                    RA_internal(31 downto 0) <= S_internal;
                    RA_internal(63 downto 32) <= (others => '0');
                    Cout_internal_reg <= Cout_internal;

                when "001" => -- Sub
                    Cin_internal <= '1';
                    B_comp2 <= not B;
                    RA_internal(31 downto 0) <= S_internal;
                    RA_internal(63 downto 32) <= (others => '0');
                    Cout_internal_reg <= Cout_internal;

                when "010" => -- Increment
                    Cin_internal <= '1';
                    B_comp2 <= (others => '0');
                    RA_internal(31 downto 0) <= S_internal;
                    RA_internal(63 downto 32) <= (others => '0');
                    Cout_internal_reg <= Cout_internal;

                when "011" => -- Decrement
                    B_comp2 <= "11111111111111111111111111111111";
                    Cin_internal <= '0';
                    RA_internal(31 downto 0) <= S_internal;
                    RA_internal(63 downto 32) <= (others => '0');
                    Cout_internal_reg <= Cout_internal;

                when "100" => -- Mul
                    RA_internal <= Mult_result;
                    Cout_internal_reg <= '0';

                when "101" => -- Div
                    if div_done_int = '1' then
                        RA_internal(31 downto 0)  <= Div_Quotient; 
                        RA_internal(63 downto 32) <= Div_Remainder;
                    end if;
                when others =>
                    RA_internal <= (others => '0');
                    Cout_internal_reg <= '0';
            end case;

        end if;
end if;
end process;

RA <= RA_internal;
Cout <= Cout_internal_reg;

end Behavioral;
