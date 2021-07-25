--------------------------------------------------------------------
-- Engineer: 		S. A. C. Dilhani Maddumage
-- Create Date:   02:34:58 07/05/2021
-- Design Name:   4 Bit Universal Shift Register
-- Module Name:   C:/ADD Assignment 01/universal_shift_register_4bit/universal_shift_register_4bit_test_bench.vhd
-- Project Name:  universal_shift_register_4bit
-- VHDL Test Bench Created by ISE for module: universal_shift_register_4bit
--------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY universal_shift_register_4bit_test_bench IS
END universal_shift_register_4bit_test_bench;
 
ARCHITECTURE behavior OF universal_shift_register_4bit_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT universal_shift_register_4bit
    PORT(
         sir : IN  std_logic;
         sil : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         d : IN  std_logic_vector(3 downto 0);
         s : IN  std_logic_vector(1 downto 0);
         q : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sir : std_logic := '0';
   signal sil : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal d : std_logic_vector(3 downto 0) := (others => '0');
   signal s : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal q : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: universal_shift_register_4bit PORT MAP (
          sir => sir,
          sil => sil,
          clk => clk,
          rst => rst,
          d => d,
          s => s,
          q => q
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
  begin        
    
        --reset 
        rst<='0'; 
        wait for 100 ns;-- hold at same state for 100 ns.
        
			--hold
        rst<='1';
        wait for 100 ns;
        d<="1101";
        s<="00";
      wait for 100 ns;-- hold selection at same state for 100 ns.
        
        --parallel loading
        s<="11";
      wait for 100 ns;-- hold selection at same state for 100 ns.

        --shift right
        s<="10";
        sir<= '1';
      wait for 100 ns;-- hold selection at same state for 100 ns.
        
        --shift left
        s<="01";
        sil<= '0';
      wait for 100 ns;-- hold selection at same state for 100 ns.
        
      wait;
   end process;

END;
