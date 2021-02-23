library ieee;
use ieee.std_logic_1164.all;
use work.aes_package.all;

-- addRoundKey.vhd
-- Performs the Add Round Key operation of the AES process
-- Essemtially XORs the inState with the inKey, and sets the output
-- to outState

entity addRoundKey is
    port (clk	   : in  std_logic;
		  inState  : in  STATE;
          inKey    : in  STATE;
          outState : out STATE;
          s_addRoundKey : out std_logic);
end addRoundKey;

-- Adds the round key to state by an XOR function
architecture behavioral of addRoundKey is

signal toggle : STATE := ((X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00"));
signal s : STATE := ((X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00"), (X"00", X"00", X"00", X"00"));
signal tmp : std_logic := '0';

begin

    loopWords: for i in 0 to (word_size-1) generate
        loopBytes: for j in 0 to (word_size-1) generate
            s(i)(j) <= inState(i)(j) xor inKey(i)(j);
        end generate loopBytes;
    end generate loopWords;
	
	outState <= s;

signal_toggle : process (clk) is
    begin
    if (clk'event and clk = '1') then
        if (toggle /= s) then
          s_addRoundKey <= not tmp;
          tmp <= not tmp;
        end if;
        toggle <= s;
    end if;
    end process signal_toggle;
end behavioral;
