LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY vga_hsync_generator IS
    GENERIC (
        H_SYNC_START : INTEGER := 640,
        H_SYNC_END : INTEGER := 800
    );
    PORT (
		clr : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        counter : IN UNSIGNED(7 DOWNTO 0);
        hsync : OUT STD_LOGIC
    );
END ENTITY vga_hsync_generator;

ARCHITECTURE rtl OF vga_hsync_generator IS
BEGIN
    PROCESS (clr, clk, counter)
    BEGIN
		IF (clr = '1') THEN
			counter <= (OTHERS => '0');
			hsync <= '0';
        ELSIF rising_edge(clk) THEN
            IF counter >= H_SYNC_START AND counter < H_SYNC_END THEN
                hsync <= '1';
            ELSE
                hsync <= '0';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE rtl;