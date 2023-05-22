LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY bottle_control IS
    PORT (
        clr : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        start : IN STD_LOGIC;
        out_clr : OUT STD_LOGIC;
        out_clk : OUT STD_LOGIC;
        out_start : OUT STD_LOGIC
    );
END bottle_control;

ARCHITECTURE func OF bottle_control IS
BEGIN
    out_clr <= clr;
    out_clk <= clk;
    out_start <= start;
END func;