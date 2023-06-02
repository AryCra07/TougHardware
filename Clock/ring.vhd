LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ring IS
    PORT (
        clk, hour, clk_2 : IN STD_LOGIC;
        out_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        out_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        out1_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        out1_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        alarm_min : IN STD_LOGIC;
        alarm_hour : IN STD_LOGIC;
        qout : OUT STD_LOGIC);
END ring;

ARCHITECTURE func OF ring IS
    SIGNAL temp : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL flag : STD_LOGIC;
    SIGNAL flag1 : STD_LOGIC;
    SIGNAL ala : STD_LOGIC;
BEGIN
    PROCESS (clk, hour, ala)
    BEGIN
        ala <= alarm_min AND alarm_hour;
        IF (hour = '1') THEN
            flag <= '1';
        ELSE
            flag <= '0';
        END IF;

        IF (ala = '1') THEN
            flag1 <= '1';
        ELSE
            flag1 <= '0';
        END IF;

    END PROCESS;
    PROCESS (clk_2)
    BEGIN
        IF (flag = '1') THEN
            IF (out1_low < 5 AND out1_high = 0 AND out_low = 0 AND out_high = 0) THEN
                qout <= clk_2;
            ELSE
                qout <= '0';
            END IF;
        END IF;

        IF (flag1 = '1') THEN
            IF (out1_low < 5 AND out1_high = 0) THEN
                qout <= clk_2;
            ELSE
                qout <= '0';
            END IF;
        END IF;
    END PROCESS;

END func;