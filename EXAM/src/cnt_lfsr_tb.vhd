library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cnt_lfsr_tb is
end cnt_lfsr_tb;

architecture Behavioral of cnt_lfsr_tb is

    signal EN        : STD_LOGIC := '0';
    signal CLK       : STD_LOGIC := '0';
    signal RST       : STD_LOGIC := '0';
    signal DOUT      : STD_LOGIC_VECTOR(7 downto 0);
    signal STATE_OUT : STD_LOGIC_VECTOR(18 downto 1);

    constant CLK_PERIOD : time := 10 ns;
    constant INIT_STATE : STD_LOGIC_VECTOR(18 downto 1)
        := "000000000011111111";

    signal sim_finished : boolean := false;

begin

    DUT : entity work.cnt_lfsr
        port map (
            EN        => EN,
            CLK       => CLK,
            RST       => RST,
            DOUT      => DOUT,
            STATE_OUT => STATE_OUT
        );


    CLK_PROCESS : process
    begin
        while not sim_finished loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;

            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;

        wait;
    end process;


    STIMULUS : process

        procedure run_behavior_test is
        begin
            report "Starting behavior test..." severity note;

            RST <= '1';
            EN  <= '0';
            wait for 30 ns;

            RST <= '0';
            wait for 20 ns;

            EN <= '1';
            wait for 200 ns;

            EN <= '0';
            wait for 50 ns;

            EN <= '1';
            wait for 100 ns;

            RST <= '1';
            wait for 20 ns;

            RST <= '0';
            wait for 100 ns;

            report "Behavior test finished." severity note;
        end procedure;


        procedure count_states is
            variable states_count : integer := 0;
        begin
            report "Starting state count..." severity note;
       
            wait until falling_edge(CLK);

            RST <= '1';
            EN  <= '0';
        
            wait until rising_edge(CLK);
            wait for 1 ns;
        
            if STATE_OUT /= INIT_STATE then
                report "ERROR: Reset did not set initial state. STATE_OUT = "
                    & integer'image(to_integer(unsigned(STATE_OUT)))
                    severity failure;
            end if;
        
            wait until falling_edge(CLK);
        
            RST <= '0';
            EN  <= '1';
        
            loop
                wait until rising_edge(CLK);
                wait for 1 ns;
        
                states_count := states_count + 1;
        
                if STATE_OUT = INIT_STATE then
                    exit;
                end if;
            end loop;
        
            report LF & "================================================================" & LF &
                   "LFSR period is: " & integer'image(states_count) & LF &
                   "================================================================" severity note;
        end procedure;

    begin

        run_behavior_test;
        count_states;

        sim_finished <= true;

        report "Simulation finished." severity note;

        wait;

    end process;

end Behavioral;