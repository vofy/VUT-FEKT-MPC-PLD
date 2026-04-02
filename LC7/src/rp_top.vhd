library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rp_top is
    port (
        CLK       : IN  STD_LOGIC;
        LED       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end rp_top;

architecture Behavioral of rp_top is

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

begin

pwm_driver_i : pwm_driver
port map (
    CLK       => CLK,
    PWM_REF_7 => "11111111",
    PWM_REF_6 => "01111111",
    PWM_REF_5 => "00111111",
    PWM_REF_4 => "00011111",
    PWM_REF_3 => "00000111",
    PWM_REF_2 => "00000011",
    PWM_REF_1 => "00000001",
    PWM_REF_0 => "00000000",
    PWM_OUT   => LED,
    CNT_OUT   => open
);

end Behavioral;
