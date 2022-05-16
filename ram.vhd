library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity ram is
	
	port(
		clk, wr : in std_logic;
		Din : in std_logic_vector(15 downto 0);
		A : in std_logic_vector(15 downto 0);
		Dout : out std_logic_vector(15 downto 0)
	);

end entity;

architecture behav of ram is

	type mem is array(0 to 127) of std_logic_vector(15 downto 0);
	signal ram_block : mem;

begin

	process (clk, ram_block, A)

	begin
		
		Dout <= ram_block(to_integer(unsigned(A(8 downto 0))));
		
		if (clk'event and clk = '1') then
		
			if (wr = '1') then
				ram_block(to_integer(unsigned(A(8 downto 0)))) <= Din;
			end if;

		end if;
		
	end process;
	
end architecture;