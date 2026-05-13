----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY debouncer IS
  GENERIC(
    G_DEB_PERIOD        : POSITIVE := 3
  );    
  PORT( 
    CLK                 : IN    STD_LOGIC;
    CE                  : IN    STD_LOGIC;
    BTN_IN              : IN    STD_LOGIC;
    BTN_OUT             : OUT   STD_LOGIC := '0'
  );
END ENTITY debouncer;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF debouncer IS
----------------------------------------------------------------------------------

SIGNAL sh_reg : STD_LOGIC_VECTOR(G_DEB_PERIOD-1 DOWNTO 0);

----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------

PROCESS (CLK) BEGIN
    IF rising_edge(CLK) THEN
        IF CE = '1' THEN
            sh_reg <= sh_reg (G_DEB_PERIOD-2 DOWNTO 0) & BTN_IN;
            IF sh_reg = (sh_reg'RANGE => '1') THEN
                BTN_OUT <= '1';
            END IF;
            IF sh_reg = (sh_reg'RANGE => '0') THEN
                BTN_OUT <= '0';
            END IF;
        END IF;
    END IF;
END PROCESS;

----------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
----------------------------------------------------------------------------------
