----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2021 20:45:26
-- Design Name: 
-- Module Name: serializer_tb - Behavioral
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

entity serializer_tb is
--  Port ( );
end serializer_tb;

architecture Behavioral of serializer_tb is

component serializer is
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           tick : in STD_LOGIC;
           timestamp : in std_logic_vector(31 downto 0 );
           din : in STD_LOGIC_VECTOR((5*32)-1 downto 0); -- Adjust width here!
           tx_done : in std_logic;
           en_tx : out std_logic;
           dout : out std_logic_vector(7 downto 0)); -- uart tx
end component;

signal s_clk : std_logic;
signal s_nrst : std_logic;
signal s_tick : std_logic;
signal s_timestamp: std_logic_vector(31 downto 0);
signal s_din : STD_LOGIC_VECTOR((5*32)-1 downto 0); -- Adjust width here!
signal s_tx_done : std_logic;
signal s_en_tx :std_logic;
signal s_dout: std_logic_vector(7 downto 0);

begin

    s_nrst <= '0', '1' after 1 ns;

    dut: serializer port map(s_clk, s_nrst, s_tick, s_timestamp, s_din, s_tx_done, s_en_tx, s_dout);

clk_gen: process
begin
    s_clk <= '0';
    wait for 500 ps;
    s_clk <= '1';
    wait for 500 ps;
end process;

tx_active_gen: process
begin
    s_tx_done <= '0';
    wait for 9 ns;
    s_tx_done <= '1';
    wait for 1 ns;
end process;

a: process
begin
    s_tick <= '0';
    s_timestamp <= (others => '0');
    s_din <= (others => '0');
    
    wait for 1 ns;
    
    s_tick <= '1';
    s_timestamp <= X"00010001";
    s_din(31 downto 0) <= X"AAAA5555";
    
    wait for 1 ns;
    s_tick <= '0';
    
    wait;
    
end process;

end Behavioral;
