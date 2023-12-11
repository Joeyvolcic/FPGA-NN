library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.components.all;

entity network is
  Port (x ,y: in STD_LOGIC_VECTOR(31 downto 0);
        target_r, target_g, target_b: in STD_LOGIC_VECTOR(31 downto 0);  
        go: in STD_LOGIC;
        reset: in STD_LOGIC;
        start: in STD_LOGIC;
        clk: in STD_LOGIC;
        clr: in STD_LOGIC;
        
        r,b,g: out STD_LOGIC_VECTOR(31 downto 0)    
  );
end network;

architecture Behavioral of network is

SIGNAL sel_init: STD_LOGIC;
SIGNAL load_inputs: STD_LOGIC;

SIGNAL x_normal: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL y_normal: STD_LOGIC_VECTOR(31 downto 0);

SIGNAL x_normal_reg: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL y_normal_reg: STD_LOGIC_VECTOR(31 downto 0);

SIGNAL predicted_r: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL predicted_b: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL predicted_g: STD_LOGIC_VECTOR(31 downto 0);

SIGNAL predicted_r_reg: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL predicted_b_reg: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL predicted_g_reg: STD_LOGIC_VECTOR(31 downto 0);

SIGNAL predicted_r2_reg: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL predicted_b2_reg: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL predicted_g2_reg: STD_LOGIC_VECTOR(31 downto 0);

begin
--NORMILAZATION INPUTS
--Values will be store prenormalized in ram

-- INPUT LAYER
register_last_r: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_r, clk => clk, clr => clr, q => predicted_r_reg);
register_last_g: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_g, clk => clk, clr => clr, q => predicted_g_reg);
register_last_b: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_b, clk => clk, clr => clr, q => predicted_b_reg);

register_last_r2: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_r_reg, clk => clk, clr => clr, q => predicted_r2_reg);
register_last_g2: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_g_reg, clk => clk, clr => clr, q => predicted_g2_reg);
register_last_b2: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_b_reg, clk => clk, clr => clr, q => predicted_b2_reg);

register_x: Reg generic map (N => 32) port map ( load => load_inputs, input => x, clk => clk, clr => clr, q => x_normal_reg);
register_y: Reg generic map (N => 32) port map ( load => load_inputs, input => x, clk => clk, clr => clr, q => y_normal_reg);





end Behavioral;
