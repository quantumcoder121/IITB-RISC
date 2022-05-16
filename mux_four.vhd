library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity mux_four is

	port(
		i0, i1, i2, i3 : in std_logic_vector(15 downto 0);
		svec : in std_logic_vector(1 downto 0);
		output : out std_logic_vector(15 downto 0)
	);

end entity;

architecture behav of mux_four is

begin
	
	process (i0, i1, i2, i3, svec)
	
	begin

		case svec is

			when "00" => output <= i0;
		
			when "01" => output <= i1;
		
			when "10" => output <= i2;
		
			when "11" => output <= i3;
		
		end case;
	
	end process;

end architecture;