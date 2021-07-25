LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY USR_4_TB IS
END USR_4_TB;
 
ARCHITECTURE behavior OF USR_4_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT USR_4
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         SIR : IN  std_logic;
         SIL : IN  std_logic;
         D : IN  std_logic_vector(3 downto 0);
         S : IN  std_logic_vector(1 downto 0);
         Q : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal SIR : std_logic := '0';
   signal SIL : std_logic := '0';
   signal D : std_logic_vector(3 downto 0) := (others => '0');
   signal S : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: USR_4 PORT MAP (
          CLK => CLK,
          RST => RST,
          SIR => SIR,
          SIL => SIL,
          D => D,
          S => S,
          Q => Q
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   PROCESS
		BEGIN		
--------------------------INITIALIZE TEST--------------------------------------
				RST<='1'; 
				WAIT FOR  100 NS;-- HOLD AT INITIAL STATE FOR 40 NS.

--------------------------TEST PARALLEL LOADING--------------------------------
				RST<='0';
				S<="11";
				D<="1111";
				WAIT FOR 100 NS;
			  
--------------------------TESTING SHIFT RIGHT----------------------------------
				S<="10";
				SIR<= '0';
				WAIT FOR 100 NS;

--------------------------TESTING HOLD-----------------------------------------
				S<="00";
				WAIT FOR 100 NS;			

--------------------------TESTING SHIFT LEFT-----------------------------------			  
				S<="01";
				SIL<= '1';
				WAIT FOR 100 NS;
			
--------------------------TESTING RESET----------------------------------------
				RST<='1'; 
				WAIT FOR  100 NS;-- HOLD AT INITIAL STATE FOR 100 NS.
  
  END PROCESS;

END;
