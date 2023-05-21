LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ring IS
    PORT (
        clk, min_ring, hour_ring, hour : IN STD_LOGIC;
        qout : OUT STD_LOGIC);
END ring;

ARCHITECTURE func OF ring IS
    SIGNAL mode : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL temp : STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
    PROCESS (clk, min_ring, hour_ring, hour)
    BEGIN
        mode <= min_ring & hour_ring & hour;
        IF (clk'event AND clk = '1') THEN
            IF (temp = 59) THEN
                temp <= "000000";
            ELSE
                temp <= temp + 1;
            END IF;
            IF (mode = "001" AND temp > 2) THEN -- hourly chime rings 2s 
                qout <= '0';
            ELSIF (mode = "001") THEN
                qout <= '1';
            ELSIF (mode = "110" AND temp > 4) THEN -- alarm we set rings 4s
                qout <= '0';
            ELSIF (mode = "110") THEN
                qout <= '1';
            ELSIF (mode = "111" AND temp > 6) THEN -- both occur, then ring 6s
                qout <= '0';
            ELSIF (mode = "111") THEN
                qout <= '1';
            ELSE
                qout <= '0';
            END IF;
        END IF;
    END PROCESS;
END func;