library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_logicalunit is
--  Port ( );
end tb_logicalunit;

architecture Behavioral of tb_logicalunit is

component LogicalUnit is
Port (  in1: in std_logic_vector(31 downto 0);
        in2: in std_logic_vector(31 downto 0);
        en: in std_logic;
        sel: in std_logic_vector(1 downto 0);
        out1: out std_logic_vector(31 downto 0)
);
end component;

signal in1: std_logic_vector(31 downto 0) := (others => '0');
signal in2: std_logic_vector(31 downto 0) := (others => '0');
signal en: std_logic := '0';
signal sel: std_logic_vector(1 downto 0) := "00";
signal out1: std_logic_vector(31 downto 0);

begin

uut: LogicalUnit
        Port map (
            in1 => in1,
            in2 => in2,
            en => en,
            sel => sel,
            out1 => out1
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1: Enable OFF
        en <= '0'; 
        sel <= "00"; 
        in1 <= "10101010101010101010101010101010"; 
        in2 <= "00000000000000011111111111111111";
        wait for 10 ns;
        
        -- Test Case 2: Enable ON, OR op
        en <= '1'; 
        sel <= "00"; 
        wait for 10 ns;
        
        -- Test Case 3: Enable ON, AND op
        sel <= "01"; 
        wait for 10 ns;
        
        -- Test Case 4: Enable ON, NOT op
        sel <= "10"; 
        wait for 10 ns;
        
        -- Test Case 5: Invalid sel value
        sel <= "11"; 
        wait for 10 ns;

        -- Test Case 6: Enable OFF
        en <= '0'; 
        wait for 10 ns;

        wait;
end process;

end Behavioral;
