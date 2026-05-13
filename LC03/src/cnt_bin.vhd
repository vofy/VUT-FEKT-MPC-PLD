library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cnt_bin is
    PORT(
        SRST: in STD_LOGIC;
        CE: in STD_LOGIC;
        CNT_LOAD: in STD_LOGIC;
        CNT_UP: in STD_LOGIC;
        CLK: in STD_LOGIC;
        CNT: out STD_LOGIC_VECTOR(31 DOWNTO 0));
end cnt_bin;

architecture Behavioral of cnt_bin is

    SIGNAL CNT_REG : UNSIGNED(31 DOWNTO 0) := (OTHERS => '0');

begin

    PROCESS (CLK) BEGIN
     IF rising_edge(CLK) THEN
        IF SRST = '1' THEN -- synchronous reset
            CNT_REG <= (OTHERS => '0');
        ELSE -- normal operation
            IF CE = '1' THEN
                IF CNT_LOAD = '1' THEN
                    CNT_REG <= x"55555555";
                ELSE
                    IF CNT_UP = '1' THEN
                        CNT_REG <= CNT_REG + 1; -- increment counter
                    ELSE
                        CNT_REG <= CNT_REG - 1; -- decrement counter
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
    END PROCESS;
    
    CNT <= STD_LOGIC_VECTOR(CNT_REG);

end Behavioral;
