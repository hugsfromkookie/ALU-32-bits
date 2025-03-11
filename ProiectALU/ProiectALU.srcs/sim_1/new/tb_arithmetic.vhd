library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_arithmetic is
end tb_arithmetic;

architecture Behavioral of tb_arithmetic is

    signal clk        : std_logic := '0';
    signal rst        : std_logic := '0';
    signal enable        : std_logic := '0';
    signal A          : std_logic_vector(31 downto 0) := (others => '0');
    signal B          : std_logic_vector(31 downto 0) := (others => '0');
    signal Sel        : std_logic_vector(2 downto 0) := (others => '0');
    signal RA         : std_logic_vector(63 downto 0);
    signal Cout       : std_logic;
    signal Div_done   : std_logic;
    signal Mult_done  : std_logic;

    constant clk_period : time := 10 ns;

    component ArithmeticUnit
        Port (  
            A   : in  std_logic_vector(31 downto 0);
            B   : in  std_logic_vector(31 downto 0);
            Sel : in  std_logic_vector (2 downto 0);
            RA  : out std_logic_vector(63 downto 0);
            Cout : out std_logic;
            clk: in  std_logic;
            rst: in  std_logic;
            enable : in std_logic;
            Div_done:out std_logic;
            Mult_done:out std_logic
        );
    end component;

begin

    uut: ArithmeticUnit
    port map (
        A => A,
        B => B,
        Sel => Sel,
        RA => RA,
        Cout => Cout,
        clk => clk,
        rst => rst,
        enable => enable,
        Div_done => Div_done,
        Mult_done => Mult_done 
    );

    clk_process : process
    begin
        while true loop
            clk <= not clk;
            wait for clk_period / 2;
        end loop;
    end process;

    stimulus_process : process
    begin
        -- Reset
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period;

--        -- Test case 1: Add
--        enable <= '1';
--        A <= X"00000010"; -- 16
--        B <= X"00000014"; -- 20
--        Sel <= "000";    -- Add
--        wait for 5 * clk_period;
--        enable <= '0';

--        -- Test case 2: Subtract
--        enable <= '1';
--        A <= X"00000020"; -- 32
--        B <= X"00000010"; -- 16
--        Sel <= "001";    -- Sub
--        wait for 5 * clk_period;
--        enable <= '0';
        
--        -- Test case 3: Increment
--        enable <= '1';
--        A <= X"000000FF"; -- 255
--        B <= X"00000001";
--        Sel <= "010";    -- Increment
--        wait for 5 * clk_period;
--        enable <= '0';

--        -- Test case 4: Decrement
--        enable <= '1';
--        A <= X"00000100"; -- 256
--        B <= X"00000001";
--        Sel <= "011";    -- Decrement
--        wait for 5 * clk_period;
--        enable <= '0';

--        -- Test case 3: Multiply
--        enable <= '1';
--        A <= X"00000004"; -- 4
--        B <= X"00000005"; -- 5
--        Sel <= "100";    -- Multiply
--        wait for 10*clk_period;
--        enable <= '0';
--        wait for  10*clk_period;

        -- Test case 6: Divide, x"0000000a000493fe"
        enable <= '1';
        A <= X"3B9ACA00"; -- 100000000
        B <= X"00000D05"; -- 4
        Sel <= "101";    -- Divide
        wait for  clk_period; 
        enable <= '0'; 
        wait for  15*clk_period;

--        -- Test case 6.1: Divide
--        enable <= '1';
--        A <= X"00000000";
--        B <= X"00000000";
--        Sel <= "101"; -- Divide
--        wait for  clk_period; 
--        enable <= '0'; 
--        wait for  15*clk_period;
        

        wait;
    end process;

end Behavioral;
