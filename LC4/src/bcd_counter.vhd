----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY bcd_counter IS
  PORT(
    CLK                 : IN    STD_LOGIC;      -- clock signal
    CE_100HZ            : IN    STD_LOGIC;      -- 100 Hz clock enable
    CNT_RESET           : IN    STD_LOGIC;      -- counter reset
    CNT_ENABLE          : IN    STD_LOGIC;      -- counter enable
    DISP_ENABLE         : IN    STD_LOGIC;      -- enable display update
    CNT_0               : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
    CNT_1               : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
    CNT_2               : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
    CNT_3               : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END ENTITY bcd_counter;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF bcd_counter IS
----------------------------------------------------------------------------------
    -- SUBTYPES 0_to_9 a 0_to_5
    -- SUBTYPE INTEGER_0_to_9 is INTEGER RANGE 0 TO 9;
    -- SUBTYPE INTEGER_0_to_5 is INTEGER RANGE 0 TO 5;

    SIGNAL cnt_0_reg : INTEGER RANGE 0 TO 9 := 0;
    SIGNAL cnt_1_reg : INTEGER RANGE 0 TO 9 := 0;
    SIGNAL cnt_2_reg : INTEGER RANGE 0 TO 9 := 0;
    SIGNAL cnt_3_reg : INTEGER RANGE 0 TO 5 := 0;

----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------
  -- BCD counter

    BCD_counter : PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            IF CNT_RESET = '1' THEN
                cnt_0_reg <= 0;
                cnt_1_reg <= 0;
                cnt_2_reg <= 0;
                cnt_3_reg <= 0;
            ELSIF CE_100HZ = '1' AND CNT_ENABLE = '1' THEN
                IF cnt_0_reg = 9 THEN
                    cnt_0_reg <= 0;
                    IF cnt_1_reg = 9 THEN
                        cnt_1_reg <= 0;
                        IF cnt_2_reg = 9 THEN
                            cnt_2_reg <= 0;
                            IF cnt_3_reg = 5 THEN
                                cnt_3_reg <= 0;
                            ELSE
                                cnt_3_reg <= cnt_3_reg + 1;
                            END IF;
                        ELSE
                            cnt_2_reg <= cnt_2_reg + 1;
                        END IF;
                    ELSE
                        cnt_1_reg <= cnt_1_reg + 1;
                    END IF;
                ELSE
                    cnt_0_reg <= cnt_0_reg + 1;
                END IF;
            END IF;
            
                report "CNT: " &
                   integer'image(cnt_3_reg) &
                   integer'image(cnt_2_reg) &
                   integer'image(cnt_1_reg) &
                   integer'image(cnt_0_reg);
        END IF;
    END PROCESS;

    --------------------------------------------------------------------------------
    -- Output (display) register

    CNT_0 <= std_logic_vector(to_unsigned(cnt_0_reg, CNT_0'LENGTH));
    CNT_1 <= std_logic_vector(to_unsigned(cnt_1_reg, CNT_1'LENGTH));
    CNT_2 <= std_logic_vector(to_unsigned(cnt_2_reg, CNT_2'LENGTH));
    CNT_3 <= std_logic_vector(to_unsigned(cnt_3_reg, CNT_3'LENGTH)); -- test "0101"

----------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
----------------------------------------------------------------------------------