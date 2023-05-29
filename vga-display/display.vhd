LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.numeric_std.ALL;
ENTITY display IS
	GENERIC (
		black : STD_LOGIC_VECTOR := "000";
		red : STD_LOGIC_VECTOR := "100";
		blue : STD_LOGIC_VECTOR := "010";
		pink : STD_LOGIC_VECTOR := "011";
		green : STD_LOGIC_VECTOR := "001";
		yellow : STD_LOGIC_VECTOR := "101";
		cyan : STD_LOGIC_VECTOR := "110";
		white : STD_LOGIC_VECTOR := "111"
	);
	PORT (
		VGAR : OUT STD_LOGIC;
		VGAG : OUT STD_LOGIC;
		VGAB : OUT STD_LOGIC;
		VGAH : OUT STD_LOGIC;
		VGAV : OUT STD_LOGIC;
		clk : IN STD_LOGIC;
		mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		cur_row_part : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		cur_line_part : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		end_line : IN STD_LOGIC;
		finish : IN STD_LOGIC
	);
END display;

ARCHITECTURE rtl OF display IS
	SIGNAL RGB : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
	VGAH <= end_line;
	VGAV <= finish;
	PROCESS (clk)
	BEGIN
		CASE mode IS
			WHEN "00" =>
				IF (cur_row_part = "0010") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= "000";
					ELSIF (cur_line_part = "0011") THEN
						RGB <= "000";
					ELSIF (cur_line_part = "0100") THEN
						RGB <= "000";
					ELSIF (cur_line_part = "0101") THEN
						RGB <= "000";
					ELSIF (cur_line_part = "0110") THEN
						RGB <= "000";
					ELSIF (cur_line_part = "0111") THEN
						RGB <= "000";
					ELSIF (cur_line_part = "1000") THEN
						RGB <= "000";
					ELSIF (cur_line_part = "1001") THEN
						RGB <= "000";
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0011") THEN
					
					IF (cur_line_part = "0010") THEN
						RGB <= red;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= red;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= red;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= red;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= red;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= red;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= red;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0100") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= pink;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= pink;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= pink;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= pink;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= pink;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= pink;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= pink;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0101") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= green;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= green;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= green;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= green;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= green;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= green;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= green;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0110") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= cyan;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= cyan;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= cyan;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= cyan;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= cyan;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= cyan;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= cyan;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0111") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= yellow;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= yellow;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= yellow;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= yellow;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= yellow;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= yellow;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= yellow;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "1000") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= white;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= white;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= white;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= white;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= white;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= white;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= white;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "1001") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= blue;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= blue;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= blue;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= blue;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= blue;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= blue;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= blue;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSE
					RGB <= "000";
				END IF;
			WHEN "01" =>
				IF (cur_line_part = "0010") THEN
					RGB <= black;
				ELSIF (cur_line_part = "0011") THEN
					RGB <= red;
				ELSIF (cur_line_part = "0100") THEN
					RGB <= pink;
				ELSIF (cur_line_part = "0101") THEN
					RGB <= green;
				ELSIF (cur_line_part = "0110") THEN
					RGB <= cyan;
				ELSIF (cur_line_part = "0111") THEN
					RGB <= yellow;
				ELSIF (cur_line_part = "1000") THEN
					RGB <= white;
				ELSIF (cur_line_part = "1001") THEN
					RGB <= blue;
				ELSIF (cur_line_part = "0000") THEN
					RGB <= "000";
				END IF;
			WHEN "10" =>
				IF (cur_row_part = "0010") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= black XOR black;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= black XOR red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= black XOR pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= black XOR green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= black XOR cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= black XOR yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= black XOR white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= black XOR blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0011") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= red XOR black;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= red XOR red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= red XOR pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= red XOR green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= red XOR cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= red XOR yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= red XOR white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= red XOR blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0100") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= pink XOR black;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= pink XOR red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= pink XOR pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= pink XOR green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= pink XOR cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= pink XOR yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= pink XOR white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= pink XOR blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0101") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= green XOR black;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= green XOR red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= green XOR pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= green XOR green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= green XOR cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= green XOR yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= green XOR white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= green XOR blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0110") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= cyan XOR black;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= cyan XOR red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= cyan XOR pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= cyan XOR green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= cyan XOR cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= cyan XOR yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= cyan XOR white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= cyan XOR blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "0111") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= yellow XOR black;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= yellow XOR red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= yellow XOR pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= yellow XOR green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= yellow XOR cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= yellow XOR yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= yellow XOR white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= yellow XOR blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "1000") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= white XOR black;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= white XOR red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= white XOR pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= white XOR green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= white XOR cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= white XOR yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= white XOR white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= white XOR blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSIF (cur_row_part = "1001") THEN
					IF (cur_line_part = "0010") THEN
						RGB <= blue XOR black;
					ELSIF (cur_line_part = "0011") THEN
						RGB <= blue XOR red;
					ELSIF (cur_line_part = "0100") THEN
						RGB <= blue XOR pink;
					ELSIF (cur_line_part = "0101") THEN
						RGB <= blue XOR green;
					ELSIF (cur_line_part = "0110") THEN
						RGB <= blue XOR cyan;
					ELSIF (cur_line_part = "0111") THEN
						RGB <= blue XOR yellow;
					ELSIF (cur_line_part = "1000") THEN
						RGB <= blue XOR white;
					ELSIF (cur_line_part = "1001") THEN
						RGB <= blue XOR blue;
					ELSE
						RGB <= "000";
					END IF;
				ELSE
					RGB <= "000";
				END IF;
			WHEN "11" =>
				IF (cur_line_part = "0010") THEN
					RGB <= black;
				ELSIF (cur_line_part = "0011") THEN
					RGB <= black;
				ELSIF (cur_line_part = "0100") THEN
					RGB <= black;
				ELSIF (cur_line_part = "0101") THEN
					RGB <= black;
				ELSIF (cur_line_part = "0110") THEN
					RGB <= black;
				ELSIF (cur_line_part = "0111") THEN
					RGB <= black;
				ELSIF (cur_line_part = "1000") THEN
					RGB <= black;
				ELSIF (cur_line_part = "1001") THEN
					RGB <= black;
				ELSE
					RGB <= "000";
				END IF;
		END CASE;
		VGAR <= RGB(0);
		VGAG <= RGB(1);
		VGAB <= RGB(2);
	END PROCESS;
END rtl;