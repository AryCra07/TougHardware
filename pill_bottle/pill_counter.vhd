LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY pill_counter IS
    PORT (
        clk : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        start : IN STD_LOGIC;
        count : IN STD_LOGIC;
        led_l : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        led_m : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        led_h : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END pill_counter;

ARCHITECTURE func OF pill_counter IS
    SIGNAL temp_h : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL temp_m : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL temp_l : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    PROCESS (clk, start, clr)
    BEGIN
        IF (clr = '1') THEN
            temp_h <= "0000"; --�첽����
            temp_m <= "0000";
            temp_l <= "0000";
        ELSIF (start = '1') THEN
            IF (clk'event AND clk = '1') THEN
                IF (count = '1') THEN
                    IF (temp_l = "1001" AND temp_m = "1001") THEN
                        temp_l <= "0000";
                        temp_m <= "0000";
                        temp_h <= temp_h + 1;
                    ELSIF (temp_l = "1001") THEN
                        temp_l <= "0000";
                        temp_m <= temp_m + 1;
                    ELSE
                        temp_l <= temp_l + 1;
                    END IF;

                END IF;
            END IF;
        END IF;
        -- output ---------------------------------------------------
        led_h <= temp_h;
        led_m <= temp_m;
        led_l <= temp_l;
        -- end ------------------------------------------------------
    END PROCESS;
END func;