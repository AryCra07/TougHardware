library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity mode_selector is
	port (
		qd : in std_logic;
		clr : in std_logic;
		mode : out std_logic_vector(1 downto 0)
	);
end mode_selector;

architecture rtl of mode_selector is
	signal tmp : std_logic_vector(1 downto 0);
begin 
	process (qd, clr)
	begin 
		if (clr = '0') then
			tmp <= "00";
		elsif (qd'event and qd = '1') then
			tmp <= tmp + 1;
        end if;
        mode <= tmp;
  	end process;
end rtl;