LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY second IS
    PORT (
        clk, clr,  set: IN STD_LOGIC;
        digit0, digit1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        pause : IN STD_LOGIC;
        cout : OUT STD_LOGIC);
END second;

ARCHITECTURE func OF second IS
    SIGNAL tmp_digit0, tmp_digit1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL temp_cout : STD_LOGIC;
BEGIN
    PROCESS (clk, clr, set)
    
    BEGIN
        IF (clr = '1') THEN -- clear all
            tmp_digit0 <= "0000";
            tmp_digit1 <= "0000";
        ELSIF (clk'event AND clk = '1' AND pause='0') THEN
            IF (set='0' AND clr='0') THEN
                IF (tmp_digit0 = "1001" AND tmp_digit1 = "0101") THEN -- process carry of  59->00
                    tmp_digit0 <= "0000";
                    tmp_digit1 <= "0000";
                    temp_cout <= '1';
                ELSIF (tmp_digit0 = "1001") THEN -- process carry of 9->0
                    tmp_digit0 <= "0000";
                    tmp_digit1 <= tmp_digit1 + 1;
                    temp_cout <= '0';
                ELSE
                    tmp_digit0 <= tmp_digit0 + 1;
                    temp_cout <= '0';
                END IF;
            END IF;
        END IF;
        digit0 <= tmp_digit0;
        digit1 <= tmp_digit1;
        cout <= temp_cout;
    END PROCESS;
END func;