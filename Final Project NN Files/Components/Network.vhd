library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.components.all;


entity Network is
  Port (x ,y: in STD_LOGIC_VECTOR(31 downto 0);
        target_r, target_g, target_b: in STD_LOGIC_VECTOR(31 downto 0);  
        go: in STD_LOGIC;
        learning_Rate: in std_logic_vector(31 downto 0):= "00000000000000000000000010100111";
        reset: in STD_LOGIC;
        start: in STD_LOGIC;
        clk: in STD_LOGIC;
        clr: in STD_LOGIC;
        
        

        r,b,g: out STD_LOGIC_VECTOR(31 downto 0)    
        );
end Network;

architecture Behavioral of Network is

TYPE hidden_layer_init_weights is array (0 to 7) of STD_LOGIC_VECTOR(31 downto 0);--amount of weights
TYPE hidden_layer_neurons is array (0 to 5) of hidden_layer_init_weights; --number of neurons

-- hidden_layer_activation is array
TYPE hidden_to_last_array_neuron is array (0 to 2) of STD_LOGIC_VECTOR(31 downto 0); --amount of weights
TYPE hidden_to_last_array_layer is array (0 to 5) of hidden_to_last_array_neuron; --number of neurons

TYPE hidden_to_last_array_activation_neuron is array (0 to 5) of STD_LOGIC_VECTOR(31 downto 0);

TYPE predicted_color_array is array (0 to 2) of  STD_LOGIC_VECTOR(31 downto 0);

signal hidden_activation: hidden_to_last_array_activation_neuron;

SIGNAL predicted_color: predicted_color_array;
SIGNAL target_color: predicted_color_array;

SIGNAL init_hidden_weights : hidden_layer_neurons;

SIGNAL last_layer_weight : hidden_to_last_array_layer;
SIGNAL last_layer_sensitivity : hidden_to_last_array_neuron;

signal load_Wij,aLoad: STD_LOGIC;

signal sel_init: STD_LOGIC;
signal load_inputs: STD_LOGIC;
signal load_hidden: STD_LOGIC;
signal load_rgb: STD_LOGIC;

signal hsync,vsync,ram_we,load_hidden_activation,load_output_activation,load_output: std_logic;
signal rom_addr16: std_logic_vector(15 downto 0);




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
    target_color(0) <= target_r; target_color(1) <= target_g; target_color(2) <= target_b;
    
    init_hidden_weights(0)(0) <= X"00003832"; init_hidden_weights(0)(1) <= X"00001734"; init_hidden_weights(0)(2) <= X"00009584"; init_hidden_weights(0)(3) <= X"00006594";
    init_hidden_weights(0)(4) <= X"00006729"; init_hidden_weights(0)(5) <= X"00001102"; init_hidden_weights(0)(6) <= X"00004932"; init_hidden_weights(0)(7) <= X"00009173";
    
    init_hidden_weights(1)(0) <= X"00008372"; init_hidden_weights(1)(1) <= X"00002002"; init_hidden_weights(1)(2) <= X"00001977"; init_hidden_weights(1)(3) <= X"00006611";
    init_hidden_weights(1)(4) <= X"00001922"; init_hidden_weights(1)(5) <= X"00002003"; init_hidden_weights(1)(6) <= X"00009200"; init_hidden_weights(1)(7) <= X"00000242";
    
    init_hidden_weights(2)(0) <= X"00003742"; init_hidden_weights(2)(1) <= X"00004854"; init_hidden_weights(2)(2) <= X"00009402"; init_hidden_weights(2)(3) <= X"00001011";
    init_hidden_weights(2)(4) <= X"00004928"; init_hidden_weights(2)(5) <= X"00003723"; init_hidden_weights(2)(6) <= X"00006712"; init_hidden_weights(2)(7) <= X"00000717";
    
    init_hidden_weights(3)(0) <= X"00001210"; init_hidden_weights(3)(1) <= X"00007283"; init_hidden_weights(3)(2) <= X"00004903"; init_hidden_weights(3)(3) <= X"00002722";
    init_hidden_weights(3)(4) <= X"00001152"; init_hidden_weights(3)(5) <= X"00007371"; init_hidden_weights(3)(6) <= X"00007201"; init_hidden_weights(3)(7) <= X"00009506";
    
    init_hidden_weights(4)(0) <= X"00000001"; init_hidden_weights(4)(1) <= X"00003124"; init_hidden_weights(4)(2) <= X"00008234"; init_hidden_weights(4)(3) <= X"00007234";
    init_hidden_weights(4)(4) <= X"00008291"; init_hidden_weights(4)(5) <= X"00009876"; init_hidden_weights(4)(6) <= X"00007482"; init_hidden_weights(4)(7) <= X"00001739";
    
    init_hidden_weights(5)(0) <= X"00009284"; init_hidden_weights(5)(1) <= X"00005581"; init_hidden_weights(5)(2) <= X"00008355"; init_hidden_weights(5)(3) <= X"00004680";
    init_hidden_weights(5)(4) <= X"00004804"; init_hidden_weights(5)(5) <= X"00006233"; init_hidden_weights(5)(6) <= X"00001823"; init_hidden_weights(5)(7) <= X"00001726";
    
    
