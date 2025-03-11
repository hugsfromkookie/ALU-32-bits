library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_8bits is
Port (  a, b : in std_logic_vector(7 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(7 downto 0);
        cout : out std_logic );
end RCA_8bits;

architecture Behavioral of RCA_8bits is

component full_adder_1bit
        Port ( 
            a, b, cin : in std_logic;
            s, cout : out std_logic
        );
end component;
    
signal c : std_logic_vector(7 downto 0); -- carry-uri intermediare

begin

    FA0: full_adder_1bit port map(a(0), b(0), cin, s(0), c(0));
    FA1: full_adder_1bit port map(a(1), b(1), c(0), s(1), c(1));
    FA2: full_adder_1bit port map(a(2), b(2), c(1), s(2), c(2));
    FA3: full_adder_1bit port map(a(3), b(3), c(2), s(3), c(3));
    FA4: full_adder_1bit port map(a(4), b(4), c(3), s(4), c(4));
    FA5: full_adder_1bit port map(a(5), b(5), c(4), s(5), c(5));
    FA6: full_adder_1bit port map(a(6), b(6), c(5), s(6), c(6));
    FA7: full_adder_1bit port map(a(7), b(7), c(6), s(7), cout);

end Behavioral;
