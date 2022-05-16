library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity control_path is

	port(
		clk, reset : in std_logic;
		rb_wr, rb_a2_sel, ir_wr, mem_wr, mem_a_sel, 
			t1_wr, t2_wr, alu_op, alu_a_sel, t3_wr, alu_mod, zero_mod : out std_logic;
		rb_a1_sel, alu_b_sel, rb_a3_sel, t2_din_sel : out std_logic_vector(1 downto 0);
		rb_din_sel : out std_logic_vector(2 downto 0);
		cy, eq, z : in std_logic;
		instruction : in std_logic_vector(15 downto 0)
	);

end entity;

architecture behav of control_path is

	type state is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17);
	signal Q, nQ: state := S0;
	signal opcode : std_logic_vector(3 downto 0);
	signal cz : std_logic_vector(1 downto 0);
	signal T : std_logic_vector(22 downto 0);

begin
	
	opcode <= instruction(15 downto 12);
	cz <= instruction(1 downto 0);
	
	process (clk, nQ)
	
	begin
	
		if (clk'event and clk = '1') then
			Q <= nQ;
		end if;
		
	end process;
	
	process (opcode, Q)
	
	begin

		case Q is

			when S0 => 
				T <= "00000000011000000010100";
				
			when S1 => 
				T <= "11000110000000100000001";
				
			when S2 => 
				T <= "00011000010000001100010";
				
			when S3 => 
				T <= "00000000100001000000000";
				
			when S4 => 
				T <= "00010000000000001000000";
				
			when S5 => 
				T <= "10100100000000000000001";
				
			when S6 => 
				T <= "00001000010000001100000";
				
			when S7 => 
				T <= "10100010000000000000001";
				
			when S8 => 
				T <= "01100000000000000000001";
				
			when S9 => 
				T <= "00000000001000001100000";
				
			when S10 => 
				T <= "10000000000000000000001";
				
			when S11 => 
				T <= "00000000010000000001000";
				
			when S12 => 
				T <= "00000000010000000000010";
				
			when S13 => 
				T <= "11000111011000100000001";
				
			when S14 => 
				T <= "11000111111000100000001";
				
			when S15 => 
				T <= "11000000011000100000001";
				
			when S16 => 
				T <= "11100110001000000000001";
				
			when S17 => 
				T <= "11000111110000100000001";
				
		end case;
	
	end process;
	
	process (opcode, Q, cz, eq, z, cy)
	
	begin
	
		case Q is
		
			when S0 =>
				case opcode is
					when "1000" =>
						nQ <= S12;
					when "1001" =>
						nQ <= S15;
					when "1010" =>
						nQ <= S15;
					when "1011" =>
						nQ <= S17;
					when others =>
						nQ <= S1;
				end case;
				
			when S1 =>
				case opcode is
					when "0001" =>
						nQ <= S2;
					when "0000" =>
						nQ <= S6;
					when "0010" =>
						nQ <= S2;
					when "0011" =>
						nQ <= S8;
					when "0111" =>
						nQ <= S9;
					when "0101" =>
						nQ <= S9;
					when "1000" =>
						nQ <= S0;
					when others =>
						nQ <= S0;
				end case;
				
			when S2 =>
				case cz is
					when "11" =>
						nQ <= S4;
					when others =>
						nQ <= S3;
				end case;
			
			when S3 =>
				case opcode is
					when "0001" =>
						nQ <= S5;
					when "0000" =>
						nQ <= S7;
					when "0111" =>
						nQ <= S10;
					when "0101" =>
						nQ <= S11;
					when others =>
						nQ <= S5;
				end case;
						
			when S4 =>
				nQ <= S3;
				
			when S5 =>
				nQ <= S0;
				
			when S6 =>
				nQ <= S3;
			
			when S7 =>
				nQ <= S0;
				
			when S8 =>
				nQ <= S0;
				
			when S9 =>
				nQ <= S3;
				
			when S10 =>
				nQ <= S0;
				
			when S11 =>
				nQ <= S0;
				
			when S12 =>
				case eq is
					when '0' =>
						nQ <= S1;
					when '1' =>
						nQ <= S13;
				end case;
						
			when S13 =>
				nQ <= S0;
				
			when S14 =>
				nQ <= S0;
				
			when S15 =>
				nQ <= S14;
				
			when S16 =>
				nQ <= S0;
				
			when S17 =>
				nQ <= S0;
		
		end case;
		
	end process;
	
	rb_wr <= T(0);
	rb_a2_sel <= T(1);
	ir_wr <= T(2);
	mem_wr <= T(3);
	mem_a_sel <= T(4);
	t1_wr <= T(5);
	t2_wr <= T(6);
	alu_op <= T(7);
	alu_a_sel <= T(8);
	t3_wr <= T(9);
	alu_mod <= T(10);
	zero_mod <= T(11);
	rb_a1_sel <= T(13 downto 12);
	alu_b_sel <= T(15 downto 14);
	rb_a3_sel <= T(17 downto 16);
	t2_din_sel <= T(19 downto 18);
	rb_din_sel <= T(22 downto 20);

end architecture;