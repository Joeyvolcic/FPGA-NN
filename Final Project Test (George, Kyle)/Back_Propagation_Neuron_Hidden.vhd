library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Back_Propagation_Neuron_Hidden is
    Port (nextW1,nextW2,nextW3: in std_logic_vector(31 downto 0);
          nextSens1,nextSens2,nextSens3: in std_logic_vector(31 downto 0);
          a_prime: in std_logic_vector(31 downto 0);
          sensitivity: out std_logic_vector(31 downto 0)
          );
end Back_Propagation_Neuron_Hidden;

architecture Behavioral of Back_Propagation_Neuron_Hidden is

signal m1,m2,m3: std_logic_vector(31 downto 0);
signal temp,tempSens: std_logic_vector(63 downto 0);
signal sum: std_logic_vector(31 downto 0);

begin

m1 <= nextW1 * nextSens1;
m2 <= nextW2 * nextSens2;
m3 <= nextW3 * nextSens3;

temp <= m1 + m2 + m3;

sum <= temp(31 downto 0);

tempSens <= activationPrev * sum;

sensitivity <= tempSens (31 downto 0);

end Behavioral;
