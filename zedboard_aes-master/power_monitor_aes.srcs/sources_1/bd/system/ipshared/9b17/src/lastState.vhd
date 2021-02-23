library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.aes_package.all;

-- lastState.vhd
-- Similar to nextState, this ooks together the steps necessary for the round of the AES encyrption process
-- In the final round, there are no Mix Columns operation
-- For encryption: inState -> Sub Bytes -> Shift Rows -> Add Round Key -> outState
-- For decryption: inState -> Inverse Shift Rows -> Inverse Sub Bytes -> Inverse Add Round Key -> outState
-- Both encryption and decryption are calculated, and the proper output is sent per the mode in

entity lastState is
	port (clk	   : in  std_logic;
		  inState : in  STATE;
			mode  : in AES_MODE;
			inKey : in  STATE;
			outState : out STATE;
			s_addRoundKey : out std_logic
			);
			
end lastState;

architecture Behavioral of lastState is
	signal temp_encrypt : STATE_ARRAY (0 to 2);
	signal temp_decrypt : STATE_ARRAY (0 to 2);
	signal s_addRoundKey_v : std_logic_vector (1 downto 0) := "00";
	signal toggle_add : std_logic_vector(1 downto 0) := "00";
	
	signal tmp : std_logic := '0';

begin
		subBytes   : entity work.subBytes    port map (clk => clk, inMode => ENCRYPTION, inState => inState, outState => temp_encrypt (0));
		shiftRows  : entity work.shiftRows   port map (inMode => ENCRYPTION, inState => temp_encrypt (0), outState => temp_encrypt (1));
		addRoundKey: entity work.addRoundKey port map (clk => clk, inState => temp_encrypt (1), inKey => inKey, outState => temp_encrypt (2), s_addRoundKey => s_addRoundKey_v(0)); 
	

		invShiftRows : entity work.shiftRows port map (inMode => DECRYPTION, inState => inState, outState => temp_decrypt (0));
		invSubBytes  : entity work.subBytes  port map (clk => clk, inMode => DECRYPTION, inState => temp_decrypt (0), outState => temp_decrypt (1));
		invAddRoundKey  : entity work.addRoundKey  port map (clk => clk, inState => temp_decrypt (1), inKey => inKey, outState => temp_decrypt (2), s_addRoundKey => s_addRoundKey_v(1));
		
		outState <= temp_encrypt (2) when (mode = ENCRYPTION) else temp_decrypt (2);

signal_toggle_add : process (clk) is
    begin
    if (clk'event and clk = '1') then
        if (toggle_add /= s_addRoundKey_v) then
          s_addRoundKey <= not tmp;
          tmp <= not tmp;
        end if;
        toggle_add <= s_addRoundKey_v;
    end if;
    end process signal_toggle_add;
 
end Behavioral;

