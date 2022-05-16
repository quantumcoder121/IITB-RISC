library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity full_adder is

	port(
		a, b, cin : in std_logic;
		s, cout : out std_logic
	);

end entity;

architecture struct of full_adder is

begin

	s <= a xor b xor cin;
	
	cout <= (a and b) or (cin and a) or (cin and b);

end architecture;