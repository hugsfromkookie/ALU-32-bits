----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2025 12:52:39 AM
-- Design Name: 
-- Module Name: tb_alu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_alu is
--  Port ( );
end tb_alu;

architecture Behavioral of tb_alu is

component alu is
Port (  a: in std_logic_vector(31 downto 0);
        b: in std_logic_vector(31 downto 0);
        enable: in std_logic;
        sel: in std_logic_vector(3 downto 0);
        answer: out std_logic_vector(63 downto 0);
        clk: in std_logic;
        rst: std_logic
);
end component;

    signal clk        : std_logic := '0';
    signal rst        : std_logic := '0';
    signal enable     : std_logic := '0';
    signal a          : std_logic_vector(31 downto 0) := (others => '0');
    signal b          : std_logic_vector(31 downto 0) := (others => '0');
    signal sel        : std_logic_vector(3 downto 0) := (others => '0');
    signal answer     : std_logic_vector(63 downto 0);

    constant clk_period : time := 10 ns;

begin

uut:  alu port map(  
        a => a,
        b => b,
        enable => enable,
        sel => sel,
        answer => answer,
        clk => clk,
        rst => rst
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
        wait for 5*clk_period;
        
--        -- Test case 1: Rot stg, output x"55555554"
--        enable <= '1';
--        A <= "10101010101010101010101010101010";
--        B <= "00000000000000000000000000000001";
--        Sel <= "0000";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;

        -- Test case 1.1: Rot stg cu 0 (no rotation)
        enable <= '1';
        A <= "01010101010101010101010101010101";
        B <= "00000000000000000000000000000000";
        Sel <= "0000";
        wait for 5 * clk_period;
        enable <= '0';
        wait for  10*clk_period;
        
--        -- Test case 2: Rot dr, output x"00007F8"
--        enable <= '1';
--        A <= "00000000000000000111111110000000";
--        B <= "00000000000000000000000000000100";
--        Sel <= "0001";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;

        -- Test case 2.2: Rot dr cu 32 (no rotation)
        enable <= '1';
        A <= "01010000010111111000000010101010";
        B <= "00000000000000000000000000100000";
        Sel <= "0001";
        wait for 5 * clk_period;
        enable <= '0';
        wait for  10*clk_period;
        
--        -- Test case 3: OR, output x"2FFEABEB"
--        enable <= '1';
--        A <= "00101010101010101010101010101010";
--        B <= "00001101010101001010100101001001";
--        Sel <= "0010";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;
        
--        -- Test case 4: AND, output x"01001290"
--        enable <= '1';
--        A <= "00001001010101111101001010010101";
--        B <= "00000001000000000001101010010010";
--        Sel <= "0100";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;
        
--        -- Test case 5: NOT, output x"F6A82D6A"
--        enable <= '1';
--        A <= "00001001010101111101001010010101";
--        B <= X"00000000";
--        Sel <= "1000";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;
        
--        -- Test case 6: ADD, output x"18C72C3"
--        enable <= '1';
--        A <= x"00F37116";
--        B <= X"009901AD";
--        Sel <= "1010";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;
        
--        -- Test case 7: SUB, output x"EC49ADC"
--        enable <= '1';
--        A <= x"0F4DA9BC";
--        B <= X"00890EE0";
--        Sel <= "1110";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;
        
--        -- Test case 8: Increment, output x"0F4DA9BD"
--        enable <= '1';
--        A <= x"0F4DA9BC";
--        B <= X"00000000";
--        Sel <= "0110";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;
        
--       -- Test case 9: Decrement, output x"0F4DA9BB"
--        enable <= '1';
--        A <= x"0F4DA9BC";
--        B <= X"00000000";
--        Sel <= "0111";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;

        -- Test case 10: MUL, output x"A6F393F58F0C8E"
        enable <= '1';
        A <= X"0AABF94F";
        B <= X"0FA4EB12";
        Sel <= "1001";
        wait for clk_period;
        enable <= '0';
        wait for  15 * clk_period;


--        -- Test case 11:
--        enable <= '1';
--        A <= X"00000002";
--        B <= X"00000002";
--        Sel <= "1011";
--        wait for 5 * clk_period;
--        enable <= '0';
--        wait for  10*clk_period;



        wait;
    end process;

end Behavioral;
