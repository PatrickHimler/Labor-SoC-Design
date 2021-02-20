----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Lukas Vogl
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
use ieee.numeric_std.all;

entity pwr_mon is
  generic (
    g_CLKS_PER_FLUSH : integer := 100*10**6 -- Time between flushes = g_CLKS_PER_FLUSH / 100MHz
--    g_CLKS_PER_FLUSH : integer := 500 -- SIMULATION ONLY!!
    );
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           serial_tx : out STD_LOGIC;
           ev_in: in STD_LOGIC_VECTOR((5*1)-1 downto 0)); -- Adjust width here!
end pwr_mon;

architecture Behavioral of pwr_mon is

component event_sampler is
    Port ( clk : in STD_LOGIC;
           nrst: in STD_LOGIC;
           strobe: in STD_LOGIC;
           ev_in: in STD_LOGIC_VECTOR((5*1)-1 downto 0); -- Adjust width here!
           cnt_out : out STD_LOGIC_VECTOR((5*32)-1 downto 0)); -- Adjust width here!
end component;

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

signal s_i_tx_dv : std_logic;
signal s_i_tx_byte : std_logic_vector(7 downto 0);
signal s_o_tx_active : std_logic;
signal s_o_tx_serial : std_logic;
signal s_o_tx_done : std_logic;

signal s_strobe : std_logic;
signal s_ev_in : STD_LOGIC_VECTOR((5*1)-1 downto 0); -- Adjust width here!
signal s_cnt_out : STD_LOGIC_VECTOR((5*32)-1 downto 0); -- Adjust width here!

signal s_tick : std_logic;
signal s_timestamp: std_logic_vector(31 downto 0);
signal s_din : STD_LOGIC_VECTOR((5*32)-1 downto 0); -- Adjust width here!
signal s_tx_done : std_logic;
signal s_en_tx :std_logic;
signal s_dout: std_logic_vector(7 downto 0);

signal s_time: integer;

begin         
    event_sampler_i : event_sampler port map
    ( clk => clk,
      nrst => nrst,
      strobe => s_strobe,
      ev_in => s_ev_in,
      cnt_out => s_cnt_out);
      
    serializer_i : serializer port map
    ( clk => clk,
      nrst => nrst,
      tick => s_tick,
      timestamp => s_timestamp,
      din => s_din,
      tx_done => s_tx_done,
      en_tx => s_en_tx,
      dout => s_dout);

    uart_tx_i : uart_tx port map
    ( i_Clk => clk,
      i_TX_DV => s_i_tx_dv,
      i_TX_Byte => s_i_tx_byte,
      o_TX_Active => s_o_tx_active,
      o_TX_Serial => s_o_tx_serial,
      o_TX_Done => s_o_tx_done);

    s_din <= s_cnt_out;
    s_tx_done <= s_o_tx_done;
    s_i_tx_byte <= s_dout;
    s_i_tx_dv <= s_en_tx;
    serial_tx <= s_o_tx_serial;

    timestamp_gen : process(clk)
        variable v_time : integer;
    begin
        if (clk'event and clk = '1') then
            s_tick <= '0';
            s_strobe <= '0';
            if (nrst = '0') then
                s_ev_in <= (others => '0'); -- Init value for ev_in
                v_time := 0;
            else
                s_ev_in <= ev_in;
                v_time := v_time + 1;
            end if;
           
            if ((v_time mod g_CLKS_PER_FLUSH) = 0) then
                s_strobe <= '1';
                s_tick <= '1';
            end if;
            
            s_time <= v_time;
        end if;
    end process;
    
    timestamp_reg : process(clk)
        -- needed because timestamp shall not change during transmission
    begin
        if (clk'event and clk = '1') then 
            if (nrst = '0') then
                s_timestamp <= (others => '0');
            elsif (s_tx_done = '1') then
                s_timestamp <= std_logic_vector(to_unsigned(s_time, 32));
            end if;
        end if;
    end process;


end Behavioral;
