library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package components is

    component vga_bsprite is
        port ( vidon: in std_logic;
               hc : in std_logic_vector(9 downto 0);
               vc : in std_logic_vector(9 downto 0);
               M: in std_logic_vector(7 downto 0);
               sw: in std_logic_vector(7 downto 0);
               rom_addr16: out std_logic_vector(15 downto 0);
               red : out std_logic_vector(2 downto 0);
               x,y: out std_logic_vector(9 downto 0);
               spriteon: out std_logic;
               green : out std_logic_vector(2 downto 0);
               blue : out std_logic_vector(1 downto 0)
        );
    end component;
    
    
    component clkdiv is
         port(
             mclk : in STD_LOGIC;
             clr : in STD_LOGIC;
             clk190 : out STD_LOGIC
             );
    end component;
    
    component vga_640x480 is
        port ( clk, clr : in std_logic;
               hsync : out std_logic;
               vsync : out std_logic;
               hc : out std_logic_vector(9 downto 0);
               vc : out std_logic_vector(9 downto 0);
               vidon : out std_logic
        );
    end component;
    
    component Reg is
    generic (N: integer);
    port(
        load : in STD_LOGIC;
        input : in STD_LOGIC_VECTOR(N-1 downto 0);
        clk : in STD_LOGIC;
        clr : in STD_LOGIC;
        q : out STD_LOGIC_VECTOR(N-1 downto 0)
        );
    end component;
    
    component Mux2to1 is
        generic (N:integer);
        port (
            a: in STD_LOGIC_VECTOR(N-1 downto 0);
            b: in STD_LOGIC_VECTOR(N-1 downto 0);
            s: in STD_LOGIC;
            y: out STD_LOGIC_VECTOR(N-1 downto 0)
        );
    end component;
    
    component ReLu is
        Port (sum: in std_logic_vector(31 downto 0);
              a: out std_logic_vector(31 downto 0);
              a_Prime: out std_logic
              );
    end component;
    
    component weight is
      Port (initialize_Wij: in std_logic_vector(31 downto 0);
            sel_init: in std_logic;
            load_Wij: in std_logic;
            clr: in std_logic;
            clk: in std_logic;
            sensitivity: in std_logic_vector(31 downto 0);
            activation_L1: in std_logic_vector(31 downto 0);
            learning_Rate: in std_logic_vector(31 downto 0);
            Wij: out std_logic_vector(31 downto 0)
            );
    end component;
    
    component Forward_Pass_Neuron_Hidden is
    Port (W1,W2,W3,W4,W5,W6,W7,W8: in std_logic_vector(31 downto 0);
          a1,a2,a3,a4,a5,a6,a7,a8: in std_logic_vector(31 downto 0);
          aout: out std_logic_vector(31 downto 0);
          a_Prime: out std_logic
          );
    end component;

end components;