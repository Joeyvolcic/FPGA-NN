library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Back_Propagation_Neuron_Hidden is
    Port (nextW1,nextW2,nextW3,nextW4,nextW5,nextW6,nextW7,nextW8: in std_logic_vector(31 downto 0);
          nextSens1,nextSens2,nextSens3,nextSens4,nextSens5,nextSens6,nextSens7,nextSens8: in std_logic_vector(31 downto 0);
          activationPrev: in std_logic_vector(31 downto 0);
          prevLayerSens: out std_logic_vector(31 downto 0)
          );
end Back_Propagation_Neuron_Hidden;

architecture Behavioral of Back_Propagation_Neuron_Hidden is

signal m1,m2,m3,m4,m5,m6,m7,m8: std_logic_vector(31 downto 0);
signal temp,tempSens: std_logic_vector(63 downto 0);
signal sum: std_logic_vector(31 downto 0);

begin

m1 <= nextW1 * nextSens1;
m2 <= nextW2 * nextSens2;
m3 <= nextW3 * nextSens3;
m4 <= nextW4 * nextSens4;
m5 <= nextW5 * nextSens5;
m6 <= nextW6 * nextSens6;
m7 <= nextW7 * nextSens7;
m8 <= nextW8 * nextSens8;

temp <= m1 + m2 + m3 + m4 + m5 + m6 + m7 + m8;

sum <= temp(31 downto 0);

tempSens <= activationPrev * sum;

prevLayerSens <= tempSens (31 downto 0);

end Behavioral;
