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
    Port ( GCLK : in STD_LOGIC;
           nrst: in STD_LOGIC;
           JA1 : out STD_LOGIC;
           ev_in: in STD_LOGIC_VECTOR((2*1)-1 downto 0)); -- Adjust width here!
end pwr_mon;

architecture Behavioral of pwr_mon is

--component event_sampler is
--    Port ( clk : in STD_LOGIC;
--           nrst: in STD_LOGIC;
--           strobe: in STD_LOGIC;
--           ev_in: in STD_LOGIC_VECTOR((2*1)-1 downto 0); -- Adjust width here!
--           cnt_out : out STD_LOGIC_VECTOR((2*32)-1 downto 0)); -- Adjust width here!
--end component;

component UART_TX is
  Port (
    i_Clk       : in  std_logic;
    i_TX_DV     : in  std_logic;
    i_TX_Byte   : in  std_logic_vector(7 downto 0);
    o_TX_Active : out std_logic;
    o_TX_Serial : out std_logic;
    o_TX_Done   : out std_logic
    );
end component;

signal s_nrst : std_logic;
signal s_strobe : std_logic;
signal s_ev_in : STD_LOGIC_VECTOR((2*1)-1 downto 0); -- Adjust width here!
signal s_cnt_out : STD_LOGIC_VECTOR((2*32)-1 downto 0); -- Adjust width here!

signal s_i_tx_dv : std_logic;
signal s_i_tx_byte : std_logic_vector(7 downto 0);
signal s_o_tx_active : std_logic;
signal s_o_tx_serial : std_logic;
signal s_o_tx_done : std_logic;

begin

    uart_tx_i : UART_TX port map
        (i_Clk => GCLK,
         i_TX_DV => s_i_tx_dv,
         i_TX_Byte => s_i_tx_byte,
         o_TX_Active => s_o_tx_active,
         o_TX_Serial => s_o_tx_serial,
         o_TX_Done => s_o_tx_done);
    
    JA1 <= s_o_tx_serial;
         
--    event_sampler_i : event_sampler port map
--    ( clk => GCLK,
--      nrst => s_nrst,
--      strobe => s_strobe,
--      ev_in => s_ev_in,
--      cnt_out => s_cnt_out);
      
   s_i_tx_byte <= X"55";
   s_i_tx_dv <= '1';

end Behavioral;
