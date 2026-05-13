library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_tx_tb is
end uart_tx_tb;

architecture Behavioral of uart_tx_tb is

    -- Component declaration
    component uart_tx
        PORT(
            CLK       : IN STD_LOGIC;
            TX_START  : IN STD_LOGIC;
            CLK_EN    : IN STD_LOGIC;
            DATA_IN   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            TX_BUSY   : OUT STD_LOGIC;
            UART_TXD  : OUT STD_LOGIC
        );
    end component;

    -- Signals
    signal CLK       : STD_LOGIC := '0';
    signal TX_START  : STD_LOGIC := '0';
    signal CLK_EN    : STD_LOGIC := '0';
    signal DATA_IN   : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    signal TX_BUSY   : STD_LOGIC;
    signal UART_TXD  : STD_LOGIC;
    signal simulation_finished    : BOOLEAN := FALSE;

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate DUT
    uut: uart_tx
        port map (
            CLK      => CLK,
            TX_START => TX_START,
            CLK_EN   => CLK_EN,
            DATA_IN  => DATA_IN,
            TX_BUSY  => TX_BUSY,
            UART_TXD => UART_TXD
        );

    --------------------------------------------------------------------------
    -- Clock generation
    --------------------------------------------------------------------------
      proc_clk_gen: PROCESS BEGIN
        clk <= '0'; WAIT FOR clk_period/2;
        clk <= '1'; WAIT FOR clk_period/2;
        IF simulation_finished THEN
          WAIT;
        END IF;
      END PROCESS proc_clk_gen;

    --------------------------------------------------------------------------
    -- Baud clock enable (simulace bitového času)
    --------------------------------------------------------------------------
    clk_en_process : process
    begin
        while true loop
            CLK_EN <= '0';
            wait for 80 ns;
            CLK_EN <= '1';
            wait for CLK_PERIOD;
            IF simulation_finished THEN
              WAIT;
            END IF;
        end loop;
    end process;

    --------------------------------------------------------------------------
    -- Stimulus process
    --------------------------------------------------------------------------
    stim_process : process
    begin
        -- Reset-like wait
        wait for 2 * CLK_PERIOD;

        ----------------------------------------------------------------------
        -- Send first byte
        ----------------------------------------------------------------------
        DATA_IN <= "10101010";
        TX_START <= '1';
        wait for CLK_PERIOD;
        TX_START <= '0';

        wait for 100 * CLK_PERIOD;

        ----------------------------------------------------------------------
        -- Send second byte
        ----------------------------------------------------------------------
        DATA_IN <= "11001100";
        TX_START <= '1';
        wait for CLK_PERIOD;
        TX_START <= '0';

        wait for 100 * CLK_PERIOD;

        ------------------------------------------------------------------------------
        -- End of simulation
        ------------------------------------------------------------------------------
        WAIT FOR clk_period * 5;
        simulation_finished <= TRUE;
        WAIT;
    end process;

end Behavioral;