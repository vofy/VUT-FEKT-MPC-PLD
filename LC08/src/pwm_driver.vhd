library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_driver is
    port (
        CLK       : IN  STD_LOGIC;
        PWM_REF_7 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111111";
        PWM_REF_6 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := "01111111";
        PWM_REF_5 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := "00111111";
        PWM_REF_4 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := "00011111";
        PWM_REF_3 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000111";
        PWM_REF_2 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000011";
        PWM_REF_1 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000001";
        PWM_REF_0 : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
        PWM_OUT   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        CNT_OUT   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end pwm_driver;

architecture Behavioral of pwm_driver is

    signal counter : unsigned(7 downto 0) := (others => '0');

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if (counter < 254) then
                counter <= counter + 1;
            else
                counter <= x"00";
            end if;
        end if;
    end process;

    PWM_OUT(7) <= '1' when counter < unsigned(PWM_REF_7) else '0';
    PWM_OUT(6) <= '1' when counter < unsigned(PWM_REF_6) else '0';
    PWM_OUT(5) <= '1' when counter < unsigned(PWM_REF_5) else '0';
    PWM_OUT(4) <= '1' when counter < unsigned(PWM_REF_4) else '0';
    PWM_OUT(3) <= '1' when counter < unsigned(PWM_REF_3) else '0';
    PWM_OUT(2) <= '1' when counter < unsigned(PWM_REF_2) else '0';
    PWM_OUT(1) <= '1' when counter < unsigned(PWM_REF_1) else '0';
    PWM_OUT(0) <= '1' when counter < unsigned(PWM_REF_0) else '0';
    
    CNT_OUT <= std_logic_vector(counter);

end Behavioral;