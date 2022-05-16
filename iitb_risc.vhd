library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity iitb_risc is

	port(
		clk, reset : in std_logic
	);

end entity;

architecture struct of iitb_risc is

	component data_path is
		port(
			clk, reset : in std_logic;
			rb_wr, rb_a2_sel, ir_wr, mem_wr, mem_a_sel, 
				t1_wr, t2_wr, alu_op, alu_a_sel, t3_wr, alu_mod, zero_mod : in std_logic;
			rb_a1_sel, alu_b_sel, rb_a3_sel, t2_din_sel : in std_logic_vector(1 downto 0);
			rb_din_sel : in std_logic_vector(2 downto 0);
			cy, eq, z : out std_logic;
			instruction : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component control_path is
		port(
			clk, reset : in std_logic;
			rb_wr, rb_a2_sel, ir_wr, mem_wr, mem_a_sel, 
				t1_wr, t2_wr, alu_op, alu_a_sel, t3_wr, alu_mod, zero_mod : out std_logic;
			rb_a1_sel, alu_b_sel, rb_a3_sel, t2_din_sel : out std_logic_vector(1 downto 0);
			rb_din_sel : out std_logic_vector(2 downto 0);
			cy, eq, z : in std_logic;
			instruction : in std_logic_vector(15 downto 0)
		);
	end component;

	signal rb_wr, rb_a2_sel, ir_wr, mem_wr, mem_a_sel, 
		t1_wr, t2_wr, alu_op, alu_a_sel, t3_wr, alu_mod, zero_mod : std_logic;
	signal rb_a1_sel, alu_b_sel, rb_a3_sel, t2_din_sel : std_logic_vector(1 downto 0);
	signal rb_din_sel : std_logic_vector(2 downto 0);
	signal cy, eq, z : std_logic;
	signal instruction : std_logic_vector(15 downto 0);
	
begin
	
	dp : data_path port map(
		clk => clk, reset => reset, 
		rb_wr => rb_wr, rb_a2_sel => rb_a2_sel, ir_wr => ir_wr, mem_wr => mem_wr, mem_a_sel => mem_a_sel, 
			t1_wr => t1_wr, t2_wr => t2_wr, alu_op => alu_op, alu_a_sel => alu_a_sel, 
			t3_wr => t3_wr, alu_mod => alu_mod, zero_mod => zero_mod, 
		rb_a1_sel => rb_a1_sel, alu_b_sel => alu_b_sel, rb_a3_sel => rb_a3_sel, t2_din_sel => t2_din_sel, 
		rb_din_sel => rb_din_sel, 
		cy => cy, eq => eq, z => z, 
		instruction => instruction
	);

	cp : control_path port map(
		clk => clk, reset => reset, 
		rb_wr => rb_wr, rb_a2_sel => rb_a2_sel, ir_wr => ir_wr, mem_wr => mem_wr, mem_a_sel => mem_a_sel, 
			t1_wr => t1_wr, t2_wr => t2_wr, alu_op => alu_op, alu_a_sel => alu_a_sel, 
			t3_wr => t3_wr, alu_mod => alu_mod, zero_mod => zero_mod, 
		rb_a1_sel => rb_a1_sel, alu_b_sel => alu_b_sel, rb_a3_sel => rb_a3_sel, t2_din_sel => t2_din_sel, 
		rb_din_sel => rb_din_sel, 
		cy => cy, eq => eq, z => z, 
		instruction => instruction
	);
	
end architecture;