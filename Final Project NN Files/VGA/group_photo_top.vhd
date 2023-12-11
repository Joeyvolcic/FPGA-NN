-- Example 73b: vga_bsprite_top
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.vga_components.all;
entity group_photo_top is
	 port(
		mclk : in STD_LOGIC;
		btn : in STD_LOGIC_VECTOR(3 downto 0);
		sw : in STD_LOGIC_VECTOR(7 downto 0);
		hsync : out STD_LOGIC;
		vsync : out STD_LOGIC;
         	red : out std_logic_vector(2 downto 0);
         	green : out std_logic_vector(2 downto 0);
         	blue : out std_logic_vector(1 downto 0)
	     );
end group_photo_top;
architecture group_photo_top of group_photo_top is 

signal clr, clk25, vidon: std_logic;
signal hc, vc: std_logic_vector(9 downto 0);
signal M, M1, M2: std_logic_vector(7 downto 0);
signal rom_addr16: std_logic_vector(15 downto 0);
signal rom_addr16_2: std_logic_vector(15 downto 0);
begin
  
clr <= btn(3);
rom_addr16_2 <= rom_addr16;
U1 : clkdiv
	port map(mclk => mclk, clr => clr, clk25 => clk25);
	
U2 : vga_640x480
	port map(clk => clk25, clr => clr, hsync => hsync, 
      vsync => vsync, hc => hc, vc => vc, vidon => vidon); 
	
U3 : vga_bsprite
	port map(vidon => vidon, hc => hc, vc => vc, M => M1, M2 => M2, sw => sw,
		rom_addr16 => rom_addr16, red => red, green => green,
		blue => blue);
		
--U4 : rom_140x140
--	port map (addra => rom_addr16(14 downto 0), clka => clk25, douta => M1);
	
U6: ten
    port map(addra => rom_addr16(6 downto 0), clka => clk25, douta => M1);
    M2 <= "00000000";
--U5: blk_mem_gen_0
--    port map (addra => rom_addr16(14 downto 0), clka => clk25, douta => M2);
    
 


	
end group_photo_top;
