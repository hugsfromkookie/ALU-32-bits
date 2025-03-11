library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_1bit is
Port (  a, b, cin: in std_logic;
        s, cout: out std_logic);
end full_adder_1bit;

architecture Behavioral of full_adder_1bit is

signal s1, s2, s3, s4: std_logic;

begin
    s1 <= b xor cin;
    s2 <= a and b;
    s3 <= a and cin;
    s4 <= b and cin;
    s <= a xor s1;
    cout <= s2 or s3 or s4;
    
end Behavioral;
