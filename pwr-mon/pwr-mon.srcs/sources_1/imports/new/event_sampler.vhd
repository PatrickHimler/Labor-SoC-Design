----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Lukas Vogl
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

entity event_sampler is
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           strobe: in STD_LOGIC;
           ev_in: in STD_LOGIC_VECTOR((5*1)-1 downto 0); -- Adjust width here!
           cnt_out : out STD_LOGIC_VECTOR((5*32)-1 downto 0)); -- Adjust width here!
end event_sampler;

architecture event_sampler_beh of event_sampler is
    signal s_cnt_out : std_logic_vector((5*32)-1 downto 0); -- Adjust width here!
    signal s_nrst : std_logic;
        
    component sampler
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           ev : in STD_LOGIC;
           cnt_out : out STD_LOGIC_VECTOR(31 downto 0));
    end component;
    
begin

    a: process (clk)
    begin
        if (clk'event and clk = '1') then    
            if (nrst = '0') then
               cnt_out <= (others => '0');
               s_nrst <= '0';
            elsif (strobe = '1') then
                cnt_out <= s_cnt_out; -- buffer s_cnt_out
                s_nrst <= '0'; -- reset counters
            else
                s_nrst <= '1';
                -- No cnt_out here! -> buffered
            end if;
        end if;
    end process;

   GEN_REG: 
   for I in 0 to 4 generate -- Adjust here also!
      sampler_i : sampler port map
        (clk, s_nrst, ev_in(I), s_cnt_out(((I+1)*32)-1 downto I*32));
   end generate GEN_REG;

end event_sampler_beh;