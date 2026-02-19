----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2026 10:00:09 AM
-- Design Name: 
-- Module Name: LED_demo - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
