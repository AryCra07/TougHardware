LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY minute IS
    PORT (
        in_high : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        in_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        clk : IN STD_LOGIC;
        clr : IN STD_LOGIC;
        set : IN STD_LOGIC;
        out_high : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        out_low : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        cout : OUT STD_LOGIC;      
        flash_in:IN STD_LOGIC;
        clk_1:IN STD_LOGIC;
        
        
         alarm_min : OUT STD_LOGIC;
         alarm_high :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         alarm_low : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END minute;

ARCHITECTURE func OF minute IS
    SIGNAL tmp_low, tmp_high : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL count : STD_LOGIC;
     SIGNAL flash : STD_LOGIC;
BEGIN
    PROCESS (clr, set,clk,flash,flash_in)
    BEGIN
        IF (clr = '1') THEN -- clear all
            tmp_low <= "0000";
            tmp_high <= "0000";
        ELSIF (set = '1' AND clr = '0' ) THEN
            tmp_low <= in_low;
            tmp_high <= in_high;
        ELSIF (clk'event AND clk = '1') THEN
            IF ((set = '0' AND clr = '0' )) THEN
                IF (tmp_low = 9) THEN
                    tmp_low <= "0000";
                    IF (tmp_high = 5) THEN
                        tmp_high <= "0000";
                        count <= '1';
                    ELSE
                        tmp_high <= tmp_high + 1;
                        count <= '0';
                    END IF;
                ELSE
                    tmp_low <= tmp_low + 1;
                    count <= '0';
                END IF;
            END IF;
        END IF;
        
        if(tmp_low=alarm_low AND tmp_high=alarm_high)then
          alarm_min<='1';
        else
          alarm_min<='0';
        end if;
        
        
        if(flash_in='1')then
           if(set='1')then
             if(flash='0')then
             out_low <= tmp_low;
             out_high <= tmp_high;
             else
              out_low <= "1111";
              out_high <= "1111";
             end if;
           else
              out_low <= tmp_low;
              out_high <= tmp_high;
           end if;

        elsif(flash_in='0')then
         out_low <= tmp_low;
         out_high <= tmp_high;
        end if;
        
        cout <= count;
    END PROCESS;
    
    
    PROCESS (clk_1)
    BEGIN
    if(clk_1'event AND clk_1 = '1')then
      flash<=not flash;
    end if;
    END PROCESS;
    
    
END func;