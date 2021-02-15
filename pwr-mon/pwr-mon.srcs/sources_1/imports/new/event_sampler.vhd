----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2021 22:01:44
-- Design Name: 
-- Module Name: event_sampler - Behavioral
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



entity event_sampler is
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           ev_in: in STD_LOGIC_VECTOR((2*1)-1 downto 0); -- Adjust width here!
           cnt_out : out STD_LOGIC_VECTOR((2*8)-1 downto 0)); -- Adjust width here!
end event_sampler;

architecture event_sampler_beh of event_sampler is
    signal s_ctim : integer;
    
    component sampler
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           ev : in STD_LOGIC;
           cnt_out : out STD_LOGIC_VECTOR(8 downto 0));
    end component;
    
begin

   GEN_REG: 
   for I in 0 to 1 generate -- Adjust here also!
      sampler_i : sampler port map
        (clk, nrst, ev_in(I), cnt_out(((I+1)*8)-1 downto I*8));
   end generate GEN_REG;

end event_sampler_beh;