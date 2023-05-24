LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY vga_display IS
    PORT (
        clk : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        qd : IN STD_LOGIC;
        vga_hsync : OUT STD_LOGIC;
        vga_vsync : OUT STD_LOGIC;
        vga_red : OUT STD_LOGIC;
        vga_green : OUT STD_LOGIC;
        vga_blue : OUT STD_LOGIC
    );
END ENTITY vga_display;

ARCHITECTURE rtl OF vga_display IS
    -- 定义颜色常量
    CONSTANT BLACK : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    CONSTANT YELLOW_1 : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT RED : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
    CONSTANT MAGENTA : STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";
    CONSTANT GREEN : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100";
    CONSTANT CYAN : STD_LOGIC_VECTOR(2 DOWNTO 0) := "101";
    CONSTANT YELLOW_2 : STD_LOGIC_VECTOR(2 DOWNTO 0) := "110";
    CONSTANT WHITE : STD_LOGIC_VECTOR(2 DOWNTO 0) := "111";
BEGIN
    -- VGA颜色生成
    PROCESS (counter, mode_state, clk, rst)
    BEGIN
		
		IF clr = '1' THEN
            -- 初始化
            vga_hsync <= '0';
        ELSIF rising_edge(clk) THEN
            -- 生成HSYNC信号
            IF counter < 800 THEN
                vga_hsync <= '0';
            ELSE
                vga_hsync <= '1';
            END IF;
        END IF;
		
        CASE mode_state IS
            WHEN HORIZONTAL_COLOR_BAR =>
                IF counter < 80 THEN
                    vga_red <= BLACK(2);
                    vga_green <= BLACK(1);
                    vga_blue <= BLACK(0);
                ELSIF counter < 160 THEN
                    vga_red <= YELLOW_1(2);
                    vga_green <= YELLOW_1(1);
                    vga_blue <= YELLOW_1(0);
                ELSIF counter < 240 THEN
                    vga_red <= RED(2);
                    vga_green <= RED(1);
                    vga_blue <= RED(0);
                ELSIF counter < 320 THEN
                    vga_red <= MAGENTA(2);
                    vga_green <= MAGENTA(1);
                    vga_blue <= MAGENTA(0);
                ELSIF counter < 400 THEN
                    vga_red <= GREEN(2);
                    vga_green <= GREEN(1);
                    vga_blue <= GREEN(0);
                ELSIF counter < 480 THEN
                    vga_red <= CYAN(2);
                    vga_green <= CYAN(1);
                    vga_blue <= CYAN(0);
                ELSE
                    vga_red <= WHITE(2);
                    vga_green <= WHITE(1);
                    vga_blue <= WHITE(0);
                END IF;

            WHEN OTHERS =>
                vga_red <= BLACK(0);
                vga_green <= BLACK(0);
                vga_blue <= BLACK(0);
        END CASE;
    END PROCESS;

END ARCHITECTURE rtl;