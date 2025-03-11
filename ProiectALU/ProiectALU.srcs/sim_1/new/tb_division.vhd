library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_division is
end tb_division;

architecture Behavioral of tb_division is

signal clk        : STD_LOGIC := '0';
signal reset      : STD_LOGIC := '0';
signal start      : STD_LOGIC := '0';
signal Dividend   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal Divisor    : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal Quotient   : STD_LOGIC_VECTOR(31 downto 0);
signal Remainder  : STD_LOGIC_VECTOR(31 downto 0);
signal done       : STD_LOGIC;

constant clk_period : time := 100 ps;

component division_entity
Port (  clk: in  STD_LOGIC;
        reset: in  STD_LOGIC;
        start: in  STD_LOGIC;
        Dividend: in  STD_LOGIC_VECTOR(31 downto 0);
        Divisor: in  STD_LOGIC_VECTOR(31 downto 0);
        Quotient: out STD_LOGIC_VECTOR(31 downto 0);
        Remainder: out STD_LOGIC_VECTOR(31 downto 0);
        done: out STD_LOGIC
);
end component;

begin
    uut: division_entity
port map(   clk  => clk,
            reset => reset,
            start => start,
            Dividend => Dividend,
            Divisor => Divisor,
            Quotient => Quotient,
            Remainder => Remainder,
            done => done
);

process
    begin
        while true loop
            clk <= not clk;
            wait for CLK_PERIOD / 2;
        end loop;
end process;

process
begin
    reset <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for CLK_PERIOD;

    -- Test Case 1: 20 / 4
    Dividend <= X"00000014";
    Divisor  <= X"00000004";
    start <= '1';
    wait for CLK_PERIOD;
    start <= '0';
    wait until done = '1';
    wait for 5 * CLK_PERIOD;

    reset <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for CLK_PERIOD;

    -- Test Case 2: 35 / 6, expected 5 & 5
    Dividend <= X"00000023";
    Divisor  <= X"00000006";
    start <= '1';
    wait for CLK_PERIOD;
    start <= '0';
    wait until done = '1';
    wait for 5 * CLK_PERIOD;

    reset <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for CLK_PERIOD;

    -- Test Case 3: 1000000000 / 333, expected 493FE & A
    Dividend <= X"3B9ACA00";
    Divisor  <= X"00000D05";
    start <= '1';
    wait for CLK_PERIOD;
    start <= '0';
    wait until done = '1';
    wait for 5 * CLK_PERIOD;

    reset <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for CLK_PERIOD;

    -- Test Case 4: 0 / 5
    Dividend <= X"00000000";
    Divisor  <= X"00000005";
    start <= '1';
    wait for CLK_PERIOD;
    start <= '0';
    wait until done = '1';
    wait for 5 * CLK_PERIOD;

    reset <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for CLK_PERIOD;

    -- Test Case 5: 7 / 7
    Dividend <= X"00000007";
    Divisor  <= X"00000007";
    start <= '1';
    wait for CLK_PERIOD;
    start <= '0';
    wait until done = '1';
    wait for 5 * CLK_PERIOD;

    reset <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for CLK_PERIOD;
    
    reset <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for CLK_PERIOD;

    -- Test Case 5: 4294967295 / 285212672, expected F & FFFFFF
    Dividend <= X"FFFFFFFF";
    Divisor  <= X"11000000";
    start <= '1';
    wait for CLK_PERIOD;
    start <= '0';
    wait for 5 * CLK_PERIOD;
    
    wait;

end process;

end Behavioral;