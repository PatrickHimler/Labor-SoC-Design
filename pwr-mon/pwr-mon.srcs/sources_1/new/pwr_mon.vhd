----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.02.2021 19:02:32
-- Design Name: 
-- Module Name: pwr_mon - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwr_mon is
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           ev_in: in STD_LOGIC_VECTOR((2*1)-1 downto 0); -- Adjust width here!
           cnt_out : out STD_LOGIC_VECTOR((2*8)-1 downto 0)); -- Adjust width here!
end pwr_mon;

architecture Behavioral of pwr_mon is

begin


end Behavioral;
