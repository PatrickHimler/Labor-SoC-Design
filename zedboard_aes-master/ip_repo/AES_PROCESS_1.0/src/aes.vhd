library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.aes_package.all;

-- aes.vhd
-- The overall state machine that runs the AES Algorithm
-- INPUTS:
-- clk   - clock signal
-- reset - resets the state machine, to be used after done = 1 and data has been read from "o"
-- mode  - selects encryption or decryption
-- i     - 128 bit input state to be encrypted to decrypted
-- k     - 128 bit key to be used
-- OUTPUTS:
-- o     - 128 resulting output (encrypted or decrypted input)
-- done  - asserted when data has been processed through the final round, data is ready to be read from "o"
--
-- This 128 bit implimentation of AES requires 10 clock cycles from reset until "done" is asserted

entity aes is	
	port (clk   : in  std_logic;
			reset : in  std_logic;
			done : out std_logic;
			mode : in AES_MODE;
			i     : in  STATE;
			k     : in  STATE;
			o     : out STATE;
			s_xorWord : out std_logic;
			s_mixColumns : out std_logic;
			--s_sBox_e : out std_logic;
			--s_sBox_d : out std_logic;
			s_addRoundKey : out std_logic
			);

end aes;

architecture Behavioral of aes is
	type ROUND_TYPE is (round0, round1, round2, round3, round4, round5, round6, round7, 
							  round8, round9, round10);
							  
	signal round : ROUND_TYPE;	
	signal key_schedule : STATE_ARRAY (0 to 10);
	signal curr_key : STATE;
	signal curr_state : STATE;
	signal next_state : STATE;
	signal first_state : STATE;
	
	signal key_state_array : WORD_ARRAY (0 to 3);

	--signal s_xorWord_v : std_logic;
	--signal s_mixColumns_v : std_logic;
	signal s_addRoundKey_v : std_logic_vector(2 downto 0);

	signal toggle_add : std_logic_vector(2 downto 0);
	signal tmp : std_logic := '0';
	
begin
    key_state_array <= (k(0), k(1), k(2), k(3));

    -- Key schedule created for all 10+1 rounds, kept in the key_schedule state array
	generate_key_schedule:
	entity work.keyExpansion port map (clk => clk, inMode => mode, inKey => key_state_array, outRoundKey => key_schedule, s_xorWord => s_xorWord);

	-- The initial round consists of only the Add Round Key processs
	generate_first_state:
	entity work.addRoundKey port map (clk => clk, inState => i, inKey => key_schedule (0), outState => first_state, s_addRoundKey => s_addRoundKey_v(0));
	
	-- nextState is used for each round of the AES process, and progresses via the state machine below
	-- where we move curr_state and curr_key forward, and set the new key via the held key_schedule state array
	generate_next_state:
	entity work.nextState port map (clk => clk, inState => curr_state, mode=> mode, inKey => curr_key, outState => next_state, s_mixColumns => s_mixColumns, s_addRoundKey => s_addRoundKey_v(1));

	-- similar to nextState, except internally there is no MixColumns that occurs
	generate_last_state:  
	entity work.lastState port map (clk => clk, inState => curr_state, mode => mode, inKey => curr_key, outState => o, s_addRoundKey => s_addRoundKey_v(2));
	
	process (clk, reset) begin
		-- Reset to first round, data no longer valid at output
		if reset = '1' then
			round <= round0;
			done <= '0';
		
		elsif clk'event and clk = '1' then
			case round is
				when round0  => round <= round1;
									 curr_key <= key_schedule (1);
									 curr_state <= first_state;
									 
				when round1  => round <= round2;
									 curr_key <= key_schedule (2);
									 curr_state <= next_state;
									 
				when round2  => round <= round3;
									 curr_key <= key_schedule (3);
									 curr_state <= next_state;
									 
				when round3  => round <= round4;
									 curr_key <= key_schedule (4);
									 curr_state <= next_state;
									 
				when round4  => round <= round5;
									 curr_key <= key_schedule (5);
									 curr_state <= next_state;
									 
				when round5  => round <= round6;
									 curr_key <= key_schedule (6);
									 curr_state <= next_state;
									 
				when round6  => round <= round7;
									 curr_key <= key_schedule (7);
									 curr_state <= next_state;
									 
				when round7  => round <= round8;
									 curr_key <= key_schedule (8);
									 curr_state <= next_state;
									 
				when round8  => round <= round9;
									 curr_key <= key_schedule (9);
									 curr_state <= next_state;
									 
				when round9  => round <= round10;
									 curr_key <= key_schedule (10);
									 curr_state <= next_state;
				
				-- The final round keeps the current state at current state, the data is 
				-- simply held at round 10 until a reset is called
				when round10 => round <= round10;
										curr_key <= key_schedule (10);
										curr_state <= curr_state;
										done <= '1';
									 
				when others  => round <= round0;
									 curr_key <= key_schedule (0);
									 curr_state <= curr_state;
				
			end case;
			
		end if;
		
	end process;


signal_toggle_add : process (s_addRoundKey_v) is
    begin
    if (toggle_add /= s_addRoundKey_v) then
      s_addRoundKey <= not tmp;
	  tmp <= not tmp;
    end if;
    toggle_add <= s_addRoundKey_v;
end process signal_toggle_add;

	--s_xorWord <= s_xorWord_v;
	--s_mixColumns <= s_mixColumns_v;
	--s_addRoundKey <= s_addRoundKey_v;

end Behavioral;

