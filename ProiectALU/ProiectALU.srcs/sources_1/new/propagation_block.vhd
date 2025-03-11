library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity propagation_block is
Port (  A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        P : out std_logic
    );
end propagation_block;

architecture Behavioral of propagation_block is

signal P_bits : STD_LOGIC_VECTOR(7 downto 0);

begin

P_bits <= A AND B;
P <= '1' when P_bits = "11111111" else '0';

end Behavioral;
