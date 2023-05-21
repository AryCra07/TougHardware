LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY set_hour IS
    PORT (
        qd : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        set : IN STD_LOGIC;
        alarm : IN STD_LOGIC;
        high_num : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        low_num : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END set_hour;

ARCHITECTURE func OF set_hour IS
    SIGNAL tmp_low, tmp_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    PROCESS (qd, clr, set, alarm)
    BEGIN
        IF (clr = '1') THEN
            tmp_low <= "0000";
            tmp_high <= "0000";
        ELSIF (set = '1') THEN
            IF (qd'event AND qd = '0') THEN
                IF (tmp_low = 3 AND tmp_high = 2) THEN
                    tmp_low <= "0000";
                    tmp_high <= "0000";
                ELSIF (tmp_low = 9) THEN
                    tmp_high <= tmp_high + 1;
                    tmp_low <= "0000";
                ELSE
                    tmp_low <= tmp_low + 1;
                END IF;
            END IF;
            low_num <= tmp_low;
            high_num <= tmp_high;
        END IF;
    END PROCESS;
END func;