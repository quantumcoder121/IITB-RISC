library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity eq_check is

	port(
		i1, i2 : in std_logic_vector(15 downto 0);
		output : out std_logic
	);

end entity;

architecture struct of eq_check is

begin
	
	output <= (i1(0) xnor i2(0)) and
		(i1(1) xnor i2(1)) and
		(i1(2) xnor i2(2)) and
		(i1(3) xnor i2(3)) and
		(i1(4) xnor i2(4)) and
		(i1(5) xnor i2(5)) and
		(i1(6) xnor i2(6)) and
		(i1(7) xnor i2(7)) and
		(i1(8) xnor i2(8)) and
		(i1(9) xnor i2(9)) and
		(i1(10) xnor i2(10)) and
		(i1(11) xnor i2(11)) and
		(i1(12) xnor i2(12)) and
		(i1(13) xnor i2(13)) and
		(i1(14) xnor i2(14)) and
		(i1(15) xnor i2(15));
	
end architecture;