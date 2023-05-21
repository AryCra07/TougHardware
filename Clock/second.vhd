LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY second IS
    PORT (
        clk, clr, pause, set_hour, set_min, alarm : IN STD_LOGIC;
        digit0, digit1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        cout : OUT STD_LOGIC);
END second;

ARCHITECTURE func OF second IS
    SIGNAL temp_digit0, temp_digit1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL temp_cout : STD_LOGIC;
BEGIN
    PROCESS (clk, clr, pause, set_hour, alarm, set_min)
    BEGIN
        IF (clr = '1') THEN
            temp_digit0 <= "0000";
            temp_digit1 <= "0000";
        ELSIF (clk'event AND clk = '0') THEN
            IF (clr = '0' AND pause = '0' AND set_hour = '0' AND alarm = '0' AND set_min = '0') THEN
                IF (temp_digit0 = "1001" AND temp_digit1 = "0101") THEN
                    temp_digit0 <= "0000";
                    temp_digit1 <= "0000";
                    temp_cout <= '1';
                ELSIF (temp_digit0 = "1001") THEN
                    temp_digit0 <= "0000";
                    temp_digit1 <= temp_digit1 + 1;
                    temp_cout <= '0';
                ELSE
                    temp_digit0 <= temp_digit0 + 1;
                    temp_cout <= '0';
                END IF;
            END IF;
        END IF;
        digit0 <= temp_digit0;
        digit1 <= temp_digit1;
        cout <= temp_cout;
    END PROCESS;
END func;