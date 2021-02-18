library ieee;
use ieee.std_logic_1164.all;
use work.aes_package.all;

-- xorWord.vhd
--XORs inWord1 with inWord2, outputs result in outWord

entity xorWord is
    port (clk	   : in  std_logic;
		  inWord1 : in  WORD;
          inWord2 : in  WORD;
          outWord : out WORD);
end xorWord;

-- XOR word (4-8 bit per in)
architecture behavioral of xorWord is

	signal s_cnt_out : std_logic_vector(32-1 downto 0);

    component sampler
    Port ( clk : in STD_LOGIC;
           nrst : in STD_LOGIC;
           ev : in STD_LOGIC;
           cnt_out : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

begin
    outWord <= (inWord1(0) xor inWord2(0), inWord1(1) xor inWord2(1), inWord1(2) xor inWord2(2), inWord1(3) xor inWord2(3));

    sampler_1 : sampler port map (clk, '0', outWord, s_cnt_out);
	
end behavioral;
