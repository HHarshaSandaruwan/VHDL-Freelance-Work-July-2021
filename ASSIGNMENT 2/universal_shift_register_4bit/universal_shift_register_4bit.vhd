--------------------------------------------------------------------
-- Engineer: 		 S. A. C. Dilhani Maddumage
-- Create Date:    02:06:34 07/05/2021 
-- Design Name: 	 4 Bit Universal Shift Register
-- Module Name:    universal_shift_register_4bit - Behavioral 
-- Project Name: 	 Advanced Digital Design Assignment 01
---------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity universal_shift_register_4bit is
			port ( 	sir : in std_logic; --serial input right    
						sil : in std_logic; --serial input left 
						clk : in std_logic; --clock input
						rst : in std_logic; --reset input
						d : in std_logic_vector (3 downto 0); --parallel data inputs
						s : in std_logic_vector (1 downto 0); --selecting inputs
						q : out std_logic_vector (3 downto 0)   );  --data outputs
end universal_shift_register_4bit;

architecture Behavioral of universal_shift_register_4bit is
signal t: std_logic_vector (3 downto 0); 

begin
process (sir,sil,d,s,clk,rst)
    begin
        if rst='0' then 
        t<="0000"; --set temp to 0000
        q<="0000"; --set data output to 0000
        
        elsif (clk='1' and clk' event) then
        
            case s is

                when "01" => --shift left
                t<=d; --load parallel inputs to the temp
                t(3 downto 1) <= t(2 downto 0); --load temp(0) temp(1) temp(2) in to temp(1) temp(2) temp(3) respectively
                t(0) <= sil; --load serial input right into the temp(0)
                q<=t; --load temp in to data output
					 
                when "11" => --parallel loading
                t<=d; --load parallel inputs to the temp
                q<=t; --load temp to data output 
										
                when "10" => --shift right
                t<=d; --load parallel inputs to the temp
                t(2 downto 0) <= t(3 downto 1); --load temp(1) temp(2) temp(3) in to temp(0) temp(1) temp(2) respectively
                t(3) <= sir; --load serial input left into the temp(3)
                q<=t; --load temp in to data output
                					
                when others => null; --hold
            
            end case;
        
        end if;
    
end process;

end Behavioral;

