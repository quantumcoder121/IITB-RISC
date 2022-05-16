library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity sixteen_bit_adder is

	port(
		cin : in std_logic;
		a, b : in std_logic_vector(15 downto 0);
		s : out std_logic_vector(15 downto 0);
		cout : out std_logic
	);

end entity;

architecture struct of sixteen_bit_adder is

	component full_adder is
		port(
			a, b, cin : in std_logic;
			s, cout : out std_logic
		);
	end component full_adder;
	
	signal cvec : std_logic_vector(14 downto 0);

begin

	f0 : full_adder port map(a => a(0), b => b(0), cin => cin, s => s(0), cout => cvec(0));
	
	f1 : full_adder port map(a => a(1), b => b(1), cin => cvec(0), s => s(1), cout => cvec(1));
	
	f2 : full_adder port map(a => a(2), b => b(2), cin => cvec(1), s => s(2), cout => cvec(2));
	
	f3 : full_adder port map(a => a(3), b => b(3), cin => cvec(2), s => s(3), cout => cvec(3));
	
	f4 : full_adder port map(a => a(4), b => b(4), cin => cvec(3), s => s(4), cout => cvec(4));
	
	f5 : full_adder port map(a => a(5), b => b(5), cin => cvec(4), s => s(5), cout => cvec(5));
	
	f6 : full_adder port map(a => a(6), b => b(6), cin => cvec(5), s => s(6), cout => cvec(6));
	
	f7 : full_adder port map(a => a(7), b => b(7), cin => cvec(6), s => s(7), cout => cvec(7));
	
	f8 : full_adder port map(a => a(8), b => b(8), cin => cvec(7), s => s(8), cout => cvec(8));
	
	f9 : full_adder port map(a => a(9), b => b(9), cin => cvec(8), s => s(9), cout => cvec(9));
	
	f10 : full_adder port map(a => a(10), b => b(10), cin => cvec(9), s => s(10), cout => cvec(10));
	
	f11 : full_adder port map(a => a(11), b => b(11), cin => cvec(10), s => s(11), cout => cvec(11));
	
	f12 : full_adder port map(a => a(12), b => b(12), cin => cvec(11), s => s(12), cout => cvec(12));
	
	f13 : full_adder port map(a => a(13), b => b(13), cin => cvec(12), s => s(13), cout => cvec(13));
	
	f14 : full_adder port map(a => a(14), b => b(14), cin => cvec(13), s => s(14), cout => cvec(14));
	
	f15 : full_adder port map(a => a(15), b => b(15), cin => cvec(14), s => s(15), cout => cout);

end architecture;