----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2021 23:13:23
-- Design Name: 
-- Module Name: event_sampler_tb - Behavioral
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

entity event_sampler_tb is
--  Port ( );
end event_sampler_tb;

architecture Behavioral of event_sampler_tb is
    signal s_clk: STD_LOGIC;
    signal s_nrst: STD_LOGIC;
    signal s_ev_in: std_logic_vector(1 downto 0);
    signal s_ev_out: std_logic_vector(15 downto 0);
    
    component event_sampler
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           ev_in: in STD_LOGIC_VECTOR((2*1)-1 downto 0); -- Adjust width here!
           ev_out : out STD_LOGIC_VECTOR((2*8)-1 downto 0)); -- Adjust width here!
    end component;
begin

    s_nrst <= '0', '1' after 1 ps;

    dut: event_sampler port map(s_clk, s_nrst, s_ev_in, s_ev_out);

clk_gen: process
begin
    s_clk <= '0';
    wait for 500 ps;
    s_clk <= '1';
    wait for 500 ps;
end process;

a: process
begin
    s_ev_in(0) <= '0';
    s_ev_in(1) <= '0';
    --assert s_ev_out = (others => '0');
    wait for 5 ns;
    
    s_ev_in(0) <= '1';
    s_ev_in(1) <= '0';
    -- assert s_ev_out = (others => '0');
    wait for 5 ns;
    
    wait;
    
end process;


end Behavioral;
