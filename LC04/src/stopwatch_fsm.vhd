--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--------------------------------------------------------------------------------
ENTITY stopwatch_fsm IS
  PORT (
    CLK                 : IN    STD_LOGIC;
    BTN_S_S             : IN    STD_LOGIC;
    BTN_L_C             : IN    STD_LOGIC;
    CNT_RESET           : OUT   STD_LOGIC;
    CNT_ENABLE          : OUT   STD_LOGIC;
    DISP_ENABLE         : OUT   STD_LOGIC
  );
END ENTITY stopwatch_fsm;
--------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF stopwatch_fsm IS
--------------------------------------------------------------------------------

  -- State encoding
  TYPE state_type IS (Idle, Run, Lap, Refresh, Stop);
  SIGNAL pres_st, next_st : state_type;

--------------------------------------------------------------------------------
BEGIN
--------------------------------------------------------------------------------

  ------------------------------------------------------------------------------
  -- State register
  ------------------------------------------------------------------------------
  PROCESS (CLK)
  BEGIN
    IF rising_edge(CLK) THEN
      pres_st <= next_st;
    END IF;
  END PROCESS;

  ------------------------------------------------------------------------------
  -- Next-state logic
  ------------------------------------------------------------------------------
  PROCESS (pres_st, BTN_S_S, BTN_L_C)
  BEGIN
    CASE pres_st IS

      --------------------------------------------------------------------------
      WHEN Idle =>
        IF BTN_S_S = '1' THEN
          next_st <= Run;
        ELSIF BTN_L_C = '1' THEN
          next_st <= Idle;
        ELSE
          next_st <= Idle;
        END IF;

      --------------------------------------------------------------------------
      WHEN Run =>
        IF BTN_S_S = '1' THEN
          next_st <= Stop;
        ELSIF BTN_L_C = '1' THEN
          next_st <= Lap;
        ELSE
          next_st <= Run;
        END IF;

      --------------------------------------------------------------------------
      WHEN Lap =>
        IF BTN_S_S = '1' THEN
          next_st <= Run;
        ELSIF BTN_L_C = '1' THEN
          next_st <= Refresh;
        ELSE
          next_st <= Lap;
        END IF;

      --------------------------------------------------------------------------
      WHEN Refresh =>
        IF BTN_S_S = '1' THEN
          next_st <= Lap;
        ELSIF BTN_L_C = '1' THEN
          next_st <= Lap;
        ELSE
          next_st <= Lap;
        END IF;

      --------------------------------------------------------------------------
      WHEN Stop =>
        IF BTN_S_S = '1' THEN
          next_st <= Run;
        ELSIF BTN_L_C = '1' THEN
          next_st <= Idle;
        ELSE
          next_st <= Stop;
        END IF;

    END CASE;
  END PROCESS;

  ------------------------------------------------------------------------------
  -- Output logic
  ------------------------------------------------------------------------------
  PROCESS (pres_st)
  BEGIN
    CASE pres_st IS

      WHEN Idle =>
        CNT_RESET   <= '1';
        CNT_ENABLE  <= '0';
        DISP_ENABLE <= '1';

      WHEN Run =>
        CNT_RESET   <= '0';
        CNT_ENABLE  <= '1';
        DISP_ENABLE <= '1';

      WHEN Lap =>
        CNT_RESET   <= '0';
        CNT_ENABLE  <= '1';
        DISP_ENABLE <= '0';

      WHEN Refresh =>
        CNT_RESET   <= '0';
        CNT_ENABLE  <= '1';
        DISP_ENABLE <= '1';

      WHEN Stop =>
        CNT_RESET   <= '0';
        CNT_ENABLE  <= '0';
        DISP_ENABLE <= '1';

    END CASE;
  END PROCESS;

--------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
--------------------------------------------------------------------------------
