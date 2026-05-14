library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cnt_lfsr is
    Port ( EN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (7 DOWNTO 0);
           STATE_OUT: out STD_LOGIC_VECTOR (18 DOWNTO 1));
end cnt_lfsr;

architecture Behavioral of cnt_lfsr is

    CONSTANT Tap_1  : INTEGER                           := 18;
    CONSTANT Tap_2  : INTEGER                           := 10;
    SIGNAL ShReg    : STD_LOGIC_VECTOR(Tap_1 DOWNTO 1)  := "000000000011111111";
    SIGNAL Feedback : STD_LOGIC;

begin

    PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) THEN
        
            IF RST = '1' THEN
                ShReg <= "000000000011111111";
            ELSIF EN = '1' THEN
                ShReg <= ShReg(ShReg'HIGH-1 DOWNTO 1) & Feedback;
            END IF;
            
        END IF;
    END PROCESS;
    
    Feedback    <= ShReg(Tap_1) XOR ShReg(Tap_2);
    
    DOUT        <= ShReg(5) & ShReg(12) & ShReg(10) & ShReg(11) & ShReg(4) & ShReg(6) & ShReg(8) & ShReg(7);
    STATE_OUT   <= ShReg;

end Behavioral;
