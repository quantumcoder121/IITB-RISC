library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity sign_extend_six is

	port(
		input : in std_logic_vector(5 downto 0);
		output : out std_logic_vector(15 downto 0)
	);

end entity;

architecture behav of sign_extend_six is

begin
	
	output(5 downto 0) <= input(5 downto 0);
	
	process (input)
	
	begin
	
		if (input(5) = '0') then
			output(15 downto 6) <= "0000000000";
		else
			output(15 downto 6) <= "1111111111";
		end if;
	
	end process;
	
end architecture;