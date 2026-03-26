library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_tx is
  PORT(
    CLK : IN STD_LOGIC;
    TX_START : IN STD_LOGIC;
    CLK_EN : IN STD_LOGIC;
    DATA_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    TX_BUSY : OUT STD_LOGIC;
    UART_TXD : OUT STD_LOGIC
  );
end uart_tx;

architecture Behavioral of uart_tx is

  -- State encoding
  type t_st_uart is (
    st_idle, st_wait, st_start_b, 
    st_bit_0, st_bit_1, st_bit_2, st_bit_3, 
    st_bit_4, st_bit_5, st_bit_6, st_bit_7, 
    st_stop_b
  );
  signal pres_st : t_st_uart := st_idle;
  signal next_st : t_st_uart;
  signal data_reg: std_logic_vector(7 downto 0) := (others => '0');

begin

  ------------------------------------------------------------------------------
  -- State register
  ------------------------------------------------------------------------------
  PROCESS (CLK)
  BEGIN
    IF rising_edge(CLK) THEN
        pres_st <= next_st;
    END IF;
  END PROCESS;
  
  PROCESS (CLK)
  BEGIN
    IF rising_edge(CLK) THEN -- Na tento radek nikdy nesahat
        -- Nesmi byt v next-state logic -> vznikl by latch
        -- Je potreba kontrolovat pres_st = st_idle jinak by se mohli prepsat data v prubehu komunikace
        IF TX_START = '1' and pres_st = st_idle THEN
              data_reg <= data_in;
        END IF;
    END IF;
  END PROCESS;
  
  ------------------------------------------------------------------------------
  -- Next-state logic
  ------------------------------------------------------------------------------
  -- Enable patří sem
  PROCESS (CLK_EN, TX_START, pres_st)
  BEGIN
    next_st <= pres_st;
    CASE pres_st IS
      --------------------------------------------------------------------------
      WHEN st_idle =>
        IF TX_START = '1' THEN
          next_st <= st_wait;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_wait =>
        IF CLK_EN = '1' THEN
            next_st <= st_start_b;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_start_b =>
        IF CLK_EN = '1' THEN
            next_st <= st_bit_0;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_bit_0 =>
        IF CLK_EN = '1' THEN
            next_st <= st_bit_1;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_bit_1 =>
        IF CLK_EN = '1' THEN
            next_st <= st_bit_2;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_bit_2 =>
        IF CLK_EN = '1' THEN
            next_st <= st_bit_3;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_bit_3 =>
        IF CLK_EN = '1' THEN
            next_st <= st_bit_4;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_bit_4 =>
        IF CLK_EN = '1' THEN
            next_st <= st_bit_5;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_bit_5 =>
        IF CLK_EN = '1' THEN
            next_st <= st_bit_6;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_bit_6 =>
        IF CLK_EN = '1' THEN
            next_st <= st_bit_7;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_bit_7 =>
        IF CLK_EN = '1' THEN
            next_st <= st_stop_b;
        END IF;
      --------------------------------------------------------------------------
      WHEN st_stop_b =>
        IF CLK_EN = '1' THEN
            next_st <= st_idle;
        END IF;

    END CASE;
  END PROCESS;

  ------------------------------------------------------------------------------
  -- Output logic
  ------------------------------------------------------------------------------
  PROCESS (pres_st)
  BEGIN
    CASE pres_st IS

      WHEN st_idle =>
        UART_TXD <= '1';
        TX_BUSY  <= '0';
        
      WHEN st_wait =>
        UART_TXD <= '1';
        TX_BUSY  <= '1';
        
      WHEN st_start_b =>
        UART_TXD <= '0';
        TX_BUSY  <= '1';

      WHEN st_bit_0 =>
        UART_TXD <= data_reg(0);
        TX_BUSY  <= '1';

      WHEN st_bit_1 =>
        UART_TXD <= data_reg(1);
        TX_BUSY  <= '1';

      WHEN st_bit_2 =>
        UART_TXD <= data_reg(2);
        TX_BUSY  <= '1';

      WHEN st_bit_3 =>
        UART_TXD <= data_reg(3);
        TX_BUSY  <= '1';

      WHEN st_bit_4 =>
        UART_TXD <= data_reg(4);
        TX_BUSY  <= '1';

      WHEN st_bit_5 =>
        UART_TXD <= data_reg(5);
        TX_BUSY  <= '1';

      WHEN st_bit_6 =>
        UART_TXD <= data_reg(6);
        TX_BUSY  <= '1';

      WHEN st_bit_7 =>
        UART_TXD <= data_reg(7);
        TX_BUSY  <= '1';

      WHEN st_stop_b =>
        UART_TXD <= '1';
        TX_BUSY  <= '1';

    END CASE;
  END PROCESS;

end Behavioral;
