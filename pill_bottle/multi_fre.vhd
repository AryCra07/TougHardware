LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY multi_fre IS
    PORT (
        clk : IN STD_LOGIC;
        clk_0 : OUT STD_LOGIC; --1Hz
        clk_125 : OUT STD_LOGIC; --1Hz with delay 0.125s
        clk_250 : OUT STD_LOGIC --1Hz with delay 0.25s
    );
END multi_fre;

ARCHITECTURE func OF multi_fre IS
    SIGNAL tcount : INTEGER RANGE 0 TO 10000;
    SIGNAL divide_0 : STD_LOGIC; --1Hz
    SIGNAL divide_125 : STD_LOGIC; --1Hz-0.125s
    SIGNAL divide_250 : STD_LOGIC; --1Hz-0.25s

BEGIN

    p1 : PROCESS (clk) --10k
    BEGIN
        IF (clk 'event AND clk = '1') THEN
            IF tcount = 10000 THEN
                tcount <= 0;
            ELSE
                tcount <= tcount + 1;
            END IF;
        END IF;
    END PROCESS;

    p2 : PROCESS (clk, tcount)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            -- clk_0
            IF (tcount < 5000) THEN
                divide_0 <= '1';
            ELSE
                divide_0 <= '0';
            END IF;
            -- clk_125
            IF (tcount > 1249 AND tcount < 6250) THEN
                divide_125 <= '1';
            ELSE
                divide_125 <= '0';
            END IF;
            -- clk_250
            IF (tcount > 2499 AND tcount < 7500) THEN
                divide_250 <= '1';
            ELSE
                divide_250 <= '0';
            END IF;
        END IF;
        -- output
        clk_0 <= divide_0;
        clk_125 <= divide_125;
        clk_250 <= divide_250;
    END PROCESS;
END func;