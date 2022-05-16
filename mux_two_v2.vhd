library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity mux_two_v2 is

	port(
		i0, i1 : in std_logic_vector(2 downto 0);
		sel : in std_logic;
		output : out std_logic_vector(2 downto 0)
	);

end entity;

architecture behav of mux_two_v2 is

begin
	
	process (i0, i1, sel)
	
	begin

		case sel is

			when '0' => output <= i0;
		
			when '1' => output <= i1;
				
		end case;
	
	end process;

end architecture;