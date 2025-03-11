library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cska32 is
Port (  A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        S: out std_logic_vector(31 downto 0);
        Cin: in std_logic;
        Cout: out std_logic
);
end cska32;

architecture Behavioral of cska32 is

component RCA_8bits is
Port (  a, b : in std_logic_vector(7 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(7 downto 0);
        cout : out std_logic );
end component;

component propagation_block is
Port (  A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        P : out std_logic
    );
end component;

signal C8, C16, C24, P1, P2, and1, and2, or1, or2 : std_logic;

begin

s1: RCA_8bits port map(
    a => A(7 downto 0),
    b => B(7 downto 0),
    cin => Cin,
    s => S(7 downto 0),
    cout => C8
);

s2: RCA_8bits port map(
    a => A(15 downto 8),
    b => B(15 downto 8),
    cin => C8,
    s => S(15 downto 8),
    cout => C16
);

s3: RCA_8bits port map(
    a => A(23 downto 16),
    b => B(23 downto 16),
    cin => or1,
    s => S(23 downto 16),
    cout => C24
);

s4: RCA_8bits port map(
    a => A(31 downto 24),
    b => B(31 downto 24),
    cin => or2,
    s => S(31 downto 24),
    cout => Cout
);

prop1: propagation_block port map(
    A => A(15 downto 8),
    B => B(15 downto 8),
    P => P1
);

prop2: propagation_block port map(
    A => A(23 downto 16),
    B => B(23 downto 16),
    P => P2
);

and1 <= C8 AND P1;
or1 <= C16 OR and1;
and2 <= or1 AND P2;
or2 <= C24 OR and2;

end Behavioral;
