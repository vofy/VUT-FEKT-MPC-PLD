----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY ce_gen IS
  GENERIC (
    G_DIV_FACT          : POSITIVE := 2
  );
  PORT (
    CLK                 : IN  STD_LOGIC;        -- clock signal
    SRST                : IN  STD_LOGIC;        -- synchronous reset
    CE                  : IN  STD_LOGIC;        -- input clock enable
    CE_O                : OUT STD_LOGIC := '0'  -- clock enable output
  );
END ENTITY ce_gen;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF ce_gen IS
----------------------------------------------------------------------------------

SIGNAL cnt_div: INTEGER RANGE 0 TO G_DIV_FACT := 0;

----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------

clk_en_gen : process (CLK)
begin
    if rising_edge(CLK) then
        if CE = '1' then
            if SRST = '1' or cnt_div = G_DIV_FACT then
                cnt_div <= 0;
                CE_O <= '1';
            else
                cnt_div <= cnt_div + 1;
                CE_O <= '0';
            end if;
        end if;
    end if;
end process;


----------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
----------------------------------------------------------------------------------
