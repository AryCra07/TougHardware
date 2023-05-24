LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY vga_mode_selector IS
    GENERIC (
        MODE_COUNT : INTEGER := 3
    );
    PORT (
        clk : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        qd : IN STD_LOGIC;
        mode_state : OUT NATURAL
    );
END ENTITY vga_mode_selector;

ARCHITECTURE rtl OF vga_mode_selector IS
    CONSTANT HORIZONTAL_COLOR_BAR : NATURAL := 0;
    CONSTANT VERTICAL_COLOR_BAR : NATURAL := 1;
    CONSTANT COLOR_SQUARE : NATURAL := 2;
    CONSTANT FULLSCREEN_COLOR : NATURAL := 3;
    
    SIGNAL state : NATURAL RANGE 0 TO MODE_COUNT - 1;
BEGIN
    PROCESS (qd, clr)
    BEGIN
        IF clr = '1' THEN
            state <= 0;
        ELSIF (qd'event AND qd = '0') THEN
            state = (state + 1) mod MODE_COUNT;
        END IF;
    END PROCESS;
	
	-- OUTPUT
    mode_state <= state;
END ARCHITECTURE rtl;