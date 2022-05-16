library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity sixteen_bit_reg is

	port(
		clk, reset, wr : in std_logic;
		input : in std_logic_vector(15 downto 0);
		output : out std_logic_vector(15 downto 0) := "0000000000000000"
	);

end entity;

architecture behav of sixteen_bit_reg is

begin
	
	process (input, clk, wr, reset)
	
	begin

		if (clk' event and clk = '1') then
		
			if (wr = '1') then
				output <= input;
			end if;
			
			if (reset = '1') then
				output <= "0000000000000000";
			end if;
		
		end if;
		
	end process;

end architecture;