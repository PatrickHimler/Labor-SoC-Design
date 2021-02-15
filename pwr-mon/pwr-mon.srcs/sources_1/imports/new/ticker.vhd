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

entity ticker is
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           ctim: out integer);
end ticker;

architecture ticker_beh of ticker is
    signal s_ctim: integer;
begin
    ctim <= s_ctim;
process(clk, nrst)
begin
    if (nrst = '0') then
        s_ctim <= 0;
    elsif (clk'event and clk='1') then
        s_ctim <= s_ctim + 1;
    end if;
end process;

end ticker_beh;
