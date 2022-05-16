library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity one_bit_reg is

	port(
		input, clk, reset, wr : in std_logic;
		output : out std_logic := '0'
	);

end entity;

architecture behav of one_bit_reg is

begin
	
	process (input, clk, wr, reset)
	
	begin

		if (clk' event and clk = '1') then
		
			if (wr = '1') then
				output <= input;
			end if;
			
			if (reset = '1') then
				output <= '0';
			end if;	
		
		end if;
		
	end process;

end architecture;