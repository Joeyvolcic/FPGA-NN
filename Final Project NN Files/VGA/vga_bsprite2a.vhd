-- Example 37a: vga_bsprite
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity vga_bsprite is
    port ( vidon: in std_logic;
           hc : in std_logic_vector(9 downto 0);
           vc : in std_logic_vector(9 downto 0);
           M,M2: in std_logic_vector(7 downto 0);
           sw: in std_logic_vector(7 downto 0);
           rom_addr16: out std_logic_vector(15 downto 0);
           red : out std_logic_vector(2 downto 0);
           green : out std_logic_vector(2 downto 0);
           blue : out std_logic_vector(1 downto 0)
           
	);
end vga_bsprite;
architecture vga_bsprite of vga_bsprite is 
constant hbp: std_logic_vector(9 downto 0) := "0010010000";	 
	--Horizontal back porch = 144 (128+16)
constant vbp: std_logic_vector(9 downto 0) := "0000011111";	 
	--Vertical back porch = 31 (2+29)
constant w: integer := 10;
constant h: integer := 10;
signal xpix, ypix: std_logic_vector(9 downto 0);			
signal rom_addr : std_logic_vector(16 downto 0);
signal C1, R1: std_logic_vector(9 downto 0);				
signal spriteon, spriteon2, R, G, B: std_logic;
begin
	--set C1 and R1 using switches
	C1 <= '0' & SW(3 downto 0) & "00001";
	R1 <= '0' & SW(7 downto 4) & "00001";
	ypix <= vc - vbp - R1;
	xpix <= hc - hbp - C1;
	
	--Enable sprite video out when within the sprite region
 	spriteon <= '1' when (((hc > C1 + hbp) and (hc <= C1 + hbp + w))
           and ((vc >= R1 + vbp) and (vc < R1 + vbp + h))) else '0'; 
    spriteon2 <= '1' when (((hc > C1 + hbp + 280) and (hc <= C1 + hbp + w + 280))
           and ((vc >= R1 + vbp) and (vc < R1 + vbp + h))) else '0';      
	process(xpix, ypix)
	variable  rom_addr1, rom_addr2: STD_LOGIC_VECTOR (16 downto 0);
	begin --changed to multiply by 140
		rom_addr1 := (ypix & "0000000") + ("0000" & ypix & "000")
            + ("00000" & ypix & "00");
           -- y*(128+64+32+16) = y*240
		rom_addr2 := rom_addr1 + ("0000000" & xpix); -- y*240+x
		rom_addr16 <= rom_addr2(15 downto 0);
	end process;
	process(spriteon, vidon, M)
  		variable j: integer;
 	begin
		red <= "000";
		green <= "000";
		blue <= "00";
		if spriteon = '1' and vidon = '1' then
    			red <=  M(7 downto 5);
    			green <= M(4 downto 2);
    			blue <= M(1 downto 0);
--		elsif spriteon2 = '1' and vidon = '1' then
--    			red <=  M2(7 downto 5);
--    			green <= M2(4 downto 2);
--    			blue <= M2(1 downto 0);
		end if;
  	end process; 
					
   end vga_bsprite;
