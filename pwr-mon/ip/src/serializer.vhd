----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Lukas Vogl
-- 
-- Create Date: 30.01.2021 00:06:21
-- Design Name: 
-- Module Name: serializer - Behavioral
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

entity serializer is
  generic (
    g_num_of_dat : integer := 5     -- Adjust width here!
    );
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           tick : in STD_LOGIC;
           timestamp : in std_logic_vector(31 downto 0);
           din : in STD_LOGIC_VECTOR((5*32)-1 downto 0); -- Adjust width here!
           tx_done : in std_logic;
           en_tx : out std_logic;
           dout : out std_logic_vector(7 downto 0)); -- uart tx
end serializer;

architecture Behavioral of serializer is

    type state_t is (st_idle, 
                     st_ts_b0,   st_ts_b1,   st_ts_b2,   st_ts_b3,   st_ts_b4,   st_ts_b5,   st_ts_b6,   st_ts_b7,   st_c0, 
                     st_val0_b0, st_val0_b1, st_val0_b2, st_val0_b3, st_val0_b4, st_val0_b5, st_val0_b6, st_val0_b7, st_c1,
                     st_val1_b0, st_val1_b1, st_val1_b2, st_val1_b3, st_val1_b4, st_val1_b5, st_val1_b6, st_val1_b7, st_c2,
                     st_val2_b0, st_val2_b1, st_val2_b2, st_val2_b3, st_val2_b4, st_val2_b5, st_val2_b6, st_val2_b7, st_c3,
                     st_val3_b0, st_val3_b1, st_val3_b2, st_val3_b3, st_val3_b4, st_val3_b5, st_val3_b6, st_val3_b7, st_c4,
                     st_val4_b0, st_val4_b1, st_val4_b2, st_val4_b3, st_val4_b4, st_val4_b5, st_val4_b6, st_val4_b7, st_nl);

    signal cur_st : state_t;
    signal nxt_st : state_t;
    
    function f_HEX_2_ASCII ( i_hex : std_logic_vector(3 downto 0)) 
        return std_logic_vector is
            variable v_tmp      : integer := 0;
            variable v_result   : std_logic_vector (7 downto 0) := "00000000";
    begin
        v_tmp := to_integer(unsigned(i_hex(3 downto 0)));
        if ( v_tmp < 10) then
            v_result := std_logic_vector(to_unsigned(48 + v_tmp, 8));
        else
            v_result := std_logic_vector(to_unsigned(65 + (v_tmp-10), 8));
        end if;

        return v_result;
    end function;

