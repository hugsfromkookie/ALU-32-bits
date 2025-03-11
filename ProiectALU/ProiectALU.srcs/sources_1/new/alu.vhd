library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
Port (  a: in std_logic_vector(31 downto 0);
        b: in std_logic_vector(31 downto 0);
        enable: in std_logic;
        sel: in std_logic_vector(3 downto 0);
        answer: out std_logic_vector(63 downto 0);
        clk: in std_logic;
        rst: std_logic
);
end alu;

architecture Behavioral of alu is

component RotationUnit is
Port (  in1: in std_logic_vector(31 downto 0);
        in2: in std_logic_vector(31 downto 0);
        en: in std_logic;
        sel: in std_logic;
        out1: out std_logic_vector(31 downto 0)
);
end component;

component LogicalUnit is
Port (  in1: in std_logic_vector(31 downto 0);
        in2: in std_logic_vector(31 downto 0);
        en: in std_logic;
        sel: in std_logic_vector(1 downto 0);
        out1: out std_logic_vector(31 downto 0)
);
end component;

component ArithmeticUnit is
Port (  
    A   : in  std_logic_vector(31 downto 0);
    B   : in  std_logic_vector(31 downto 0);
    Sel : in  std_logic_vector (2 downto 0);
    RA  : out std_logic_vector(63 downto 0);
    Cout : out std_logic;
    clk : in  std_logic;
    rst : in  std_logic;
    enable : in std_logic;
    Div_done:out std_logic;
    Mult_done: out std_logic
);
end component;

signal rot_out: std_logic_vector(31 downto 0);
signal log_out: std_logic_vector(31 downto 0);
signal art_out: std_logic_vector(63 downto 0);

signal enable_rot, enable_log, enable_art, cout_int, div_done, mult_done : std_logic := '0';
signal sel_rot: std_logic := '0';
signal sel_log : std_logic_vector(1 downto 0) := (others => '0');
signal sel_art : std_logic_vector(2 downto 0) := (others => '0');

begin

    rotation_inst : RotationUnit
        port map (
            in1 => a,
            in2 => b,
            en => enable_rot,
            sel => sel_rot,
            out1 => rot_out
        );

    logical_inst : LogicalUnit
        port map (
            in1 => a,
            in2 => b,
            en => enable_log,
            sel => sel_log,
            out1 => log_out
        );
               
arithmetic_inst : ArithmeticUnit port map (  
    A  => a,
    B  => b,
    Sel => sel_art,
    RA  => art_out,
    Cout => cout_int,
    clk => clk,
    rst => rst,
    enable => enable_art,
    Div_done => div_done,
    Mult_done => mult_done
);
        
process(clk)
begin
   if rising_edge(clk) then
        if rst = '1' then
            enable_rot <= '0';
            sel_rot <= '0';
            enable_log <= '0';
            sel_log <= "00";
            enable_art <= '0';
            sel_art <= "000";
            div_done <= '0';
            mult_done <= '0';
     else   
    case sel is
        when "0000" =>  -- Rotatie stanga
            enable_rot <= '1';
            sel_rot <= '0';
            answer(63 downto 0) <= (others => '0');
            answer(31 downto 0) <= rot_out;

        when "0001" =>  -- Rotatie dreapta
            enable_rot <= '1';
            sel_rot <= '1';
            answer(63 downto 0) <= (others => '0');
            answer(31 downto 0) <= rot_out;

        when "0010" =>  -- OR
            enable_log <= '1';
            sel_log <= "00";
            answer(63 downto 0) <= (others => '0');
            answer(31 downto 0) <= log_out;

        when "0100" =>  -- AND
            enable_log <= '1';
            sel_log <= "01";
            answer(63 downto 0) <= (others => '0');
            answer(31 downto 0) <= log_out;

        when "1000" =>  -- NOT
            enable_log <= '1';
            sel_log <= "10";
            answer(63 downto 0) <= (others => '0');
            answer(31 downto 0) <= log_out;

        when "1001" => --Inmultire
            enable_art <= '1';
            sel_art <= "100";
            answer <= art_out;
            
        when "1010" =>  -- Adunare
            enable_art <= '1';
            sel_art <= "000";
            answer <= art_out;
            
         when "1110" =>  -- Scadere
            enable_art <= '1';
            sel_art <= "001";
            answer <= art_out;
            
         when "0110" =>  -- Increment
            enable_art <= '1';
            sel_art <= "010";
            answer <= art_out;
            
         when "0111" =>  -- Decrement
            enable_art <= '1';
            sel_art <= "011";
            answer <= art_out;
            
        when "1011" => --Div
            enable_art <= '1';
            sel_art <= "101";
            answer <= art_out;

        when others =>  -- Default case
            enable_rot <= '0';
            sel_rot <= '0';
            enable_log <= '0';
            sel_log <= "00";
    end case;
end if;
end if;
end process;

        


end Behavioral;
