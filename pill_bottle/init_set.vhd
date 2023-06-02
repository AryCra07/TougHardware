LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY init_set IS
	PORT (
		clr : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		mode : IN STD_LOGIC;
		start : IN STD_LOGIC;
		in_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		in_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

		store_single_high : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		store_single_low : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		store_nums_high : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		store_nums_low : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		warn : OUT STD_LOGIC;
		is_start : OUT STD_LOGIC;
		out_clr : OUT STD_LOGIC
	);
END init_set;

ARCHITECTURE rtl OF init_set IS
	SIGNAL set_single_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL set_single_low : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL set_nums_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL set_nums_low : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

	PROCESS (clr, start, reset, mode)
	BEGIN
		out_clr <= clr;
		IF (clr = '1') THEN -- clear all
			set_single_high <= "0000";
			set_single_low <= "0101";
			set_nums_high <= "0000";
			set_nums_low <= "0101";
			warn <= '0';
		ELSE
			IF (start = '0' AND reset = '1') THEN -- not start yet and in reset
				IF (mode = '1') THEN -- when mode is 1 we set the max capacity of single bottle
					IF (in_high = 0 AND in_low < 5) THEN
						set_single_high <= "0000";
						set_single_low <= "0101";
						warn <= '1';
					ELSIF (in_high > 9) THEN
						set_single_high <= "1001";
						set_single_low <= "1001";
						warn <= '1';
					ELSIF (in_low > 9) THEN
						set_single_high <= in_high;
						set_single_low <= "1001";
						warn <= '1';
					ELSE
						set_single_high <= in_high;
						set_single_low <= in_low;
						warn <= '0';
					END IF;
				ELSE -- else we set the max num of bottles
					IF (in_high = 0 AND in_low < 5) THEN
						set_nums_high <= "0000";
						set_nums_low <= "0101";
						warn <= '1';
					ELSIF (in_high > 9) THEN
						set_nums_high <= "1001";
						set_nums_low <= "1001";
						warn <= '1';
					ELSIF (in_low > 9) THEN
						set_nums_high <= in_high;
						set_nums_low <= "1001";
						warn <= '1';
					ELSE
						set_nums_high <= in_high;
						set_nums_low <= in_low;
						warn <= '0';
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	-- output
	is_start <= start;
	store_single_high <= set_single_high;
	store_single_low <= set_single_low;
	store_nums_high <= set_nums_high;
	store_nums_low <= set_nums_low;

END rtl;