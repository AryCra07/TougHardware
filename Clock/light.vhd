LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY light IS
    PORT (
        led : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        light : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END light;

ARCHITECTURE func OF light IS
BEGIN
    PROCESS (led)
    BEGIN
        CASE led IS
            WHEN "0000" => light <= "0111111";
            WHEN "0001" => light <= "0000110";
            WHEN "0010" => light <= "1011011";
            WHEN "0011" => light <= "1001111";
            WHEN "0100" => light <= "1100110";
            WHEN "0101" => light <= "1101101";
            WHEN "0110" => light <= "1111101";
            WHEN "0111" => light <= "0000111";
            WHEN "1000" => light <= "1111111";
            WHEN "1001" => light <= "1101111";
            WHEN OTHERS => light <= "0000000";
        END CASE;
    END PROCESS;
END func;