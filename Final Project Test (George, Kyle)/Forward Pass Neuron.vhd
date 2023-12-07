library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.components.all;

entity Forward_Pass_Neuron is
    generic (N:integer);
    Port (Wij: in std_logic_vector(15 downto 0);
          aij: in std_logic_vector(15 downto 0);
          aout: out std_logic_vector(15 downto 0);
          a_Prime: out std_logic
          );
end Forward_Pass_Neuron;

architecture Behavioral of Forward_Pass_Neuron is

signal sum: std_logic_vector(15 downto 0);

begin

RLU: ReLu port map(sum => sum, a => aout, a_Prime => a_Prime);


--N <= 16;

--for i in 1 to N loop generate

end Behavioral;
