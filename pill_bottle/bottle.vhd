LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY bottle IS
    PORT (
        start : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        tablets_h : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        tablets_l : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        full : IN STD_LOGIC;
        led_h : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        led_l : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        cout : OUT STD_LOGIC;
        light_red : OUT STD_LOGIC;
        light_green : OUT STD_LOGIC
    );
END bottle;

ARCHITECTURE func OF bottle IS
    SIGNAL t_h : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL t_l : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL temp_h : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL temp_l : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL s_full : STD_LOGIC := '0';
    SIGNAL signal_state : STD_LOGIC := '0';
BEGIN
    PROCESS (clk, clr, start, full)
    BEGIN
        -- clear all
        IF (clr = '1') THEN
            signal_state <= '0';
            temp_h <= "0000";
            temp_l <= "0000";
            cout <= '0';
            light_red <= '1';
            light_green <= '0';

            -- here we go!
        ELSIF (start = '1') THEN
            IF (clk'event AND clk = '1') THEN
                IF (s_full = '0') THEN -- the current bottle is not full yet
                    -- stop state -> work state
                    IF (signal_state = '0') THEN
                        --	yea the upper capacity of bottle is 50
                        IF (tablets_h >= "0101") THEN
                            t_h <= "0101";
                            t_l <= "0000";
                            light_red <= '1'; -- red light for warning
                        ELSIF (tablets_l > "1001") THEN
                            t_h <= tablets_h;
                            t_l <= "1001";
                            light_red <= '1'; -- red light for warning
                        ELSIF (tablets_h = "0000" AND tablets_l = "0000") THEN
                            t_h <= "0000";
                            t_l <= "0001";
                            light_red <= '1'; -- red light for warning
                        ELSE
                            t_h <= tablets_h;
                            t_l <= tablets_l;
                            light_red <= '0';
                        END IF;
                        signal_state <= '1'; -- switch state to work
                        temp_h <= "0000";
                        temp_l <= "0000";
                        -- output
                        cout <= '0';
                        light_green <= '0';

                        -- work state
                    ELSIF (signal_state = '1') THEN
                        -- clk:+1 with output
                        IF (temp_l = "1001") THEN -- carry of 9->0
                            temp_l <= "0000";
                            temp_h <= temp_h + 1;
                        ELSE
                            temp_l <= temp_l + 1;
                        END IF;
                        cout <= '0';
                        light_red <= '0';
                        light_green <= '1';

                        -- FULL! switch state with light switched(the signal isn't +1)
                        IF (t_l = "0000") THEN -- for example when the input is 20
                            IF (t_h = temp_h + 1 AND temp_l = "1001") THEN -- then 19 is full
                                signal_state <= '0'; -- switch state
                                cout <= '1';
                                light_red <= '1';
                            END IF;
                        ELSE -- low digit is not 0, such as the input is 19
                            IF (t_h = temp_h AND t_l = temp_l + 1) THEN -- then 18 is full
                                signal_state <= '0'; -- switch state
                                cout <= '1';
                                light_red <= '1';
                            END IF;
                        END IF;
                    END IF;
                    s_full <= full;
                ELSE
                    light_red <= '1';
                END IF; -- end full
            END IF; -- end clk
        END IF; -- end clr
        -- output ---------------------------------------------------
        led_h <= temp_h;
        led_l <= temp_l;
        -- end ------------------------------------------------------
    END PROCESS;
END func;