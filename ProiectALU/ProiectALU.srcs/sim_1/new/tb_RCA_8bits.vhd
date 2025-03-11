library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_RCA_8bits is
end tb_RCA_8bits;

architecture behavior of tb_RCA_8bits is
component RCA_8bits
    Port (  a, b : in std_logic_vector(7 downto 0);
            cin : in std_logic;
            s : out std_logic_vector(7 downto 0);
            cout : out std_logic );
end component;

signal a : std_logic_vector(7 downto 0) := (others => '0');
signal b : std_logic_vector(7 downto 0) := (others => '0');
signal cin : std_logic := '0';
signal s : std_logic_vector(7 downto 0);
signal cout : std_logic;

begin
    uut: RCA_8bits port map (
            a => a, 
            b => b, 
            cin => cin, 
            s => s, 
            cout => cout
);

process
    begin
        -- Test case 1
        a <= "00000001"; b <= "00000001"; cin <= '0';
        wait for 10 ns;

        -- Test case 2
        a <= "01010101"; b <= "10101010"; cin <= '1';
        wait for 10 ns;

        -- Test case 3
        a <= "11111111"; b <= "00000001"; cin <= '0';
        wait for 10 ns;

        -- Test case 4
        a <= "00000000"; b <= "00000000"; cin <= '1';
        wait for 10 ns;

        -- Test case 5
        a <= "11001100"; b <= "00110011"; cin <= '0';
        wait for 10 ns;

        -- End simulation
        wait;
end process;

end behavior;
