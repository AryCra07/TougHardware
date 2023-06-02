LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY single_bottle IS
	PORT (
		clk : IN STD_LOGIC;
		clr : IN STD_LOGIC;
		start : IN STD_LOGIC;

		is_full : IN STD_LOGIC;
		input1_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		input1_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

		cout : OUT STD_LOGIC;
		out_single_high : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_single_low : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		clr_t : OUT STD_LOGIC
	);

END single_bottle;

ARCHITECTURE rtl OF single_bottle IS
	SIGNAL now_pills_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL now_pills_low : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

	PROCESS (clk, clr, start)
	BEGIN
		clr_t <= clr;
		IF (start = '0' AND clr = '1') THEN
			now_pills_high <= "0000";
			now_pills_low <= "0000";
		ELSIF (is_full = '0') THEN
			IF (start = '1' AND (clk'event AND clk = '1')) THEN
				IF (now_pills_low = "1001") THEN
					now_pills_low <= "0000";
					IF (now_pills_high = "1001") THEN
						now_pills_high <= "0000";
					ELSE
						now_pills_high <= now_pills_high + 1;
					END IF;
				ELSE
					now_pills_low <= now_pills_low + 1;
				END IF;
			END IF;
		END IF;

		IF (now_pills_high = input1_high AND now_pills_low = input1_low) THEN
			now_pills_high <= "0000";
			now_pills_low <= "0000";
		END IF;
	END PROCESS;

	PROCESS (clk, start)
	BEGIN
		--possible to change reverse clk
		IF (start = '1' AND (clk'event AND clk = '1')) THEN
			IF (input1_low = "0000") THEN
				IF (now_pills_high = input1_high - 1 AND now_pills_low = "1001") THEN
					cout <= '1';
				ELSE
					cout <= '0';
				END IF;
			ELSE
				IF (now_pills_high = input1_high AND now_pills_low = input1_low - 1) THEN
					cout <= '1';
				ELSE
					cout <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;

	out_single_high <= now_pills_high;
	out_single_low <= now_pills_low;

END rtl;