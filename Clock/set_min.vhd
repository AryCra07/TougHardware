LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY set_min IS
    PORT (
        clr : IN STD_LOGIC;
        qd : IN STD_LOGIC;
        set : IN STD_LOGIC;
        alarm : IN STD_LOGIC;
        high_num : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- The high digit of MIN
        low_num : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- The Low digit of MIN
    );
END set_min;

ARCHITECTURE func OF set_min IS
    SIGNAL tmp_low, tmp_high : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Temp digits
BEGIN
    PROCESS (clr, qd, set, alarm)
    BEGIN
        IF (clr = '1') THEN -- Clear the digits
            tmp_low <= "0000";
            tmp_high <= "0000";
        ELSIF (set = '1') THEN -- Process Carry
            IF (qd'event AND qd = '0') THEN
                IF (tmp_low = 9) THEN
                    tmp_low <= "0000";
                    IF (tmp_high = 5) THEN
                        tmp_high <= "0000";
                    ELSE
                        tmp_high <= tmp_high + 1;
                    END IF;
                ELSE
                    tmp_low <= tmp_low + 1;
                END IF;
            END IF;
            low_num <= tmp_low;
            high_num <= tmp_high;
        END IF;
    END PROCESS;
END func;