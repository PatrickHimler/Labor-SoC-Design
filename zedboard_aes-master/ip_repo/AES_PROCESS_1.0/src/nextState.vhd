library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.aes_package.all;

-- nextState.vhd
-- Hooks together the steps necessary in each round of the AES encyrption process
-- For encryption: inState -> Sub Bytes -> Shift Rows -> Mix Columns -> Add Round Key -> outState
-- For decryption: inState -> Inverse Shift Rows -> Inverse Sub Bytes -> Add Round Key -> Mix Columns -> outState
-- Both encryption and decryption are calculated, and the proper output is sent per the mode in

entity nextState is

	port (clk	   : in  std_logic;
		  inState : in  STATE;
			inKey : in  STATE;
			mode  : AES_MODE;
			outState : out STATE;
			s_mixColumns : out std_logic;
			s_addRoundKey : out std_logic
			);
			
end nextState;

architecture Behavioral of nextState is
	signal temp_encrypt : STATE_ARRAY (0 to 3);
	signal temp_decrypt : STATE_ARRAY (0 to 3);

	--signal s_mixColumns_v : std_logic;
	--signal s_addRoundKey_v : std_logic;
	signal s_mixColumns_v : std_logic_vector (1 downto 0) := "00";
	signal s_addRoundKey_v : std_logic_vector (1 downto 0)  := "00";

	signal toggle_mix : std_logic_vector(1 downto 0) := "00";
	signal toggle_add : std_logic_vector(1 downto 0) := "00";
	
	signal tmp1 : std_logic := '0';
	signal tmp2 : std_logic := '0';

begin
		
		subBytes   : entity work.subBytes    port map (clk => clk, inMode => ENCRYPTION, inState  => inState, outState  => temp_encrypt (0));
		shiftRows  : entity work.shiftRows   port map (inMode => ENCRYPTION, inState => temp_encrypt (0), outState  => temp_encrypt (1));
		mixColumns : entity work.mixColumns  port map (clk => clk, inState  => temp_encrypt (1), mode => ENCRYPTION, outState  => temp_encrypt (2), s_mixColumns => s_mixColumns_v(0));	--!
		addRoundKey: entity work.addRoundKey port map (clk => clk, inState => temp_encrypt (2), inKey => inKey, outState => temp_encrypt (3), s_addRoundKey => s_addRoundKey_v(0));			--!
		
		invShiftRows : entity work.shiftRows  port map (inMode => DECRYPTION, inState => inState, outState => temp_decrypt (0));
		invSubBytes  : entity work.subBytes   port map (clk => clk, inMode => DECRYPTION, inState => temp_decrypt (0), outState => temp_decrypt (1));
		invAddRoundKey  : entity work.addRoundKey   port map (clk => clk, inState => temp_decrypt (1), inKey => inKey, outState => temp_decrypt (2), s_addRoundKey => s_addRoundKey_v(1));	--!
		invMixColumns: entity work.mixColumns port map (clk => clk, inState => temp_decrypt (2), mode => DECRYPTION, outState => temp_decrypt (3), s_mixColumns => s_mixColumns_v(1));		--!
		
		outState <= temp_encrypt (3) when (mode = ENCRYPTION) else temp_decrypt (3);


signal_toggle_mix : process (clk) is
    begin
    if (clk'event and clk = '1') then
        if (toggle_mix /= s_mixColumns_v) then
          s_mixColumns <= not tmp1;
          tmp1 <= not tmp1;
        end if;
        toggle_mix <= s_mixColumns_v;
    end if;
    end process signal_toggle_mix;

signal_toggle_add : process (clk) is
    begin
    if (clk'event and clk = '1') then
        if (toggle_add /= s_addRoundKey_v) then
          s_addRoundKey <= not tmp2;
          tmp2 <= not tmp2;
        end if;
        toggle_add <= s_addRoundKey_v;
    end if;
    end process signal_toggle_add;
		--s_mixColumns <= s_mixColumns_v;
		--s_addRoundKey <= s_addRoundKey_v;

end Behavioral;

