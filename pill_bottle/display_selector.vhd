LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY display_selector IS
	PORT (
		clr : IN STD_LOGIC;
		single_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		single_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		bottles_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		bottles_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		total_max : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		total_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		total_medium : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		total_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

		init_single_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		init_single_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		init_b_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		init_b_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

		mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		out_led_1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_led_2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_led_3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_led_4 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_led_5 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END display_selector;

ARCHITECTURE rtl OF display_selector IS
BEGIN
	PROCESS (clr, mode)
	BEGIN
		IF (clr = '1') THEN
			out_led_5 <= "0000";
			out_led_4 <= "0000";
			out_led_3 <= "0000";
			out_led_2 <= "0000";
			out_led_1 <= "0000";
		ELSE
			IF (mode = "00") THEN
				out_led_5 <= init_b_high;
				out_led_4 <= init_b_low;
				out_led_3 <= "0000";
				out_led_2 <= init_single_high;
				out_led_1 <= init_single_low;
			ELSIF (mode = "01") THEN
				out_led_5 <= "0000";
				out_led_4 <= "0000";
				out_led_3 <= "0000";
				out_led_2 <= single_high;
				out_led_1 <= single_low;
			ELSIF (mode = "10") THEN
				out_led_5 <= "0000";
				out_led_4 <= "0000";
				out_led_3 <= "0000";
				out_led_2 <= bottles_high;
				out_led_1 <= bottles_low;
			ELSIF (mode = "11") THEN
				out_led_5 <= "0000";
				out_led_4 <= total_max;
				out_led_3 <= total_high;
				out_led_2 <= total_medium;
				out_led_1 <= total_low;
			END IF;
		END IF;
	END PROCESS;

END rtl;