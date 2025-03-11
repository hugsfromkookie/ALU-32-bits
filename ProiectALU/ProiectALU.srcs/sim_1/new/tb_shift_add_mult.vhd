library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity tb_shift_add_mult is

end entity tb_shift_add_mult;

architecture Behavioral of tb_shift_add_mult is

signal answer_out: std_logic_vector(63 downto 0);
signal a_in: std_logic_vector(31 downto 0);
signal ans_ready_out: std_logic := '0';
signal start_calc_in: std_logic := '0';
signal b_in: std_logic_vector(31 downto 0);
signal clk: std_logic := '0';
signal rst: std_logic := '1';
constant clk_period: time := 10 ns;

begin
	uut : entity work.multiplier_entity
		port map(
			answer_out => answer_out,
			ans_ready_out => ans_ready_out,
			a_in => a_in,
			b_in => b_in,
			start_calc_in => start_calc_in,
			clk => clk,
			rst => rst
		);

	clock_process : process
	begin
		clk <= '0';
		wait for clk_period / 2;
		clk <= '1';
		wait for clk_period / 2;
	end process clock_process;

	p : process
    begin
        -- Reset
        rst <= '0';
        wait for clk_period * 2;
        rst <= '1';
        wait for clk_period * 2;

        -- Test 1: Result: 0000_0000_FFFE_0001
        a_in <= std_logic_vector(to_unsigned(65535, 32));
        b_in <= std_logic_vector(to_unsigned(65535, 32));
        start_calc_in <= '1';
        wait for clk_period;
        start_calc_in <= '0';
        wait until ans_ready_out = '1';
        wait for clk_period;

--        -- Test 2: Result: 2540BE400
--        a_in <= std_logic_vector(to_unsigned(1000000, 32));
--        b_in <= std_logic_vector(to_unsigned(10000, 32));
--        start_calc_in <= '1';
--        wait for clk_period;
--        start_calc_in <= '0';
--        wait until ans_ready_out = '1';
--        wait for clk_period * 2;

--        -- Test 3: Result FFFFFFFE
--        a_in <= std_logic_vector(to_unsigned(2147483647, 32));
--        b_in <= std_logic_vector(to_unsigned(2, 32));
--        start_calc_in <= '1';
--        wait for clk_period * 2;
--        start_calc_in <= '0';
--        wait until ans_ready_out = '1';
--        wait for clk_period;

--        -- Test 4: A = 0, B = 10 (0 * 10 = 0)
--        a_in <= std_logic_vector(to_unsigned(0, 32));
--        b_in <= std_logic_vector(to_unsigned(10, 32));
--        start_calc_in <= '1';
--        wait for clk_period * 2;
--        start_calc_in <= '0';
--        wait until ans_ready_out = '1';
--        wait for clk_period * 2;

--        -- Test 5: A = 31, B = 31 (1 * 31 = 31)
--        a_in <= std_logic_vector(to_unsigned(1, 32));
--        b_in <= std_logic_vector(to_unsigned(31, 32));
--        start_calc_in <= '1';
--        wait for clk_period * 2;
--        start_calc_in <= '0';
--        wait until ans_ready_out = '1';
--        wait for clk_period * 2;

        wait;
    end process p;

end architecture Behavioral;
