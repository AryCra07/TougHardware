LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY set_min IS
    PORT (
        clr : IN STD_LOGIC;
        set_min : IN STD_LOGIC;
        set : IN STD_LOGIC;

        clk : IN STD_LOGIC;
        high_num : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        low_num : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        in_high_num : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        in_low_num : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        alarm_min : IN STD_LOGIC;
        alarm_high_num : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        alarm_low_num : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END set_min;

ARCHITECTURE func OF set_min IS
    SIGNAL tmp_low, tmp_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL tmp1_low, tmp1_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    PROCESS (clr, set_min, set, clk, alarm_min)
    BEGIN
        IF (clr = '1') THEN
            tmp_low <= "0000";
            tmp_high <= "0000";
        ELSE
            IF (set = '1' AND clr = '0' AND set_min = '1') THEN
                tmp_low <= in_low_num;
                tmp_high <= in_high_num;
                IF (in_low_num > 9) THEN
                    tmp_low <= "0000";
                END IF;
                IF (in_high_num > 5) THEN
                    tmp_high <= "0000";
                END IF;
            ELSIF (set = '1' AND clr = '0' AND alarm_min = '1') THEN
                tmp1_low <= in_low_num;
                tmp1_high <= in_high_num;
            END IF;
        END IF;
    END PROCESS;
    low_num <= tmp_low;
    high_num <= tmp_high;
    alarm_low_num <= tmp1_low;
    alarm_high_num <= tmp1_high;
END func;