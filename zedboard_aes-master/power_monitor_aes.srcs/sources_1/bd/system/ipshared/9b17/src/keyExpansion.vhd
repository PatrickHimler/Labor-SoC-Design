library ieee;
use ieee.std_logic_1164.all;
use work.aes_package.all;

-- keyExpansion.vhd
-- The single 128 bit inKey is expanded using Rijndael's Key Schedule
-- to produce keys for the 10 rounds necessary in 128 bit AES encryption or decryption
-- Details can be found at https://en.wikipedia.org/wiki/Rijndael_key_schedule


entity keyExpansion is
    port (clk	   : in  std_logic;
		  inMode      : in AES_MODE;
		  inKey       : in  WORD_ARRAY  (0 to word_size-1);
          outRoundKey : out STATE_ARRAY (0 to num_rounds-1);
          s_xorWord : out std_logic--;
          --s_sBox_e : out std_logic
          );
end keyExpansion;

-- Create round keys for each state/ round in AES from key
architecture behavioral of keyExpansion is
    signal tmp : WORD_ARRAY (0 to word_size*num_rounds-1); -- 44 (4 words (32-bits) for 11 rounds)
	signal outRoundKey_encrypt : STATE_ARRAY (0 to num_rounds-1);
	signal outRoundKey_decrypt : STATE_ARRAY (0 to num_rounds-1);
    signal s_xorWord_v : std_logic_vector (30-1 downto 0) := (others => '0');
    --signal s_sBox_e_v : std_logic_vector (10-1 downto 0);
    signal toggle : std_logic_vector (30-1 downto 0) := (others => '0');
	
	signal tmp1 : std_logic := '0';
