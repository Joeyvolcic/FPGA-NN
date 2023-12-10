library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.components.all;

entity Hidden_Layer_Neuron is
    --Port ( );
end Hidden_Layer_Neuron;

architecture Behavioral of Hidden_Layer_Neuron is

--W1Blk
signal initialize_Wij, sensitivity, activation_L1, learning_Rate, Wij:std_logic_vector(31 downto 0);
signal sel_init,load_Wij,clr,clk: std_logic;

--FPassNeruon
signal W1,W2,W3,W4,W5,W6,W7,W8: std_logic_vector(31 downto 0);
signal a1,a2,a3,a4,a5,a6,a7,a8,aout: std_logic_vector(31 downto 0);
signal a_Prime: std_logic;

--BPassNeuron
signal nextW1,nextW2,nextW3,nextW4,nextW5,nextW6,nextW7,nextW8: std_logic_vector(31 downto 0);
signal nextSens1,nextSens2,nextSens3,nextSens4,nextSens5,nextSens6,nextSens7,nextSens8: std_logic_vector(31 downto 0);
signal activationPrev: std_logic_vector(31 downto 0);
signal prevLayerSens: std_logic_vector(31 downto 0);

begin

-- Fix all inputs and ouputs for port maps only

W1Blk: weight port map(initialize_Wij => initialize_Wij, sensitivity => sensitivity, activation_L1 => activation_L1,
                       learning_Rate => learning_Rate, Wij => Wij, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );
                       
FPassNeuron: Forward_Pass_Neuron_Hidden port map( W1 => W1, W2 => W2, W3 => W3, W4 => W4, W5 => W5, W6 => W6, W7 => W7, W8 => W8,
                                                  a1 => a1, a2 => a2, a3 => a3, a4 => a4, a5 => a5, a6 => a6, a7 => a7, a8 => a8,
                                                  aout => aout, a_Prime => a_Prime
                                                  );
                                                  
BPassNeuron: Back_Propagation_Neuron_Hidden port map(nextW1 => nextW1, nextW2 => nextW2, nextW3 => nextW3, nextW4 => nextW4,
                                                     nextW5 => nextW5, nextW6 => nextW6, nextW7 => nextW7, nextW8 => nextW8,
                                                     nextSens1 => nextSens1, nextSens2 => nextSens2, nextSens3 => nextSens3, nextSens4 => nextSens4,
                                                     nextSens5 => nextSens5, nextSens6 => nextSens6, nextSens7 => nextSens7, nextSens8 => nextSens8,
                                                     activationPrev => activationPrev, prevLayerSens => prevLayerSens
                                                     );

end Behavioral;
