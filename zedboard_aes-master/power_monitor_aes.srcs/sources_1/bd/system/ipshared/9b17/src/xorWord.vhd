library ieee;
use ieee.std_logic_1164.all;
use work.aes_package.all;

-- xorWord.vhd
--XORs inWord1 with inWord2, outputs result in outWord

entity xorWord is
    port (clk	   : in  std_logic;
		  inWord1 : in  WORD;
          inWord2 : in  WORD;
          outWord : out WORD;
          s_xorWord : out std_logic
          );
end xorWord;

-- XOR word (4-8 bit per in)
architecture behavioral of xorWord is
signal toggle : WORD := (X"00", X"00", X"00", X"00");
signal w : WORD := (X"00", X"00", X"00", X"00");
signal tmp : std_logic := '0';

begin
    --s_xorWord <= '1';
    w <= (inWord1(0) xor inWord2(0), inWord1(1) xor inWord2(1), inWord1(2) xor inWord2(2), inWord1(3) xor inWord2(3));
	outWord <= w;
    --s_xorWord <= '0';
    signal_toggle : process (clk) is
    begin
    if (clk'event and clk = '1') then
        if (toggle /= w) then
          s_xorWord <= not tmp;
          tmp <= not tmp;
        end if;
        toggle <= w;
    end if;
    end process signal_toggle;

end behavioral;
