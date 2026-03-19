----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY edge_detector IS
  PORT(
    CLK                 : IN    STD_LOGIC;
    SIG_IN              : IN    STD_LOGIC;
    EDGE_POS            : OUT   STD_LOGIC;
    EDGE_NEG            : OUT   STD_LOGIC;
    EDGE_ANY            : OUT   STD_LOGIC
  );
END ENTITY edge_detector;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF edge_detector IS
----------------------------------------------------------------------------------

SIGNAL btn_delayed  : std_logic;
SIGNAL sig_edge_pos : std_logic;
SIGNAL sig_edge_neg : std_logic;
SIGNAL sig_edge_any : std_logic;

----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------

edge_detector: PROCESS(clk)
BEGIN
    IF rising_edge(CLK) THEN
        btn_delayed <= SIG_IN;
        
        IF SIG_IN = '1' and btn_delayed = '0' THEN
            sig_edge_pos <= '1';
        ELSE
            sig_edge_pos <= '0';
        END IF;
        
        IF SIG_IN = '0' and btn_delayed = '1' THEN
            sig_edge_neg <= '1';
        ELSE
            sig_edge_neg <= '0';
        END IF;
        
        IF sig_edge_pos = '1' or sig_edge_neg = '1' THEN
            sig_edge_any <= '1';
        ELSE
            sig_edge_any <= '0';
        END IF;
    END IF;
end PROCESS;

EDGE_POS <= sig_edge_pos;
EDGE_NEG <= sig_edge_neg;
EDGE_ANY <= sig_edge_any;

----------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
----------------------------------------------------------------------------------
