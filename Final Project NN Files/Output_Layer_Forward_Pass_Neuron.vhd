library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.components.all;

entity Output_Layer_Forward_Pass_Neuron is
    Port (W1,W2,W3,W4,W5,W6: in std_logic_vector(31 downto 0);
          a1,a2,a3,a4,a5,a6: in std_logic_vector(31 downto 0);
          aout: out std_logic_vector(31 downto 0);
          a_prime: out std_logic
          );
end Output_Layer_Forward_Pass_Neuron;

architecture Behavioral of Output_Layer_Forward_Pass_Neuron is

signal sum: std_logic_vector(31 downto 0);
signal mul1,mul2,mul3,mul4,mul5,mul6: std_logic_vector(63 downto 0);
signal temp: std_logic_vector(63 downto 0);

begin
    
mul1 <= W1 * a1;
mul2 <= W2 * a2;
mul3 <= W3 * a3;
mul4 <= W4 * a4;
mul5 <= W5 * a5;
mul6 <= W6 * a6;

temp <= mul1 + mul2 + mul3 + mul4 + mul5 + mul6;

sum <= temp(31 downto 0);

RLU: ReLu port map(sum => sum, a => aout, a_Prime => a_Prime);

end Behavioral;