--NORMILAZATION INPUTS
--Values will be store prenormalized in ram

-- INPUT LAYER
register_last_r: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_color(0), clk => clk, clr => clr, q => predicted_r_reg);
register_last_g: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_color(1), clk => clk, clr => clr, q => predicted_g_reg);
register_last_b: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_color(2), clk => clk, clr => clr, q => predicted_b_reg);

register_last_r2: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_r_reg, clk => clk, clr => clr, q => predicted_r2_reg);
register_last_g2: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_g_reg, clk => clk, clr => clr, q => predicted_g2_reg);
register_last_b2: Reg generic map (N => 32) port map ( load => load_inputs, input => predicted_b_reg, clk => clk, clr => clr, q => predicted_b2_reg);

register_x: Reg generic map (N => 32) port map ( load => load_inputs, input => x, clk => clk, clr => clr, q => x_normal_reg);
register_y: Reg generic map (N => 32) port map ( load => load_inputs, input => x, clk => clk, clr => clr, q => y_normal_reg);

register_r: Reg generic map (N => 32) port map ( load => load_rgb, input => predicted_r, clk => clk, clr => clr, q => predicted_r2_reg);
register_g: Reg generic map (N => 32) port map ( load => load_rgb, input => predicted_g, clk => clk, clr => clr, q => predicted_r2_reg);
register_b: Reg generic map (N => 32) port map ( load => load_rgb, input => predicted_b, clk => clk, clr => clr, q => predicted_r2_reg);


FSMBlk: NNControl port map(clk => clk, clr => clr, hsync => hsync, vsync => vsync, ram_we => ram_we, load_inputs => load_inputs, x => x, y => y, rom_addr16 => rom_addr16, sel_init => sel_init, load_hidden => load_hidden,
                           load_hidden_activation => load_hidden_activation, load_output_activation => load_output_activation, load_rgb => load_rgb, load_output => load_output
                           );



generate_hidden_neuron: for i in 0 to 5 generate
    hidden_neuron: Hidden_Layer_Neuron port map(activation_11 => predicted_r_reg, activation_12 => predicted_b_reg, activation_13 => predicted_g_reg, activation_14 => predicted_r2_reg,
                                                activation_15 => predicted_b2_reg, activation_16 => predicted_g2_reg, activation_17 => predicted_g_reg, activation_18 => predicted_r2_reg,
                                                initialize_W11 => init_hidden_weights(i)(0), initialize_W12 => init_hidden_weights(i)(1),initialize_W13 => init_hidden_weights(i)(2),initialize_W14 => init_hidden_weights(i)(3),
                                                initialize_W15 => init_hidden_weights(i)(4), initialize_W16 => init_hidden_weights(i)(5),initialize_W17 => init_hidden_weights(i)(6),initialize_W18 => init_hidden_weights(i)(7),
                                                Load_Wij => load_hidden, sel_init => sel_init, clk => clk, clr => clr, nextW1 => last_layer_weight(i)(0), nextW2 => last_layer_weight(i)(1), nextW3 => last_layer_weight(i)(2),
                                                nextSens1 => last_layer_sensitivity(0), nextSens2 => last_layer_sensitivity(1), nextSens3 => last_layer_sensitivity(2), learning_Rate => learning_Rate, activation_out =>  hidden_activation(i),
                                                aLoad => load_inputs
                                                );
end generate generate_hidden_neuron;
        
generate_output_neuron: for i in 0 to 2 generate
    output_neuron: Output_Layer_Neuron port map (activation_21 => hidden_activation(i),
                                                 activation_22 => hidden_activation(i + 1), -- Assuming 22 is the next element
                                                 activation_23 => hidden_activation(i + 2), -- Assuming 23 is two elements ahead
                                                 initialize_W21 => last_layer_weight(i)(0),
                                                 initialize_W22 => last_layer_weight(i)(1),
                                                 initialize_W23 => last_layer_weight(i)(2),
                                                 load_Wij => load_Wij,
                                                 sel_init => sel_init,
                                                 clk => clk,
                                                 clr => clr,
                                                 learning_Rate => learning_Rate,
                                                 targetR => target_color(i),
                                                 predictedR => predicted_color(i),
                                                 aLoad => aLoad
                                                 );
end generate generate_output_neuron;

-- Assign the predicted color values to the output ports
r <= predicted_color(0);
g <= predicted_color(1);
b <= predicted_color(2);
end Behavioral;
