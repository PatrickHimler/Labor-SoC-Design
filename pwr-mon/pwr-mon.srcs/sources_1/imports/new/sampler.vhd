----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2021 00:07:31
-- Design Name: 
-- Module Name: sampler - Behavioral
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

entity sampler is
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           ev : in STD_LOGIC;
           cnt_out : out STD_LOGIC_VECTOR(7 downto 0));
end sampler;

architecture sampler_beh of sampler is
begin

sampler: process(clk)
    variable v_cnt_out : integer := 0;
begin
    if (clk'event and clk='1') then
        if (nrst = '0') then
            v_cnt_out := 0;  
        elsif (ev = '1') then
            -- count event
            v_cnt_out := v_cnt_out + 1;
        end if;
        cnt_out <= std_logic_vector(to_unsigned(v_cnt_out, cnt_out'length));
    end if;
end process;

end sampler_beh;
