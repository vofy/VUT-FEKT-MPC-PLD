library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY rp_top IS
  PORT(
    CLK             : IN  STD_LOGIC;
    BTN             : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
    SW              : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
    LED             : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    DISP_SEG        : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
    DISP_DIG        : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
    UART_TXD        : OUT STD_LOGIC
  );
END ENTITY rp_top;

architecture Behavioral of rp_top is

  --------------------------------------------------------------------------------
--  COMPONENT seg_disp_driver
--  PORT(
--    CLK             : IN  STD_LOGIC;
--    DIG_1           : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
--    DIG_2           : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
--    DIG_3           : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
--    DIG_4           : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
--    DP              : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);        -- [DP4 DP3 DP2 DP1]
--    DOTS            : IN  STD_LOGIC_VECTOR (2 DOWNTO 0);        -- [L3 L2 L1]
--    DISP_SEG        : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--    DISP_DIG        : OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
--  );
--  END COMPONENT seg_disp_driver;
  
  --------------------------------------------------------------------------------
  COMPONENT ce_gen
  GENERIC (
    G_DIV_FACT          : POSITIVE := 2
  );
  PORT (
    CLK                 : IN  STD_LOGIC;        -- clock signal
    SRST                : IN  STD_LOGIC;        -- synchronous reset
    CE                  : IN  STD_LOGIC;        -- input clock enable
    CE_O                : OUT STD_LOGIC         -- clock enable output
  );
  END COMPONENT ce_gen;
  
  --------------------------------------------------------------------------------
  COMPONENT btn_in IS
  GENERIC(
    G_DEB_PERIOD        : POSITIVE := 3
  );
  PORT(
    CLK                 : IN    STD_LOGIC;
    CE                  : IN    STD_LOGIC;
    BTN                 : IN    STD_LOGIC;
    BTN_DEBOUNCED       : OUT   STD_LOGIC;
    BTN_EDGE_POS        : OUT   STD_LOGIC;
    BTN_EDGE_NEG        : OUT   STD_LOGIC;
    BTN_EDGE_ANY        : OUT   STD_LOGIC
  );
  END COMPONENT btn_in;
  
  --------------------------------------------------------------------------------
  COMPONENT uart_tx is
    PORT(
        CLK : IN STD_LOGIC;
        TX_START : IN STD_LOGIC;
        CLK_EN : IN STD_LOGIC;
        DATA_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        TX_BUSY : OUT STD_LOGIC;
        UART_TXD : OUT STD_LOGIC
    );
  END COMPONENT uart_tx;
 
  --------------------------------------------------------------------------------
  SIGNAL ce_100hz       : STD_LOGIC;
  SIGNAL ce_uart        : STD_LOGIC;
  SIGNAL cnt_enable     : STD_LOGIC;
  SIGNAL disp_enable    : STD_LOGIC;
  SIGNAL cnt_reset      : STD_LOGIC;
  SIGNAL btn_0_deb      : STD_LOGIC;
  SIGNAL data_in_sig    : STD_LOGIC_VECTOR (7 downto 0);

begin

  --------------------------------------------------------------------------------
--  seg_disp_driver_i : seg_disp_driver
--  PORT MAP(
--    CLK                 => CLK,
--    DIG_1               => cnt_3,
--    DIG_2               => cnt_2,
--    DIG_3               => cnt_1,
--    DIG_4               => cnt_0,
--    DP                  => "0000",
--    DOTS                => "011",
--    DISP_SEG            => DISP_SEG,
--    DISP_DIG            => DISP_DIG
--  );

  --------------------------------------------------------------------------------
  ce_gen_i : ce_gen
  GENERIC MAP (
    G_DIV_FACT          => 500000
  )
  PORT MAP (
    CLK                 => CLK,
    SRST                => '0',
    CE                  => '1',-- Always enable
    CE_O                => ce_100hz
  );
  
  ce_gen_uart : ce_gen
  GENERIC MAP (
    G_DIV_FACT          => 434 -- 50 000 000 (clock) / 115 200 (baud)
  )
  PORT MAP (
    CLK                 => CLK,
    SRST                => '0',
    CE                  => '1',-- Always enable
    CE_O                => ce_uart
  );
  
  --------------------------------------------------------------------------------
  btn_in_0 : btn_in
  GENERIC MAP(
    G_DEB_PERIOD        => 3
  )
  PORT MAP(
    CLK                 => CLK,
    CE                  => ce_100hz,
    BTN                 => btn(0),
    BTN_EDGE_POS        => btn_0_deb
  );
  
  --------------------------------------------------------------------------------
  uart_tx_i : uart_tx
    PORT MAP(
        CLK             => CLK,
        TX_START        => btn_0_deb,
        CLK_EN          => ce_uart,
        DATA_IN         => data_in_sig,
        TX_BUSY         => LED(0),
        UART_TXD        => UART_TXD
    );
    
    data_in_sig <= "0011" & SW;


end Behavioral;
