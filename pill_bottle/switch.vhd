LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY switch IS
    PORT (
        clk : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        bottle_h : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        bottle_l : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        pcnt_h : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        pcnt_m : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        pcnt_l : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        bcnt_h : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        bcnt_l : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        led3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        led2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        led1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END switch;

ARCHITECTURE func OF switch IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF (clr = '1') THEN
            led3 <= "0000";
            led2 <= "0000";
            led1 <= "0000";
        ELSIF (clk'event AND clk = '1') THEN
            CASE (mode) IS
                WHEN "00" =>
                    led3 <= "0000";
                    led2 <= bottle_h;
                    led1 <= bottle_l;
                WHEN "01" =>
                    led3 <= pcnt_h;
                    led2 <= pcnt_m;
                    led1 <= pcnt_l;
                WHEN "10" =>
                    led3 <= "0000";
                    led2 <= bcnt_h;
                    led1 <= bcnt_l;
                WHEN OTHERS => NULL;
            END CASE;
        END IF;
    END PROCESS;
END func;