begin
    tmp(0 to word_size-1) <= inKey;
    
    -- XOR for round 1, last row in state is subRotRcon
    xorWord01: entity work.xorWord port map (clk => clk, inWord1 => tmp( 1), inWord2 => tmp( 4), outWord => tmp( 5), s_xorWord => s_xorWord_v(1-1));
    xorWord02: entity work.xorWord port map (clk => clk, inWord1 => tmp( 2), inWord2 => tmp( 5), outWord => tmp( 6), s_xorWord => s_xorWord_v(2-1));
    xorWord03: entity work.xorWord port map (clk => clk, inWord1 => tmp( 3), inWord2 => tmp( 6), outWord => tmp( 7), s_xorWord => s_xorWord_v(3-1));

    -- XOR for round 2, using previous round key computations
    xorWord04: entity work.xorWord port map (clk => clk, inWord1 => tmp( 5), inWord2 => tmp( 8), outWord => tmp( 9), s_xorWord => s_xorWord_v(4-1));
    xorWord05: entity work.xorWord port map (clk => clk, inWord1 => tmp( 6), inWord2 => tmp( 9), outWord => tmp(10), s_xorWord => s_xorWord_v(5-1));
    xorWord06: entity work.xorWord port map (clk => clk, inWord1 => tmp( 7), inWord2 => tmp(10), outWord => tmp(11), s_xorWord => s_xorWord_v(6-1));
    
    xorWord07: entity work.xorWord port map (clk => clk, inWord1 => tmp( 9), inWord2 => tmp(12), outWord => tmp(13), s_xorWord => s_xorWord_v(7-1));
    xorWord08: entity work.xorWord port map (clk => clk, inWord1 => tmp(10), inWord2 => tmp(13), outWord => tmp(14), s_xorWord => s_xorWord_v(8-1));
    xorWord09: entity work.xorWord port map (clk => clk, inWord1 => tmp(11), inWord2 => tmp(14), outWord => tmp(15), s_xorWord => s_xorWord_v(9-1));
    
    xorWord10: entity work.xorWord port map (clk => clk, inWord1 => tmp(13), inWord2 => tmp(16), outWord => tmp(17), s_xorWord => s_xorWord_v(10-1));
    xorWord11: entity work.xorWord port map (clk => clk, inWord1 => tmp(14), inWord2 => tmp(17), outWord => tmp(18), s_xorWord => s_xorWord_v(11-1));
    xorWord12: entity work.xorWord port map (clk => clk, inWord1 => tmp(15), inWord2 => tmp(18), outWord => tmp(19), s_xorWord => s_xorWord_v(12-1));    
    
    xorWord13: entity work.xorWord port map (clk => clk, inWord1 => tmp(17), inWord2 => tmp(20), outWord => tmp(21), s_xorWord => s_xorWord_v(13-1));
    xorWord14: entity work.xorWord port map (clk => clk, inWord1 => tmp(18), inWord2 => tmp(21), outWord => tmp(22), s_xorWord => s_xorWord_v(14-1));
    xorWord15: entity work.xorWord port map (clk => clk, inWord1 => tmp(19), inWord2 => tmp(22), outWord => tmp(23), s_xorWord => s_xorWord_v(15-1));
    
    xorWord16: entity work.xorWord port map (clk => clk, inWord1 => tmp(21), inWord2 => tmp(24), outWord => tmp(25), s_xorWord => s_xorWord_v(16-1));
    xorWord17: entity work.xorWord port map (clk => clk, inWord1 => tmp(22), inWord2 => tmp(25), outWord => tmp(26), s_xorWord => s_xorWord_v(17-1));
    xorWord18: entity work.xorWord port map (clk => clk, inWord1 => tmp(23), inWord2 => tmp(26), outWord => tmp(27), s_xorWord => s_xorWord_v(18-1));
    
    xorWord19: entity work.xorWord port map (clk => clk, inWord1 => tmp(25), inWord2 => tmp(28), outWord => tmp(29), s_xorWord => s_xorWord_v(19-1));
    xorWord20: entity work.xorWord port map (clk => clk, inWord1 => tmp(26), inWord2 => tmp(29), outWord => tmp(30), s_xorWord => s_xorWord_v(20-1));
    xorWord21: entity work.xorWord port map (clk => clk, inWord1 => tmp(27), inWord2 => tmp(30), outWord => tmp(31), s_xorWord => s_xorWord_v(21-1));
    
    xorWord22: entity work.xorWord port map (clk => clk, inWord1 => tmp(29), inWord2 => tmp(32), outWord => tmp(33), s_xorWord => s_xorWord_v(22-1));
    xorWord23: entity work.xorWord port map (clk => clk, inWord1 => tmp(30), inWord2 => tmp(33), outWord => tmp(34), s_xorWord => s_xorWord_v(23-1));
    xorWord24: entity work.xorWord port map (clk => clk, inWord1 => tmp(31), inWord2 => tmp(34), outWord => tmp(35), s_xorWord => s_xorWord_v(24-1));
    
    xorWord25: entity work.xorWord port map (clk => clk, inWord1 => tmp(33), inWord2 => tmp(36), outWord => tmp(37), s_xorWord => s_xorWord_v(25-1));
    xorWord26: entity work.xorWord port map (clk => clk, inWord1 => tmp(34), inWord2 => tmp(37), outWord => tmp(38), s_xorWord => s_xorWord_v(26-1));
    xorWord27: entity work.xorWord port map (clk => clk, inWord1 => tmp(35), inWord2 => tmp(38), outWord => tmp(39), s_xorWord => s_xorWord_v(27-1));
    
    xorWord28: entity work.xorWord port map (clk => clk, inWord1 => tmp(37), inWord2 => tmp(40), outWord => tmp(41), s_xorWord => s_xorWord_v(28-1));
    xorWord29: entity work.xorWord port map (clk => clk, inWord1 => tmp(38), inWord2 => tmp(41), outWord => tmp(42), s_xorWord => s_xorWord_v(29-1));
    xorWord30: entity work.xorWord port map (clk => clk, inWord1 => tmp(39), inWord2 => tmp(42), outWord => tmp(43), s_xorWord => s_xorWord_v(30-1));
    
    -- Substitute, rotate Rcon for round 1
    subRotRcon01: entity work.subRotRcon port map (clk => clk, inWord1 => tmp( 0), inWord2 => tmp( 3), rcon => RCON( 1), outWord => tmp( 4)); --, s_sBox_e => s_sBox_e_v(1-1)
    subRotRcon02: entity work.subRotRcon port map (clk => clk, inWord1 => tmp( 4), inWord2 => tmp( 7), rcon => RCON( 2), outWord => tmp( 8));
    subRotRcon03: entity work.subRotRcon port map (clk => clk, inWord1 => tmp( 8), inWord2 => tmp(11), rcon => RCON( 3), outWord => tmp(12));
    subRotRcon04: entity work.subRotRcon port map (clk => clk, inWord1 => tmp(12), inWord2 => tmp(15), rcon => RCON( 4), outWord => tmp(16));
    subRotRcon05: entity work.subRotRcon port map (clk => clk, inWord1 => tmp(16), inWord2 => tmp(19), rcon => RCON( 5), outWord => tmp(20));
    subRotRcon06: entity work.subRotRcon port map (clk => clk, inWord1 => tmp(20), inWord2 => tmp(23), rcon => RCON( 6), outWord => tmp(24));
    subRotRcon07: entity work.subRotRcon port map (clk => clk, inWord1 => tmp(24), inWord2 => tmp(27), rcon => RCON( 7), outWord => tmp(28));
    subRotRcon08: entity work.subRotRcon port map (clk => clk, inWord1 => tmp(28), inWord2 => tmp(31), rcon => RCON( 8), outWord => tmp(32));
    subRotRcon09: entity work.subRotRcon port map (clk => clk, inWord1 => tmp(32), inWord2 => tmp(35), rcon => RCON( 9), outWord => tmp(36));
    subRotRcon10: entity work.subRotRcon port map (clk => clk, inWord1 => tmp(36), inWord2 => tmp(39), rcon => RCON(10), outWord => tmp(40));
    
	-- Encrypt
    -- First round is the key itself
	loopOutput_encrypt: for i in 0 to num_rounds-1 generate
		outRoundKey_encrypt(i) <= (tmp(i*word_size), tmp(i*word_size+1), tmp(i*word_size+2), tmp(i*word_size+3));
	end generate loopOutput_encrypt;
	-- Decrypt
    -- Decryption round keys in reverse
	loopOutput_decrypt: for i in 0 to num_rounds-1 generate
		outRoundKey_decrypt(num_rounds-1-i) <= (tmp(i*word_size), tmp(i*word_size+1), tmp(i*word_size+2), tmp(i*word_size+3));
	end generate loopOutput_decrypt;
	-- Mux
	outRoundKey <= outRoundKey_encrypt when (inMode = ENCRYPTION) else outRoundKey_decrypt;

    s_xorWord <= s_xorWord_v(0); -- for testing
--    signal_toggle : process (clk) is
--    begin
--    if (clk'event and clk = '1') then
--        if (toggle /= s_xorWord_v) then
--          s_xorWord <= not tmp1;
--          tmp1 <= not tmp1;
--        end if;
--        toggle <= s_xorWord_v;
--    end if;
--    end process signal_toggle;
    --s_xorWord <= s_xorWord_v(0);
    --s_sBox_e <= s_sBox_e_v(0);

end behavioral;
