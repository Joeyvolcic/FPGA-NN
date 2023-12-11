library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity network_state_machine is
  Port (clk, clr: in STD_LOGIC;
        go: in STD_LOGIC);
end network_state_machine;

architecture Behavioral of network_state_machine is
type state_type is (s0, s1, s2, s3, s4);
signal present_state, next_state: state_type;
begin
sreg: process(clk, clr)
    begin
        if clr = '1' then
                present_state <= s0;
        elsif clk'event and clk = '1' then
                present_state <= next_state;
        end if;
    end process;
    C1: process(present_state, go)
    begin
      case present_state is
        when s0 =>
          if go = '1' then
            next_state <= s1;
          else
            next_state <= s0;
          end if;
        when s1 =>

            next_state <= s2;
            when s2 =>
          if din = '0' then
            next_state <= s3;
          else
            next_state <= s2;
          end if;
        when s3 =>
          if din = '1' then
            next_state <= s1;
          else
            next_state <= s0;
          end if;	  	  
        when others =>
          null;
      end case;
    end process;
    Seq2: process(clk, clr)
    begin
        if clr = '1' then
                dout <= '0';
        elsif clk'event and clk = '1' then
            if present_state = s3 and din = '1' then
                    dout <= '1';
            else
                    dout <= '0';
            end if;
        end if;
    end process;
    end seqdetb;
    


end Behavioral;
