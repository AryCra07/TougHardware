library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;


entity row_controller is
    port (
        clk : in std_logic;
        cur_row_part : out std_logic_vector(3 downto 0); 
        finish : out std_logic
    );
end row_controller;

architecture rtl of row_controller is
	signal counter : integer range 0 to 600 := 0; 
    signal part : std_logic_vector(3 downto 0);
    signal flag : std_logic;
begin
    process (clk)
    begin
		if(clk'event and clk = '1' ) then			
			counter <= counter + 1;
			if ((counter) < 2) then 
				finish <= '1';
				part <= "0000";
			elsif ((counter) < 65) then
				finish <= '0';
				part <= "0010";
 			elsif ((counter) < 128) then
				finish <= '0';
				part <= "0011";
			elsif ((counter) < 191 ) then
				finish <= '0';
				part <= "0100";
			elsif ((counter) < 254) then
				finish <= '0';
				part <= "0101";
			elsif ((counter) < 319) then
				finish <= '0';
				part <= "0110";
			elsif ((counter) < 392) then
				finish <= '0';
				part <= "0111";
			elsif ((counter) < 456) then
				finish <= '0';
				part <= "1000";
			elsif ((counter) < 524) then
				finish <= '0';
				part <= "1001";
			else
				finish <= '0';
				counter <= 0;
				part <= "0000";
			end if;
        end if;
    end process;
	cur_row_part <= part;
 
end rtl;