library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity multiplier_entity is
    port(
        answer_out : out std_logic_vector(63 downto 0); --Product
        ans_ready_out : out std_logic;
        a_in : in  std_logic_vector(31 downto 0); --Multiplicand 
        b_in : in  std_logic_vector(31 downto 0); --Multiplier
        start_calc_in : in  std_logic;
        clk : in  std_logic;
        rst : in  std_logic
    );
end multiplier_entity;

architecture Behavioral of multiplier_entity is

type state is (wait_for_input_st, calculate_st);
signal current_state, next_state : state := wait_for_input_st;
signal ans_store : std_logic_vector(63 downto 0) := (others => '0');
signal a_store : std_logic_vector(63 downto 0):= (others => '0');
signal b_store : std_logic_vector(31 downto 0) := (others => '0');

signal sum_low  : std_logic_vector(31 downto 0);
signal carry_low, carry_in_low : std_logic := '0';
signal sum_high : std_logic_vector(31 downto 0);
signal carry_high, carry_in_high : std_logic := '0';

begin

    -- CSKA for low part of product
    cska_low: entity work.cska32
        port map (
            A    => ans_store(31 downto 0),
            B    => a_store(31 downto 0),
            S    => sum_low,
            Cin  => carry_in_low,
            Cout => carry_low
        );

    -- CSKA for high part of product
    cska_high: entity work.cska32
        port map (
            A    => ans_store(63 downto 32),
            B    => a_store(63 downto 32),
            S    => sum_high,
            Cin  => carry_low, -- Carry from low
            Cout => carry_high
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Reset
                current_state <= wait_for_input_st;
                ans_store <= (others => '0');
                a_store <= (others => '0');
                b_store <= (others => '0');
                answer_out <= (others => '0');
                ans_ready_out <= '0';
            else
                -- Update current state
                current_state <= next_state;
                case current_state is
                    when wait_for_input_st =>
                        -- Wait for input
                        ans_ready_out <= '0';
                        if start_calc_in = '1' then
                            -- Save input and calculate
                            a_store(63 downto 32) <= (others => '0');
                            a_store(31 downto 0) <= a_in;
                            b_store <= b_in;
                            ans_store <= (others => '0');
                            next_state <= calculate_st;
                        end if;

                    when calculate_st =>
                        if unsigned(b_store) = 0 then
                            -- Full calculation
                            ans_ready_out <= '1';
                            answer_out <= ans_store;
                            next_state <= wait_for_input_st;
                        else
                            -- Add low part
                            if b_store(0) = '1' then
                                ans_store(31 downto 0) <= sum_low;
                                ans_store(63 downto 32) <= sum_high;
                            end if;
                            -- Shift
                            a_store <= a_store(62 downto 0) & '0';
                            b_store <= '0' & b_store(31 downto 1);
                        end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
