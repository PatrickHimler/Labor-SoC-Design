----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2021 00:06:21
-- Design Name: 
-- Module Name: ticker - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bram is
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           addr_in: in std_logic_vector(7 downto 0);
           data_in: in std_logic_vector(7 downto 0);
           addr_out: in std_logic_vector(7 downto 0);
           data_out: out std_logic_vector(7 downto 0));
end bram;

architecture Behavioral of bram is

begin


end Behavioral;
