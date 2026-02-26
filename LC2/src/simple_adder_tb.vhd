library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity simple_adder_tb is
end simple_adder_tb;

architecture Behavioral of simple_adder_tb is

    component simple_adder
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Y : out STD_LOGIC_VECTOR (3 downto 0);
               C : out STD_LOGIC;
               Z : out STD_LOGIC);
    end component;

    SIGNAL a_sig: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL b_sig: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL y_sig: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL y_ref: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL c_sig: STD_LOGIC;
    SIGNAL z_sig: STD_LOGIC;

begin

    -- Unit Under Test (UUT)
    simple_adder_i : simple_adder
    Port map( A => a_sig,
              B => b_sig,
              Y => y_sig,
              C => c_sig,
              Z => z_sig);
              
    -- Stimulus generator
    proc_stim_gen: PROCESS
    BEGIN
        --a_sig <= "0000";
        --a_sig <= 0;
        --a_sig <= STD_LOGIC_VECTOR(TO_UNSIGNED(0,4))
        --a_sig <= STD_LOGIC_VECTOR(TO_UNSIGNED(0,a_sig'length))

        FOR i IN 0 TO (2**a_sig'length - 1) LOOP
            a_sig <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, a_sig'length));
            FOR j IN 0 TO (2**b_sig'length - 1) LOOP
                b_sig <= STD_LOGIC_VECTOR(TO_UNSIGNED(j, b_sig'length));
                WAIT FOR 10 ns;
            END LOOP;
        END LOOP;
        
        WAIT;
        
    END PROCESS;
    
    -- Output verification
    output_verification: PROCESS
        VARIABLE cnt_err: INTEGER := 0;
    BEGIN
        
        WAIT ON a_sig, b_sig;
        WAIT FOR 1ns;
        
        y_ref <= STD_LOGIC_VECTOR(UNSIGNED(a_sig) + UNSIGNED(b_sig));
            
        WAIT FOR 0ns; -- Odlozene prirazeni se provede az kdyz je wait    
            
        IF NOT (y_sig = y_ref) THEN
            REPORT
                "Error! a=" & INTEGER'image(TO_INTEGER(UNSIGNED(a_sig))) &
                " b=" & INTEGER'image(TO_INTEGER(UNSIGNED(b_sig))) &
                " actual y=" & INTEGER'image(TO_INTEGER(UNSIGNED(y_sig))) &
                " expected y=" & INTEGER'image(TO_INTEGER(UNSIGNED(y_ref))) &
                " error no: " & INTEGER'image(cnt_err)
                SEVERITY ERROR;
            cnt_err := cnt_err + 1;
        END IF;

    END PROCESS;
    
end Behavioral;