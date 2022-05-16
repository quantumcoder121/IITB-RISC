library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity data_path is

	port(
		clk, reset : in std_logic;
		rb_wr, rb_a2_sel, ir_wr, mem_wr, mem_a_sel, 
			t1_wr, t2_wr, alu_op, alu_a_sel, t3_wr, alu_mod, zero_mod : in std_logic;
		rb_a1_sel, alu_b_sel, rb_a3_sel, t2_din_sel : in std_logic_vector(1 downto 0);
		rb_din_sel : in std_logic_vector(2 downto 0);
		cy, eq, z : out std_logic;
		instruction : out std_logic_vector(15 downto 0)
	);

end entity;

architecture struct of data_path is

	component register_bank is
		port(
			clk, reset, wr : in std_logic;
			A1, A2, A3 : in std_logic_vector(2 downto 0);
			Din : in std_logic_vector(15 downto 0);
			Dout1, Dout2 : out std_logic_vector(15 downto 0)
		);
	end component register_bank;
	
	component one_bit_reg is
		port(
			input, clk, reset, wr : in std_logic;
			output : out std_logic
		);
	end component one_bit_reg;
	
	component sixteen_bit_reg is
		port(
			clk, reset, wr : in std_logic;
			input : in std_logic_vector(15 downto 0);
			output : out std_logic_vector(15 downto 0)
		);
	end component sixteen_bit_reg;
	
	component ram is
		port(
			clk, wr : in std_logic;
			Din : in std_logic_vector(15 downto 0);
			A : in std_logic_vector(15 downto 0);
			Dout : out std_logic_vector(15 downto 0)
		);
	end component ram;

	component alu is
		port(
			cin, zin, opsel, mode, zero_mod : in std_logic;
			alu_a, alu_b : in std_logic_vector(15 downto 0);
			cout, zout : out std_logic;
			output : out std_logic_vector(15 downto 0)
		);
	end component alu;

	component sign_extend_six is
		port(
			input : in std_logic_vector(5 downto 0);
			output : out std_logic_vector(15 downto 0)
		);
	end component sign_extend_six;

	component mux_two is
		port(
			i0, i1 : in std_logic_vector(15 downto 0);
			sel : in std_logic;
			output : out std_logic_vector(15 downto 0)
		);
	end component mux_two;

	component mux_four is
		port(
			i0, i1, i2, i3 : in std_logic_vector(15 downto 0);
			svec : in std_logic_vector(1 downto 0);
			output : out std_logic_vector(15 downto 0)
		);
	end component mux_four;

	component mux_eight is
		port(
			i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic_vector(15 downto 0);
			svec : in std_logic_vector(2 downto 0);
			output : out std_logic_vector(15 downto 0)
		);
	end component mux_eight;
	
	component mux_two_v2 is
		port(
			i0, i1 : in std_logic_vector(2 downto 0);
			sel : in std_logic;
			output : out std_logic_vector(2 downto 0)
		);
	end component mux_two_v2;

	component mux_four_v2 is
		port(
			i0, i1, i2, i3 : in std_logic_vector(2 downto 0);
			svec : in std_logic_vector(1 downto 0);
			output : out std_logic_vector(2 downto 0)
		);
	end component mux_four_v2;

	component mux_eight_v2 is
		port(
			i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic_vector(2 downto 0);
			svec : in std_logic_vector(2 downto 0);
			output : out std_logic_vector(2 downto 0)
		);
	end component mux_eight_v2;

	component eq_check is
		port(
			i1, i2 : in std_logic_vector(15 downto 0);
			output : out std_logic
		);
	end component eq_check;

	component bit_shift is
		port(
			input : in std_logic_vector(15 downto 0);
			output : out std_logic_vector(15 downto 0)
		);
	end component bit_shift;
	
	signal rb_a1, rb_a2, rb_a3 : std_logic_vector(2 downto 0);
	signal rb_din, rb_dout1, rb_dout2, ir_out, mem_dout, 
		t3_dout, alu_out, mem_a, se6_out, t1_dout, 
		t2_dout, t2_din, bs_out, alu_a, alu_b : std_logic_vector(15 downto 0);
	signal carry_out, carry_in, zero_out, zero_in, eq_out, eq_in : std_logic;
	
