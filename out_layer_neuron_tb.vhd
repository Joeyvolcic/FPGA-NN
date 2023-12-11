library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.components.all;

entity out_layer_neuron_tb is
end out_layer_neuron_tb;

architecture Behavioral of out_layer_neuron_tb is

signal a21, a22, a23, a24, a25, a26, i21, i22, i23, i24, i25, i26, learn_rate, targR, predR : std_logic_vector(31 downto 0);
signal sel_init, load_Wij, clk, clr : std_logic;

begin

test : Output_Layer_Neuron port map
(
    activation_21 => a21,
    activation_22 => a22,
    activation_23 => a23,
    activation_24 => a24,
    activation_25 => a25,
    activation_26 => a26,
    initialize_W21 => i21,
    initialize_W22 => i22,
    initialize_W23 => i23,
    initialize_W24 => i24,
    initialize_W25 => i25,
    initialize_W26 => i26,
    sel_init => sel_init,
    load_Wij => load_Wij,
    clr => clr,
    clk => clk,
    learning_Rate => learn_rate,
    targetR => targR,
    predictedR => predR
);

clock : process
begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
end process;

tb : process
begin
    clr <= '1'; sel_init <= '1'; load_Wij <= '1'; wait for 10 ns;
    clr <= '0'; 
    i21 <= "00000000011011100001010001111010"; --0.43
    i22 <= "00000000101111010111000010100011"; --0.74
    i23 <= "00000000010010100011110101110000"; --0.29
    i24 <= "00000000100000101000111101011100"; --0.51
    i25 <= "00000000100101110000101000111101"; --0.59
    i26 <= "00000000110011001100110011001100"; --0.80
    a21 <= "00000000101000010100011110101110"; --0.63
    a22 <= "00000000000000101000111101011100"; --0.01
    a23 <= "00000000111111010111000010100011"; --0.99
    a24 <= "00000000001110101110000101000111"; --0.23
    a25 <= "00000000100011001100110011001100"; --0.55
    a26 <= "00000000000111101011100001010001"; --0.12
    learn_rate <= "00000000101010111000010100011110"; --0.67 
    targR <= "00000000011100110011001100110011"; --0.45
    wait for 50 ns;
    sel_init <= '0'; wait for 50 ns; --hand calculated output: 
end process;

end Behavioral;
