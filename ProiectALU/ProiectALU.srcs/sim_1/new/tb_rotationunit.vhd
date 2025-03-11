library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_rotationunit is
end tb_rotationunit;

architecture Behavioral of tb_rotationunit is

component RotationUnit is
Port (  in1: in std_logic_vector(31 downto 0);
        in2: in std_logic_vector(31 downto 0);
        en: in std_logic;
        sel: in std_logic;
        out1: out std_logic_vector(31 downto 0)
);
end component;

signal in1: std_logic_vector(31 downto 0) := x"00000000";
signal in2: std_logic_vector(31 downto 0) := x"00000000";
signal en: std_logic := '0';
signal sel: std_logic := '0';
signal out1: std_logic_vector(31 downto 0);

begin

uut: RotationUnit port map (
        in1 => in1,
        in2 => in2,
        en => en,
        sel => sel,
        out1 => out1
);

p: process
    begin
        -- Test Case 1: Enable OFF, output x"00000000"
        en <= '0'; 
        in1 <= "10101010101010101010101010101010";
        in2 <= x"00000004";
        sel <= '0';
        wait for 10 ns;

        -- Test Case 2: Enable ON, rotate left by 1, output x"55555554"
        en <= '1'; 
        in1 <= "00101010101010101010101010101010";
        in2 <= "00000000000000000000000000000001";
        sel <= '0';
        wait for 10 ns;

        -- Test Case 3: Enable ON, rotate right by 4, output x"F00007FF"
        en <= '1'; 
        in1 <= "00000000000000000111111111111111";
        in2 <= "00000000000000000000000000000100";
        sel <= '1';
        wait for 10 ns;

        -- Test Case 4: Enable ON, rotate left by 0 (no rotation)
        en <= '1'; 
        in1 <= "01010101010101010101010101010101";
        in2 <= x"00000000";
        sel <= '0'; 
        wait for 10 ns;

        -- Test Case 5: Enable ON, rotate right by 32 (no rotation)
        en <= '1'; 
        in1 <= "01010101010101010101010101010101";
        in2 <= "00000000000000000000000000100000";
        sel <= '1'; 
        wait for 10 ns;

end process;

end Behavioral;
