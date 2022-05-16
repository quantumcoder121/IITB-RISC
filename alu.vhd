library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity alu is

	port(
		cin, zin, opsel, mode, zero_mod : in std_logic;
		alu_a, alu_b : in std_logic_vector(15 downto 0);
		cout, zout : out std_logic;
		output : out std_logic_vector(15 downto 0) := "0000000000000000"
	);

end entity;

architecture struct of alu is

	component sixteen_bit_adder is
		port(
			cin : in std_logic;
			a, b : in std_logic_vector(15 downto 0);
			s : out std_logic_vector(15 downto 0);
			cout : out std_logic
		);
	end component sixteen_bit_adder;
	
	signal add_cout, scin : std_logic;
	signal add_out, nand_out, out_buff : std_logic_vector(15 downto 0);

begin
	
	process (mode, cin)
	
	begin
	
		if (mode = '0') then
			scin <= '0';
		else
			scin <= cin;
		end if;
	
	end process;
	
	add_unit : sixteen_bit_adder port map(cin => scin, a => alu_a, b => alu_b, s => add_out, cout => add_cout);
	
	nand_out(0) <= alu_a(0) nand alu_b(0);
	
	nand_out(1) <= alu_a(1) nand alu_b(1);
	
	nand_out(2) <= alu_a(2) nand alu_b(2);
	
	nand_out(3) <= alu_a(3) nand alu_b(3);
	
	nand_out(4) <= alu_a(4) nand alu_b(4);
	
	nand_out(5) <= alu_a(5) nand alu_b(5);
	
	nand_out(6) <= alu_a(6) nand alu_b(6);
	
	nand_out(7) <= alu_a(7) nand alu_b(7);
	
	nand_out(8) <= alu_a(8) nand alu_b(8);
	
	nand_out(9) <= alu_a(9) nand alu_b(9);
	
	nand_out(10) <= alu_a(10) nand alu_b(10);
	
	nand_out(11) <= alu_a(11) nand alu_b(11);
	
	nand_out(12) <= alu_a(12) nand alu_b(12);
	
	nand_out(13) <= alu_a(13) nand alu_b(13);
	
	nand_out(14) <= alu_a(14) nand alu_b(14);
	
	nand_out(15) <= alu_a(15) nand alu_b(15);
	
	process (opsel, add_cout, nand_out, mode, cin, add_out)
	
	begin
	
		if (opsel = '0') then
			
			out_buff <= add_out;
			
			if (mode = '1') then
				cout <= add_cout;
			else
				cout <= cin;
			end if;
			
		else
			out_buff <= nand_out;
			cout <= cin;
		end if;
	
	end process;
	
	process (out_buff, zin, mode, zero_mod)
	
	begin
	
	if (mode = '1' or zero_mod = '1') then
	
		zout <= not(
			out_buff(0) or
			out_buff(1) or
			out_buff(2) or
			out_buff(3) or
			out_buff(4) or
			out_buff(5) or
			out_buff(6) or
			out_buff(7) or
			out_buff(8) or
			out_buff(9) or
			out_buff(10) or
			out_buff(11) or
			out_buff(12) or
			out_buff(13) or
			out_buff(14) or
			out_buff(15)
		);
		
	else
	
		zout <= zin;
		
	end if;
	
	end process;
	
	output <= out_buff;
	
end architecture;