LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY bottle_counter IS
    PORT (
        clk : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        co : IN STD_LOGIC;
        bottle_h : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        bottle_l : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        led_h : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        led_l : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        full : OUT STD_LOGIC
    );
END bottle_counter;

ARCHITECTURE func OF bottle_counter IS
    SIGNAL b_h : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL b_l : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL cur_h : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL cur_l : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL s_full : STD_LOGIC := '1';
BEGIN
    PROCESS (clk, clr)
    BEGIN
        IF (bottle_h > "0001") THEN
            b_h <= "0001";
            b_l <= "1000";
            --s_full<='0';
        ELSIF (bottle_h = "0001" AND bottle_l > "1000") THEN
            b_h <= bottle_h;
            b_l <= "1000";
            --s_full<='0';
        ELSIF (bottle_l > "1001") THEN
            b_h <= bottle_h;
            b_l <= "1001";
            --s_full<='0';
        ELSIF (bottle_h = "0000" AND bottle_l = "0000") THEN
            b_h <= "0000";
            b_l <= "0001";
            --s_full<='1';
        ELSE
            b_h <= bottle_h;
            b_l <= bottle_l;
            --s_full<='0';
        END IF;

        IF (clr = '1') THEN -- clear all
            cur_h <= "0000";
            cur_l <= "0000";
            s_full <= '0';
        ELSIF (clk'event AND clk = '1') THEN -- inc and carrya
            IF (co = '1') THEN
                IF (cur_l = "1001") THEN
                    cur_l <= "0000";
                    cur_h <= cur_h + 1;
                ELSE
                    cur_l <= cur_l + 1;
                END IF;

                -- full!
                IF (b_h = "0001" AND b_l = "0000") THEN
                    IF (cur_h = "0000" AND cur_l = "1001") THEN
                        s_full <= '1';
                    ELSE
                        s_full <= '0';
                    END IF;
                ELSE
                    IF (cur_h = b_h AND cur_l + 1 = b_l) THEN
                        s_full <= '1';
                    ELSE
                        s_full <= '0';
                    END IF;
                END IF;
            END IF; -- end co
        END IF; -- end clk
        -- output ---------------------------------------------------
        full <= s_full;
        led_l <= cur_l;
        led_h <= cur_h;
        -- end ------------------------------------------------------
    END PROCESS;
END func;