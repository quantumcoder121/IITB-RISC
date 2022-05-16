library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity mux_eight is

	port(
		i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic_vector(15 downto 0);
		svec : in std_logic_vector(2 downto 0);
		output : out std_logic_vector(15 downto 0)
	);

end entity;

architecture behav of mux_eight is

begin
	
	process (i0, i1, i2, i3, i4, i5, i6, i7, svec)
	
	begin

		case svec is

			when "000" => output <= i0;
		
			when "001" => output <= i1;
		
			when "010" => output <= i2;
		
			when "011" => output <= i3;
			
			when "100" => output <= i4;
		
			when "101" => output <= i5;
		
			when "110" => output <= i6;
		
			when "111" => output <= i7;
		
		end case;
	
	end process;

end architecture;