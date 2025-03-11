library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RotationUnit is
Port (  in1: in std_logic_vector(31 downto 0);
        in2: in std_logic_vector(31 downto 0);
        en: in std_logic;
        sel: in std_logic;
        out1: out std_logic_vector(31 downto 0)
);
end RotationUnit;

architecture Behavioral of RotationUnit is

component shift_register is
Port (  i_clk: in  std_logic;
        i_rstb: in  std_logic;
        i_data: in  std_logic_vector(1 downto 0);
        o_data: out std_logic_vector(1 downto 0)
  );
end component;

signal shifted_data : std_logic_vector(31 downto 0);
signal shift_amount : integer;

begin
 
shift_amount <= to_integer(unsigned(in2(4 downto 0)));
 process(in1, in2, en, sel)
        variable shift_amount: integer;
    begin
        if en = '1' then
            -- Extract rotation amount from in2 (lower 5 bits)
            shift_amount := to_integer(unsigned(in2(4 downto 0)));

            if sel = '0' then
                -- Left rotation
                out1 <= in1(31-shift_amount downto 0) & in1(31 downto 32-shift_amount);
            else
                -- Right rotation
                out1 <= in1(shift_amount-1 downto 0) & in1(31 downto shift_amount);
            end if;
        else
            -- Output zeros when not enabled
            out1 <= (others => '0');
        end if;
    end process;

end Behavioral;
