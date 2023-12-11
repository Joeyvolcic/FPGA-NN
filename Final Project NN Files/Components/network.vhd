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

TYPE init_array is array (0 to 7) of STD_LOGIC_VECTOR(31 downto 0);
TYPE init_array_2d is array (0 to 5) of init_array;

TYPE hidden_to_last_array_neuron is array (0 to 2) of STD_LOGIC_VECTOR(31 downto 0);
TYPE hidden_to_last_array_layer is array (0 to 5) of hidden_to_last_array_neuron;

SIGNAL init_array_weights : init_array_2d;

SIGNAL last_layer_weight : hidden_to_last_array_layer;
SIGNAL last_layer_sensitivity : hidden_to_last_array_layer;

SIGNAL sel_init: STD_LOGIC;
SIGNAL load_inputs: STD_LOGIC;
SIGNAL load_hidden: STD_LOGIC;

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
    init_array_weights(0)(0) <= X"00003832"; init_array_weights(0)(1) <= X"00001734"; init_array_weights(0)(2) <= X"00009584"; init_array_weights(0)(3) <= X"00006594";
    init_array_weights(0)(4) <= X"00006729"; init_array_weights(0)(5) <= X"00001102"; init_array_weights(0)(6) <= X"00004932"; init_array_weights(0)(7) <= X"00009173";

    
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

generate_hidden_neuron: for i in 0 to 5 generate
  hidden_neuron: Hidden_Layer_Neuron port map(activation_11 => predicted_r_reg, activation_12 => predicted_b_reg, activation_13 => predicted_g_reg, activation_14 => predicted_r2_reg,
                                              activation_15 => predicted_b2_reg, activation_16 => predicted_g2_reg, activation_17 => predicted_g_reg, activation_18 => predicted_r2_reg,
                                              initialize_W11 => init_array_weights(i)(0), initialize_W12 => init_array_weights(i)(1),initialize_W13 => init_array_weights(i)(2),initialize_W14 => init_array_weights(i)(3),
                                              initialize_W15 => init_array_weights(i)(4), initialize_W16 => init_array_weights(i)(5),initialize_W17 => init_array_weights(i)(6),initialize_W18 => init_array_weights(i)(7),
                                              Load_Wij => load_hidden, sel_init => sel_init, clk => clk, clr => clr
    );
end generate generate_hidden_neuron;





end Behavioral;
