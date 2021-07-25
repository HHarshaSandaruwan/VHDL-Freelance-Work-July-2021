library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity USR_4 is
-----------------------INPUTS AND OUTPUTS DECLARATION------------------------
	port ( 	
				CLK : IN STD_LOGIC; --CLOCK INPUT
				RST : IN STD_LOGIC; --ASYNCHRONOUS RESET INPUT
				
				SIR : IN STD_LOGIC; --SERIAL INPUT FOR RIGHT	SHIFT
				SIL : IN STD_LOGIC; --SERIAL INPUT FOR LEFT SHIFT
				D : IN STD_LOGIC_VECTOR (3 DOWNTO 0); --PARALLEL INPUTS FOR PARALLEL LOADING
				S : IN STD_LOGIC_VECTOR (1 DOWNTO 0); --INPUTS FOR SELECTING OPERATION
				
				Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) --DATA OUTPUTS
			);	
end USR_4;

architecture Behavioral of USR_4 is

-----------------------DECLARATION OF TEMPORARY SIGNAL-----------------------
	SIGNAL TEMP: STD_LOGIC_VECTOR (3 DOWNTO 0); 

begin

PROCESS (SIR,SIL,D,S,CLK,RST)
	
	BEGIN

-------------------------INITIALIZATI0N--------------------------------------	
		IF RST='1' THEN 
		TEMP<="0000"; --LOAD 0000 TO TEMPORARY SIGNAL
		Q<="0000"; --LOAD 0000 TO OUTPUT
		
			ELSIF (CLK='1' AND CLK' EVENT) THEN
			
				CASE S IS
--------------------------PARALLEL LOADING-----------------------------------
					WHEN "11" => 
					TEMP<=D; 
					Q<=TEMP; 
					
---------------------------SHIFT LEFT----------------------------------------
					WHEN "01" =>
					TEMP<=D; 
					TEMP(3 DOWNTO 1) <= TEMP(2 DOWNTO 0); 
					TEMP(0) <= SIL;
					Q<=TEMP; 
					
---------------------------SHIFT RIGHT---------------------------------------
					WHEN "10" =>
					TEMP<=D; 
					TEMP(2 DOWNTO 0) <= TEMP(3 DOWNTO 1); 
					TEMP(3) <= SIR; 
					Q<=TEMP; 
					
---------------------------HOLD----------------------------------------------
					WHEN OTHERS => NULL; 
				
				END CASE;
		
		END IF;
	
END PROCESS;

end Behavioral;