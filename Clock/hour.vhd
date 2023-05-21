LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY hour IS
    PORT (
        pause : IN STD_LOGIC;
        in_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        in_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        clk : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        set : IN STD_LOGIC;
        alarm : IN STD_LOGIC;
        out_high : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        out_low : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        hour_ring : OUT STD_LOGIC
    );
END hour;

ARCHITECTURE func OF hour IS
    SIGNAL tmp_low, tmp_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    PROCESS (pause, clr, set, alarm, clk)
    BEGIN
        IF (clr = '1') THEN -- clear all
            tmp_low <= "0000";
            tmp_high <= "0000";
        ELSIF (set = '1' AND clr = '0' AND alarm = '0') THEN
            tmp_low <= in_low;
            tmp_high <= in_high;
        ELSIF (clk'event AND clk = '1') THEN
            IF ((set = '0' AND clr = '0' AND pause = '0') OR (set = '1' AND clr = '0' AND alarm = '1' AND pause = '0')) THEN
                IF (tmp_low = 3 AND tmp_high = 2) THEN -- process carry of 23->00
                    tmp_high <= "0000";
                    tmp_low <= "0000";
                ELSIF (tmp_low = 9) THEN -- process carry of 9->0
                    tmp_low <= "0000";
                    tmp_high <= tmp_high + 1;
                ELSE
                    tmp_low <= tmp_low + 1;
                END IF;
                IF (alarm = '1' AND set = '0') THEN -- trigger ring signal
                    IF (tmp_high = in_high AND tmp_low = in_low) THEN
                        hour_ring <= '1';
                    ELSE
                        hour_ring <= '0';
                    END IF;
                END IF;
            END IF;
        END IF;
        IF (set = '1' AND alarm = '1') THEN -- in set mode just output the input
            out_low <= in_low;
            out_high <= in_high;
        ELSE
            out_low <= STD_LOGIC_VECTOR(tmp_low);
            out_high <= STD_LOGIC_VECTOR(tmp_high);
        END IF;
    END PROCESS;
END func;