begin
	
	rb : register_bank port map (
		clk => clk, reset => reset, wr => rb_wr, 
		A1 => rb_a1, A2 => rb_a2, A3 => rb_a3, 
		Din => rb_din, 
		Dout1 => rb_dout1, Dout2 => rb_dout2
	);

	rb_mux_a1 : mux_four_v2 port map(
		i0 => "000", i1 => ir_out(8 downto 6), i2 => ir_out(11 downto 9), i3 => "111", 
		svec => rb_a1_sel, 
		output => rb_a1
	);
	
	rb_mux_a2 : mux_two_v2 port map(
		i0 => "111", i1 => ir_out(8 downto 6), 
		sel => rb_a2_sel, 
		output => rb_a2
	);

	rb_mux_a3 : mux_four_v2 port map(
		i0 => ir_out(11 downto 9), i1 => ir_out(8 downto 6), i2 => ir_out(5 downto 3), i3 => "111", 
		svec => rb_a3_sel, 
		output => rb_a3
	);

	rb_mux_din : mux_eight port map(
		i0 => "0000000000000000", i1 => "0000000000000000", i2 => "0000000000000000", 
		i3(15 downto 7) => ir_out(8 downto 0), i3(6 downto 0) => "0000000", i4 => mem_dout, 
		i5 => t3_dout, i6 => alu_out, i7 => rb_dout1, 
		svec => rb_din_sel, 
		output => rb_din
	);
	
	ir : sixteen_bit_reg port map(
		clk => clk, reset => clk, wr => ir_wr, 
		input => mem_dout, 
		output => ir_out
	);
	
	mem : ram port map(
		clk => clk, wr => mem_wr, 
		Din => rb_dout1, 
		A => mem_a, 
		Dout => mem_dout
	);
	
	mem_mux_a : mux_two port map(
		i0 => t3_dout, i1 => rb_dout1, 
		sel => mem_a_sel, 
		output => mem_a
	);
	
	se6 : sign_extend_six port map(
		input => ir_out(5 downto 0), 
		output => se6_out
	);
	
	t1 : sixteen_bit_reg port map(
		clk => clk, reset => reset, wr => t1_wr, 
		input => rb_dout1, 
		output => t1_dout
	);
	
	t2 : sixteen_bit_reg port map(
		clk => clk, reset => reset, wr => t2_wr, 
		input => t2_din, 
		output => t2_dout
	);
	
	bs : bit_shift port map(
		input => t2_dout, 
		output => bs_out
	);

	t2_mux_din : mux_four port map(
		i0(5 downto 0) => ir_out(5 downto 0), i0(15 downto 6) => "0000000000", 
		i1 => se6_out, i2 => bs_out, i3 => rb_dout2, 
		svec => t2_din_sel, 
		output => t2_din
	);
	
	alu_block : alu port map(
		cin => carry_out, zin => zero_out, opsel => alu_op, mode => alu_mod, zero_mod => zero_mod, 
		alu_a => alu_a, alu_b => alu_b, 
		cout => carry_in, zout => zero_in, 
		output => alu_out
	);
	
	alu_mux_a : mux_two port map(
		i0 => t1_dout, i1 => rb_dout1, 
		sel => alu_a_sel, 
		output => alu_a
	);

	alu_mux_b : mux_four port map(
		i0 => "0000000000000001", i1 => t2_dout, 
		i2(5 downto 0) => ir_out(5 downto 0), i2(15 downto 6) => "0000000000", 
		i3(8 downto 0) => ir_out(8 downto 0), i3(15 downto 9) => "0000000", 
		svec => alu_b_sel, 
		output => alu_b
	);
	
	carry_ccr : one_bit_reg port map(
		input => carry_in, clk => clk, reset => reset, wr => '1', 
		output => carry_out
	);
	
	zero_ccr : one_bit_reg port map(
		input => zero_in, clk => clk, reset => reset, wr => '1', 
		output => zero_out
	);

	eq_ccr : one_bit_reg port map(
		input => eq_in, clk => clk, reset => reset, wr => '1', 
		output => eq_out
	);
	
	ec : eq_check port map(
		i1 => rb_dout1, i2 => rb_dout2, 
		output => eq_in
	);
	
	t3 : sixteen_bit_reg port map(
		clk => clk, reset => reset, wr => t3_wr, 
		input => alu_out, 
		output => t3_dout
	);
	
	cy <= carry_out;
	eq <= eq_out;
	z <= zero_out;
	
	instruction <= ir_out;

end architecture;