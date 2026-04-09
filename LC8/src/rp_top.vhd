library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rp_top is
    port (
        CLK             : IN  STD_LOGIC;
        SW              : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        BTN             : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        LED             : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        DISP_SEG        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        DISP_DIG        : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
end rp_top;

architecture Behavioral of rp_top is

COMPONENT seg_disp_driver
    PORT(
        CLK             : IN  STD_LOGIC;
        DIG_1           : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        DIG_2           : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        DIG_3           : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        DIG_4           : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        DP              : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);        -- [DP4 DP3 DP2 DP1]
        DOTS            : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);        -- [L3 L2 L1]
        DISP_SEG        : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        DISP_DIG        : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END COMPONENT seg_disp_driver;

component pwm_driver
    port (
        CLK       : IN  STD_LOGIC;
        PWM_REF_7 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        PWM_REF_6 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        PWM_REF_5 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        PWM_REF_4 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        PWM_REF_3 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        PWM_REF_2 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        PWM_REF_1 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        PWM_REF_0 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        PWM_OUT   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        CNT_OUT   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end component;

COMPONENT vio_pwm
  PORT (
    clk        : IN STD_LOGIC;
    probe_in0  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_in1  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out5 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out6 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out7 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT vio_disp
PORT (
    clk : IN STD_LOGIC;
    probe_out0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    probe_out2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    probe_out3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
);
END COMPONENT;

COMPONENT ila_pwm
PORT (
	clk : IN STD_LOGIC;
	probe0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	probe1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT  ;

COMPONENT ila_sw_btn
PORT (
	clk : IN STD_LOGIC;
	probe0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	probe1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END COMPONENT  ;

signal PWM_OUT   : STD_LOGIC_VECTOR(7 downto 0);
signal CNT_OUT   : STD_LOGIC_VECTOR(7 downto 0);
signal PWM_REF_0 : STD_LOGIC_VECTOR(7 downto 0);
signal PWM_REF_1 : STD_LOGIC_VECTOR(7 downto 0);
signal PWM_REF_2 : STD_LOGIC_VECTOR(7 downto 0);
signal PWM_REF_3 : STD_LOGIC_VECTOR(7 downto 0);
signal PWM_REF_4 : STD_LOGIC_VECTOR(7 downto 0);
signal PWM_REF_5 : STD_LOGIC_VECTOR(7 downto 0);
signal PWM_REF_6 : STD_LOGIC_VECTOR(7 downto 0);
signal PWM_REF_7 : STD_LOGIC_VECTOR(7 downto 0);

signal DIG_1 : STD_LOGIC_VECTOR(3 downto 0);
signal DIG_2 : STD_LOGIC_VECTOR(3 downto 0);
signal DIG_3 : STD_LOGIC_VECTOR(3 downto 0);
signal DIG_4 : STD_LOGIC_VECTOR(3 downto 0);

begin

seg_disp_driver_i : seg_disp_driver
PORT MAP(
    CLK                 => CLK,
    DIG_1               => DIG_1,
    DIG_2               => DIG_2,
    DIG_3               => DIG_3,
    DIG_4               => DIG_4,
    DP                  => "0000",
    DOTS                => "011",
    DISP_SEG            => DISP_SEG,
    DISP_DIG            => DISP_DIG
);

pwm_driver_i : pwm_driver
port map (
    CLK       => CLK,
    PWM_REF_7 => PWM_REF_7,
    PWM_REF_6 => PWM_REF_6,
    PWM_REF_5 => PWM_REF_5,
    PWM_REF_4 => PWM_REF_4,
    PWM_REF_3 => PWM_REF_3,
    PWM_REF_2 => PWM_REF_2,
    PWM_REF_1 => PWM_REF_1,
    PWM_REF_0 => PWM_REF_0,
    PWM_OUT   => PWM_OUT,
    CNT_OUT   => CNT_OUT
);

vio_pwm_i : vio_pwm
  PORT MAP (
    clk => clk,
    probe_in0 => PWM_OUT,
    probe_in1 => CNT_OUT,
    probe_out0 => PWM_REF_0,
    probe_out1 => PWM_REF_1,
    probe_out2 => PWM_REF_2,
    probe_out3 => PWM_REF_3,
    probe_out4 => PWM_REF_4,
    probe_out5 => PWM_REF_5,
    probe_out6 => PWM_REF_6,
    probe_out7 => PWM_REF_7
  );
  
vio_disp_i : vio_disp
PORT MAP (
    clk => clk,
    probe_out0 => DIG_1,
    probe_out1 => DIG_2,
    probe_out2 => DIG_3,
    probe_out3 => DIG_4
);

ila_pwm_i : ila_pwm
PORT MAP (
	clk => clk,
	probe0 => PWM_OUT,
	probe1 => CNT_OUT
);

ila_sw_btn_i : ila_sw_btn
PORT MAP (
	clk => clk,
	probe0 => SW,
	probe1 => BTN
);
  
LED <= PWM_OUT;

end Behavioral;
