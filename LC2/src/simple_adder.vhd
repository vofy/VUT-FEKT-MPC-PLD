library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity simple_adder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0);
           C : out STD_LOGIC;
           Z : out STD_LOGIC);
end simple_adder;

architecture Behavioral of simple_adder is

    SIGNAL a_sig: UNSIGNED(A'range);
    SIGNAL b_sig: UNSIGNED(B'range);
    SIGNAL y_sig: UNSIGNED(Y'range);
    SIGNAL sum : UNSIGNED(4 downto 0);

begin

    a_sig <= UNSIGNED(A);
    b_sig <= UNSIGNED(B);

    sum <= RESIZE(a_sig, 5) + RESIZE(b_sig, 5); 
    
    Y <= STD_LOGIC_VECTOR(sum(3 downto 0));
    C <= sum(4);
    Z <= '1' WHEN sum = X"0" ELSE '0';

end Behavioral;
