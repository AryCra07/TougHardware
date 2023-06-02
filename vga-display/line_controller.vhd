library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;


entity line_controller is
    port (
        clk: in std_logic;
        end_line : out std_logic;
        cur_line_part : out std_logic_vector(3 downto 0)
    );
end line_controller;

architecture rtl of line_controller is
    signal counter : integer range 0 to 31 :=0; 
    signal part : std_logic_vector(3 downto 0);
    signal flag : std_logic;
begin
    process (clk)
    begin
		if(clk'event and clk = '1' ) then	
			counter <= counter + 1;
			if ((counter) < 1) then  
				flag <= '1';
				part <= "0000";
			elsif ( ((counter) < 4) ) then
				flag <= '0';
				part <= "0010";
			elsif ( (counter) < 7) then
				flag <= '0';
				part <= "0011";
			elsif ( (counter) < 10) then
				flag <= '0';
				part <= "0100";
			elsif ( (counter) < 13) then
				flag <= '0';
				part <= "0101";
			elsif ( (counter) < 16) then
				flag <= '0';
				part <= "0110";
			elsif ( (counter) < 19) then
				flag <= '0';
				part <= "0111";
			elsif ( (counter) < 22) then
				flag <= '0';
				part <= "1000";
			elsif ( (counter) < 25) then
				flag <= '0';
				part <= "0010";
			elsif ( (counter) < 28) then
				flag <= '0';
				part <= "1001";
			elsif ( (counter) < 33) then 
				flag <= '0';
				part <= "0010";
			else
				flag <= '0';
				counter <= 0;
				part <= "1000";
				
			end if;
        end if;
        end_line <= flag;
		cur_line_part <= part;
    end process;
    
 
end rtl;