LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY vga_vsync_generator IS
    GENERIC (
        V_SYNC_START : INTEGER := 480,
        V_SYNC_END : INTEGER := 500
    );
    PORT (
		clr : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        counter : IN UNSIGNED(7 DOWNTO 0);
        vsync : OUT STD_LOGIC
    );
END ENTITY vga_vsync_generator;

ARCHITECTURE rtl OF vga_vsync_generator IS
BEGIN
    PROCESS (clr, clk, counter)
    BEGIN
		IF (clr = '1') THEN
			counter <= (OTHERS => '0');
			vsync <= '0';
        IF rising_edge(clk) THEN
            IF counter / 25 >= V_SYNC_START AND counter / 25 < V_SYNC_END THEN
                vsync <= '1';
            ELSE
                vsync <= '0';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE rtl;