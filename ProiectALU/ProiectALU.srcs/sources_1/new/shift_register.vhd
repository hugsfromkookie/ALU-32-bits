library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
Port (  i_clk: in  std_logic;
        i_rstb: in  std_logic;
        i_data: in  std_logic_vector(1 downto 0);
        o_data: out std_logic_vector(1 downto 0)
  );
end shift_register;

architecture Behavioral of shift_register is

type t_sreg is array(0 to 3) of std_logic_vector(1 downto 0);
signal r_data: t_sreg;

begin

o_data <= r_data(r_data'length-1);
process(i_clk, i_rstb)
begin
  if (i_rstb = '0') then
    r_data <= (others => (others => '0'));
  elsif (rising_edge(i_clk)) then
    r_data(0)<= i_data;
    for idx in 1 to r_data'length-1 loop
      r_data(idx) <= r_data(idx-1); -- shift right
    end loop;
  end if;
end process;

end Behavioral;
