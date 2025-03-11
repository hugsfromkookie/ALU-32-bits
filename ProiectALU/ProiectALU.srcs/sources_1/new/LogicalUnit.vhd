library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LogicalUnit is
Port (  in1: in std_logic_vector(31 downto 0);
        in2: in std_logic_vector(31 downto 0);
        en: in std_logic;
        sel: in std_logic_vector(1 downto 0);
        out1: out std_logic_vector(31 downto 0)
);
end LogicalUnit;

architecture Behavioral of LogicalUnit is

begin
 process(in1, in2, sel, en)
    begin
        if en = '1' then
            case sel is
                when "00" =>
                    out1 <= in1 or in2;
                when "01" =>
                    out1 <= in1 and in2;
                when "10" =>
                    out1 <= not in1;
                when others =>
                    out1 <= (others => '0');
            end case;
        else
            out1 <= (others => '0');
        end if;
    end process;

end Behavioral;