begin

    seq : process(clk)
    
    begin
        if (clk'event and clk = '1') then
            if (nrst = '0') then
                cur_st <= st_idle;
            
            elsif (tick = '1') then
                if (cur_st = st_idle) then
                    nxt_st <= st_ts_b7;        
                end if;            
    
            elsif (tx_done = '1') then
                case cur_st is
                    when st_ts_b7   => nxt_st <= st_ts_b6;
                    when st_ts_b6   => nxt_st <= st_ts_b5;
                    when st_ts_b5   => nxt_st <= st_ts_b4;
                    when st_ts_b4   => nxt_st <= st_ts_b3;
                    when st_ts_b3   => nxt_st <= st_ts_b2;
                    when st_ts_b2   => nxt_st <= st_ts_b1;
                    when st_ts_b1   => nxt_st <= st_ts_b0;
                    when st_ts_b0   => nxt_st <= st_c0;
                    when st_c0      => nxt_st <= st_val0_b7;
                    when st_val0_b7 => nxt_st <= st_val0_b6;
                    when st_val0_b6 => nxt_st <= st_val0_b5;
                    when st_val0_b5 => nxt_st <= st_val0_b4;
                    when st_val0_b4 => nxt_st <= st_val0_b3;
                    when st_val0_b3 => nxt_st <= st_val0_b2;
                    when st_val0_b2 => nxt_st <= st_val0_b1;
                    when st_val0_b1 => nxt_st <= st_val0_b0;
                    when st_val0_b0 => nxt_st <= st_c1;
                    when st_c1      => nxt_st <= st_val1_b7;
                    when st_val1_b7 => nxt_st <= st_val1_b6;
                    when st_val1_b6 => nxt_st <= st_val1_b5;
                    when st_val1_b5 => nxt_st <= st_val1_b4;
                    when st_val1_b4 => nxt_st <= st_val1_b3;
                    when st_val1_b3 => nxt_st <= st_val1_b2;
                    when st_val1_b2 => nxt_st <= st_val1_b1;
                    when st_val1_b1 => nxt_st <= st_val1_b0;       
                    when st_val1_b0 => nxt_st <= st_c2;   
                    when st_c2      => nxt_st <= st_val2_b7;  
                    when st_val2_b7 => nxt_st <= st_val2_b6;
                    when st_val2_b6 => nxt_st <= st_val2_b5;
                    when st_val2_b5 => nxt_st <= st_val2_b4;
                    when st_val2_b4 => nxt_st <= st_val2_b3;
                    when st_val2_b3 => nxt_st <= st_val2_b2;
                    when st_val2_b2 => nxt_st <= st_val2_b1;
                    when st_val2_b1 => nxt_st <= st_val2_b0;
                    when st_val2_b0 => nxt_st <= st_c3;
                    when st_c3      => nxt_st <= st_val3_b7;
                    when st_val3_b7 => nxt_st <= st_val3_b6;
                    when st_val3_b6 => nxt_st <= st_val3_b5;
                    when st_val3_b5 => nxt_st <= st_val3_b4;
                    when st_val3_b4 => nxt_st <= st_val3_b3;
                    when st_val3_b3 => nxt_st <= st_val3_b2;
                    when st_val3_b2 => nxt_st <= st_val3_b1;
                    when st_val3_b1 => nxt_st <= st_val3_b0;
                    when st_val3_b0 => nxt_st <= st_c4;
                    when st_c4      => nxt_st <= st_val4_b7;
                    when st_val4_b7 => nxt_st <= st_val4_b6;
                    when st_val4_b6 => nxt_st <= st_val4_b5;
                    when st_val4_b5 => nxt_st <= st_val4_b4;
                    when st_val4_b4 => nxt_st <= st_val4_b3;
                    when st_val4_b3 => nxt_st <= st_val4_b2;
                    when st_val4_b2 => nxt_st <= st_val4_b1;
                    when st_val4_b1 => nxt_st <= st_val4_b0;
                    when st_val4_b0 => nxt_st <= st_nl;
                    when st_nl      => nxt_st <= st_idle;                            
                    when others     => nxt_st <= cur_st; -- Do nothing
                end case;
    
            end if;
            
            cur_st <= nxt_st;
        
        end if;
    
    end process;


    -- en_tx, dout
    comb : process(cur_st, nrst, timestamp)
    begin
    
        if (nrst = '0') then
            en_tx <= '0';
            dout <= (others => '0');
        else
            en_tx <= '1'; -- default value
            case cur_st is
                when st_ts_b0   => dout <= f_HEX_2_ASCII(timestamp( 3 downto  0));
                when st_ts_b1   => dout <= f_HEX_2_ASCII(timestamp( 7 downto  4));
                when st_ts_b2   => dout <= f_HEX_2_ASCII(timestamp(11 downto  8));
                when st_ts_b3   => dout <= f_HEX_2_ASCII(timestamp(15 downto 12));
                when st_ts_b4   => dout <= f_HEX_2_ASCII(timestamp(19 downto 16));
                when st_ts_b5   => dout <= f_HEX_2_ASCII(timestamp(23 downto 20));
                when st_ts_b6   => dout <= f_HEX_2_ASCII(timestamp(27 downto 24));
                when st_ts_b7   => dout <= f_HEX_2_ASCII(timestamp(31 downto 28));                
                when st_c0      => dout <= X"2C"; -- 0x2c = ','
                when st_val0_b0 => dout <= f_HEX_2_ASCII(din(0*32+( 3) downto 0*32+( 0)));
                when st_val0_b1 => dout <= f_HEX_2_ASCII(din(0*32+( 7) downto 0*32+( 4)));
                when st_val0_b2 => dout <= f_HEX_2_ASCII(din(0*32+(11) downto 0*32+( 8)));
                when st_val0_b3 => dout <= f_HEX_2_ASCII(din(0*32+(15) downto 0*32+(12)));
                when st_val0_b4 => dout <= f_HEX_2_ASCII(din(0*32+(19) downto 0*32+(16)));
                when st_val0_b5 => dout <= f_HEX_2_ASCII(din(0*32+(23) downto 0*32+(20)));
                when st_val0_b6 => dout <= f_HEX_2_ASCII(din(0*32+(27) downto 0*32+(24)));
                when st_val0_b7 => dout <= f_HEX_2_ASCII(din(0*32+(31) downto 0*32+(28)));
                when st_c1      => dout <= X"2C"; -- 0x2c = ','
                when st_val1_b0 => dout <= f_HEX_2_ASCII(din(1*32+( 3) downto 1*32+( 0)));
                when st_val1_b1 => dout <= f_HEX_2_ASCII(din(1*32+( 7) downto 1*32+( 4)));
                when st_val1_b2 => dout <= f_HEX_2_ASCII(din(1*32+(11) downto 1*32+( 8)));     
                when st_val1_b3 => dout <= f_HEX_2_ASCII(din(1*32+(15) downto 1*32+(12)));
                when st_val1_b4 => dout <= f_HEX_2_ASCII(din(1*32+(19) downto 1*32+(16)));
                when st_val1_b5 => dout <= f_HEX_2_ASCII(din(1*32+(23) downto 1*32+(20)));
                when st_val1_b6 => dout <= f_HEX_2_ASCII(din(1*32+(27) downto 1*32+(24)));
                when st_val1_b7 => dout <= f_HEX_2_ASCII(din(1*32+(31) downto 1*32+(28)));
                when st_c2      => dout <= X"2C"; -- 0x2c = ','
                when st_val2_b0 => dout <= f_HEX_2_ASCII(din(2*32+( 3) downto 2*32+( 0)));
                when st_val2_b1 => dout <= f_HEX_2_ASCII(din(2*32+( 7) downto 2*32+( 4)));
                when st_val2_b2 => dout <= f_HEX_2_ASCII(din(2*32+(11) downto 2*32+( 8)));
                when st_val2_b3 => dout <= f_HEX_2_ASCII(din(2*32+(15) downto 2*32+(12)));
                when st_val2_b4 => dout <= f_HEX_2_ASCII(din(2*32+(19) downto 2*32+(16)));
                when st_val2_b5 => dout <= f_HEX_2_ASCII(din(2*32+(23) downto 2*32+(20)));
                when st_val2_b6 => dout <= f_HEX_2_ASCII(din(2*32+(27) downto 2*32+(24)));
                when st_val2_b7 => dout <= f_HEX_2_ASCII(din(2*32+(31) downto 2*32+(28)));
                when st_c3      => dout <= X"2C"; -- 0x2c = ','
                when st_val3_b0 => dout <= f_HEX_2_ASCII(din(3*32+( 3) downto 3*32+( 0)));
                when st_val3_b1 => dout <= f_HEX_2_ASCII(din(3*32+( 7) downto 3*32+( 4)));
                when st_val3_b2 => dout <= f_HEX_2_ASCII(din(3*32+(11) downto 3*32+( 8)));
                when st_val3_b3 => dout <= f_HEX_2_ASCII(din(3*32+(15) downto 3*32+(12)));
                when st_val3_b4 => dout <= f_HEX_2_ASCII(din(3*32+(19) downto 3*32+(16)));
                when st_val3_b5 => dout <= f_HEX_2_ASCII(din(3*32+(23) downto 3*32+(20)));
                when st_val3_b6 => dout <= f_HEX_2_ASCII(din(3*32+(27) downto 3*32+(24)));
                when st_val3_b7 => dout <= f_HEX_2_ASCII(din(3*32+(31) downto 3*32+(28))); 
                when st_c4      => dout <= X"2C"; -- 0x2c = ','
                when st_val4_b0 => dout <= f_HEX_2_ASCII(din(4*32+( 3) downto 4*32+( 0)));
                when st_val4_b1 => dout <= f_HEX_2_ASCII(din(4*32+( 7) downto 4*32+( 4)));
                when st_val4_b2 => dout <= f_HEX_2_ASCII(din(4*32+(11) downto 4*32+( 8)));
                when st_val4_b3 => dout <= f_HEX_2_ASCII(din(4*32+(15) downto 4*32+(12)));
                when st_val4_b4 => dout <= f_HEX_2_ASCII(din(4*32+(19) downto 4*32+(16)));
                when st_val4_b5 => dout <= f_HEX_2_ASCII(din(4*32+(23) downto 4*32+(20)));
                when st_val4_b6 => dout <= f_HEX_2_ASCII(din(4*32+(27) downto 4*32+(24)));
                when st_val4_b7 => dout <= f_HEX_2_ASCII(din(4*32+(31) downto 4*32+(28)));
                when st_nl      => dout <= X"0D"; -- 0x0d = <CR>                      
                when others     => en_tx <= '0'; dout <= (others => '0');
            end case;
        end if;

    end process;

end Behavioral;
