library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_propagation is
--  Port ( );
end tb_propagation;

architecture Behavioral of tb_propagation is

component propagation_block is
Port (  A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        P : out std_logic
    );
end component;

signal A, B : std_logic_vector(7 downto 0);
signal P: std_logic;
constant clk_period : time := 10 ns;

begin

prop: propagation_block port map (
            A => A,
            B => B,
            P => P
);

process
    begin
        A <= "11111111";
        B <= "11111111";
        wait for 10 ns;

        A <= "00000000";
        B <= "00000000";
        wait for 10 ns;

        A <= "10101010";
        B <= "01010101";
        wait for 10 ns;

        wait;
end process;

end Behavioral;
