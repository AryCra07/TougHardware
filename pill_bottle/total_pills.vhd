LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY total_pills IS
	PORT (
		is_full : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		clr : IN STD_LOGIC;
		start : IN STD_LOGIC;

		out_total_max : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_total_high : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_total_medium : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_total_low : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END total_pills;

ARCHITECTURE rtl OF total_pills IS
	SIGNAL now_total_max : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL now_total_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL now_total_medium : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL now_total_low : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	PROCESS (clk, clr, start)
	BEGIN
		IF (start = '0' AND clr = '1' AND(clk'event AND clk = '1')) THEN
			now_total_max <= "0000";
			now_total_high <= "0000";
			now_total_medium <= "0000";
			now_total_low <= "0000";
		ELSIF (is_full = '0') THEN
			IF (start = '1' AND (clk'event AND clk = '1')) THEN
				IF (now_total_low = "1001") THEN
					now_total_low <= "0000";
					IF (now_total_medium = "1001") THEN
						now_total_medium <= "0000";
						IF (now_total_high = "1001") THEN
							now_total_high <= "0000";
							now_total_max <= now_total_max + 1;
						ELSE
							now_total_high <= now_total_high + 1;
						END IF;
					ELSE
						now_total_medium <= now_total_medium + 1;
					END IF;
				ELSE
					now_total_low <= now_total_low + 1;
				END IF;
			ELSE
				now_total_low <= now_total_low;
				now_total_medium <= now_total_medium;
				now_total_high <= now_total_high;
				now_total_max <= now_total_max;
			END IF;
		ELSE
			now_total_low <= now_total_low;
			now_total_medium <= now_total_medium;
			now_total_high <= now_total_high;
			now_total_max <= now_total_max;
		END IF;
	END PROCESS;

	out_total_max <= now_total_max;
	out_total_high <= now_total_high;
	out_total_medium <= now_total_medium;
	out_total_low <= now_total_low;

END rtl;