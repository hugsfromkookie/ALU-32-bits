library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_cska32 is
end tb_cska32;

architecture Behavioral of tb_cska32 is

component cska32 is
    Port (  A: in std_logic_vector(31 downto 0);
            B: in std_logic_vector(31 downto 0);
            S: out std_logic_vector(31 downto 0);
            Cin: in std_logic;
            Cout: out std_logic
);
end component;

signal A, B : std_logic_vector(31 downto 0);
signal S : std_logic_vector(31 downto 0);
signal Cin, Cout : std_logic;

begin

uut: cska32 port map (
        A => A,
        B => B,
        S => S,
        Cin => Cin,
        Cout => Cout
);

process
    begin
        -- Test Case 1
        A <= "00000000000000000000000000000000";
        B <= "00000000000000000000000000000000";
        Cin <= '0';
        wait for 10 ns;

        -- Test Case 2
        A <= "11111111111111111111111111111111";
        B <= "00000000000000000000000000000001";
        Cin <= '0';
        wait for 10 ns;

        -- Test Case 3
        A <= "10101010101010101010101010101010";
        B <= "01010101010101010101010101010101";
        Cin <= '1';
        wait for 10 ns;

        -- Test Case 4
        A <= "11111111111111111111111111111111";
        B <= "11111111111111111111111111111111";
        Cin <= '1';
        wait for 10 ns;
        
         -- Test Case 1
        A <= "00000000000000000000000000000001";
        B <= "00000000000000000000000000000010";
        Cin <= '0';
        wait for 10 ns;

        wait;
end process;

end Behavioral;
