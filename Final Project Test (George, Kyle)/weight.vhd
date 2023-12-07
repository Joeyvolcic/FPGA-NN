library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.components.all;


entity weight is
  Port (initialize_Wij: in std_logic_vector(15 downto 0);
        sel_init: in std_logic;
        load_Wij: in std_logic;
        clr: in std_logic;
        clk: in std_logic;
        sensitivity: in std_logic_vector(15 downto 0);
        activation_L1: in std_logic_vector(15 downto 0);
        learning_Rate: in std_logic_vector(15 downto 0);
        Wij: out std_logic_vector(15 downto 0)
        );
end weight;

architecture Behavioral of weight is

signal muxOut: std_logic_vector(15 downto 0);
signal new_Wij: std_logic_vector(15 downto 0);
signal Weight_ij: std_logic_vector(15 downto 0);
signal multOut: std_logic_vector(47 downto 0);


begin

mux88: Mux2to1 generic map(N => 16) port map(a => new_Wij(15 downto 0), b => initialize_Wij, s => sel_init, y => muxOut);
Regx: Reg generic map(N => 16) port map(load => Load_Wij, input => muxOut, clk => clk, clr => clr, q => Weight_ij);

multOut <= activation_L1 * sensitivity * learning_Rate;

new_Wij <= multOut - Weight_ij;


Wij <= new_Wij(15 downto 0);

end Behavioral;
