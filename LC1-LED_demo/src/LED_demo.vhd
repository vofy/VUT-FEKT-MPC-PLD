library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LED_demo is
    Port ( SW : in STD_LOGIC_VECTOR (1 to 4);           -- 0 1 Z U H L
           BTN : in STD_LOGIC_VECTOR (1 to 4);
           LED : out STD_LOGIC_VECTOR (7 downto 0));
end LED_demo;

architecture Behavioral of LED_demo is

begin

    keylock: PROCESS(SW,BTN)
    BEGIN
        IF SW = "0101" AND BTN = "1001" THEN
            LED(0) <= '1';
        ELSE
            LED(0) <= '0';
        END IF;
    END PROCESS keylock;
    
    LED(7 DOWNTO 1) <= "0000000";
    
end Behavioral;
