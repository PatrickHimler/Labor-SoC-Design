----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2021 21:33:46
-- Design Name: 
-- Module Name: pwr_mon_tb - Behavioral
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

entity pwr_mon_tb is
--  Port ( );
end pwr_mon_tb;

architecture Behavioral of pwr_mon_tb is

component pwr_mon is
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           serial_tx : out STD_LOGIC;
           ev_in: in STD_LOGIC_VECTOR((5*1)-1 downto 0)); -- Adjust width here!
end component;

signal s_clk : std_logic;
signal s_nrst :std_logic;
signal s_serial_tx : std_logic;
signal s_ev_in : STD_LOGIC_VECTOR((5*1)-1 downto 0); -- Adjust width here!

begin

    s_nrst <= '0', '1' after 1 ns;

    dut: pwr_mon port map(s_clk, s_nrst, s_serial_tx, s_ev_in);

    clk_gen: process
    begin
        s_clk <= '0';
        wait for 500 ps;
        s_clk <= '1';
        wait for 500 ps;
    end process;
    
    a: process
    begin
        s_ev_in <= (others => '0');
        
        wait for 1 ns;

        s_ev_in(0) <= '1';
        
        wait for 1 ns;    
            
        s_ev_in(0) <= '0';        
        
        wait;
        
    end process;

end Behavioral;
