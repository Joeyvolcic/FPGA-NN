library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.components.all;

entity Hidden_Layer_Neuron is
    Port (activation_11, activation_12, activation_13, activation_14, activation_15, activation_16, activation_17, activation_18: in std_logic_vector(31 downto 0);
          initialize_W11,initialize_W12, initialize_W13, initialize_W14, initialize_W15, initialize_W16, initialize_W17, initialize_W18: in std_logic_vector(31 downto 0);
          load_weights: in STD_LOGIC;
          sel_init: in STD_LOGIC;
          
          nextW1,nextW2,nextW3: in std_logic_vector(31 downto 0);
          nextSens1,nextSens2,nextSens3: in std_logic_vector(31 downto 0);
          learning_Rate: in std_logic_vector(31 downto 0);

          

          sensitivity_out: out std_logic_vector(31 downto 0)
          
          

          );
end Hidden_Layer_Neuron;

architecture Behavioral of Hidden_Layer_Neuron is

--W1Blk
signal W11,W12,W13,W14,W15,W16,W17,W18:std_logic_vector(31 downto 0);
signal sel_init,load_Wij,clr,clk: std_logic;

--FPassNeruon
signal W1,W2,W3,W4,W5,W6,W7,W8: std_logic_vector(31 downto 0);
signal a1,a2,a3,a4,a5,a6,a7,a8,aout: std_logic_vector(31 downto 0);
signal a_Prime: std_logic;

--BPassNeuron
signal activationPrev: std_logic_vector(31 downto 0);
signal prevLayerSens: std_logic_vector(31 downto 0);

begin
sensitivity_out <= sensitivity;
-- Fix all inputs and ouputs for port maps only

W1Blk: weight port map(initialize_Wij => initialize_W11, sensitivity => sensitivity, activation_L1 => activation_11,
                       learning_Rate => learning_Rate, Wij => W11, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );
                       
W2Blk: weight port map(initialize_Wij => initialize_W12, sensitivity => sensitivity, activation_L1 => activation_12,
                       learning_Rate => learning_Rate, Wij => W12, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );

W3Blk: weight port map(initialize_Wij => initialize_W13, sensitivity => sensitivity, activation_L1 => activation_13,
                       learning_Rate => learning_Rate, Wij => W13, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );
                       
W4Blk: weight port map(initialize_Wij => initialize_W14, sensitivity => sensitivity, activation_L1 => activation_14,
                       learning_Rate => learning_Rate, Wij => W14, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );  
                       
W5Blk: weight port map(initialize_Wij => initialize_W15, sensitivity => sensitivity, activation_L1 => activation_15,
                       learning_Rate => learning_Rate, Wij => W15, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );     

W6Blk: weight port map(initialize_Wij => initialize_W16, sensitivity => sensitivity, activation_L1 => activation_16,
                       learning_Rate => learning_Rate, Wij => W16, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );

W7Blk: weight port map(initialize_Wij => initialize_W17, sensitivity => sensitivity, activation_L1 => activation_17,
                       learning_Rate => learning_Rate, Wij => W17, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );
                       
W8Blk: weight port map(initialize_Wij => initialize_W18, sensitivity => sensitivity, activation_L1 => activation_18,
                       learning_Rate => learning_Rate, Wij => W18, sel_init => sel_init, load_Wij => load_Wij, clr => clr, clk => clk
                       );                       
                                                              
FPassNeuron: Forward_Pass_Neuron_Hidden port map( W1 => W1, W2 => W2, W3 => W3, W4 => W4, W5 => W5, W6 => W6, W7 => W7, W8 => W8,
                                                  a1 => a1, a2 => a2, a3 => a3, a4 => a4, a5 => a5, a6 => a6, a7 => a7, a8 => a8,
                                                  aout => aout, a_Prime => a_Prime
                                                  );
                                                  
BPassNeuron: Back_Propagation_Neuron_Hidden port map(nextW1 => nextW1, nextW2 => nextW2, nextW3 => nextW3,
                                                     nextSens1 => nextSens1, nextSens2 => nextSens2, nextSens3 => nextSens3,
                                                     a_Prime => a_Prime, sensitivity => sensitivity
                                                     );

end Behavioral;
