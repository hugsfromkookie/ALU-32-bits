library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity division_entity is
Port ( clk: in  STD_LOGIC;
       reset: in  STD_LOGIC;
       start: in  STD_LOGIC;
       Dividend: in  STD_LOGIC_VECTOR(31 downto 0);
       Divisor: in  STD_LOGIC_VECTOR(31 downto 0);
       Quotient: out STD_LOGIC_VECTOR(31 downto 0);
       Remainder : out STD_LOGIC_VECTOR(31 downto 0);
       done: out STD_LOGIC
 );
end division_entity;

architecture Behavioral of division_entity is

signal remain: STD_LOGIC_VECTOR(32 downto 0) := (others => '0');
signal q_reg: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal divisor_reg: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal dividend_reg: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal count: INTEGER := 0;
signal active: STD_LOGIC := '0';

begin
    process(clk, reset)
        variable temp_remainder : STD_LOGIC_VECTOR(32 downto 0);  -- Temporary remainder (33 bits)
    begin
        if reset = '1' then
            remain <= (others => '0');
            q_reg <= (others => '0');
            divisor_reg <= (others => '0');
            dividend_reg <= (others => '0');
            count <= 0;
            active <= '0';
            done <= '0';
            
        elsif rising_edge(clk) then
            if start = '1' then
                if Dividend = X"00000000" or Divisor = X"00000000" then
                    remain <= (others => '0');
                    q_reg <= (others => '0');
                    active <= '0';
                    done <= '1';
                -- Initialize values when start is active
                else
                    remain <= (others => '0');
                    q_reg <= (others => '0');
                    divisor_reg  <= Divisor;
                    dividend_reg <= Dividend;
                    count <= 0;
                    active <= '1';
                    done <= '0';
                end if;
            elsif active = '1' then
                -- Shift remainder left and append next bit from dividend
                temp_remainder := remain(31 downto 0) & dividend_reg(31);  -- Shift left and append MSB
                temp_remainder := std_logic_vector(unsigned(temp_remainder) - unsigned("0" & divisor_reg));  -- Subtract divisor

                -- Update remainder and quotient
                if temp_remainder(32) = '0' then  -- If subtraction result is positive
                    remain(31 downto 0) <= temp_remainder(31 downto 0);    -- Update remainder
                    q_reg <= q_reg(30 downto 0) & '1';         -- Append '1' to quotient
                else
                    remain <= remain(31 downto 0) & dividend_reg(31);      -- Restore remainder
                    q_reg <= q_reg(30 downto 0) & '0';         -- Append '0' to quotient
                end if;

                -- Shift dividend left
                dividend_reg <= dividend_reg(30 downto 0) & '0';

                -- Increment counter and check completion
                if count = 31 then
                    active <= '0';  -- Division complete
                    done <= '1';
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    -- Output final values
    Quotient <= q_reg;
    Remainder <= remain(31 downto 0);

end Behavioral;