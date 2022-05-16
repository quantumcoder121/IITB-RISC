library ieee;
	use ieee.std_logic_1164.all;
	--use ieee.numeric_std.all;

entity register_bank is

	port(
		clk, reset, wr : in std_logic;
		A1, A2, A3 : in std_logic_vector(2 downto 0);
		Din : in std_logic_vector(15 downto 0);
		Dout1, Dout2 : out std_logic_vector(15 downto 0) := "0000000000000000"
	);

end entity;

architecture behav of register_bank is

	component sixteen_bit_reg is
		port(
			clk, reset, wr : in std_logic;
			input : in std_logic_vector(15 downto 0);
			output : out std_logic_vector(15 downto 0)
		);
	end component sixteen_bit_reg;
	
	signal reg_wr : std_logic_vector(7 downto 0);
	signal reg_out0, reg_out1, reg_out2, reg_out3, 
		reg_out4, reg_out5, reg_out6, reg_out7 : std_logic_vector(15 downto 0);

begin
	
	r0 : sixteen_bit_reg port map(clk => clk, reset => reset, wr => reg_wr(0), input => Din, output => reg_out0);
	
	r1 : sixteen_bit_reg port map(clk => clk, reset => reset, wr => reg_wr(1), input => Din, output => reg_out1);
	
	r2 : sixteen_bit_reg port map(clk => clk, reset => reset, wr => reg_wr(2), input => Din, output => reg_out2);
	
	r3 : sixteen_bit_reg port map(clk => clk, reset => reset, wr => reg_wr(3), input => Din, output => reg_out3);
	
	r4 : sixteen_bit_reg port map(clk => clk, reset => reset, wr => reg_wr(4), input => Din, output => reg_out4);
	
	r5 : sixteen_bit_reg port map(clk => clk, reset => reset, wr => reg_wr(5), input => Din, output => reg_out5);
	
	r6 : sixteen_bit_reg port map(clk => clk, reset => reset, wr => reg_wr(6), input => Din, output => reg_out6);
	
	r7 : sixteen_bit_reg port map(clk => clk, reset => reset, wr => reg_wr(7), input => Din, output => reg_out7);
	
	process (A1, reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6, reg_out7)
	
	begin

		case A1 is
		
			when "000" => Dout1 <= reg_out0;
			
			when "001" => Dout1 <= reg_out1;
			
			when "010" => Dout1 <= reg_out2;
			
			when "011" => Dout1 <= reg_out3;
			
			when "100" => Dout1 <= reg_out4;
			
			when "101" => Dout1 <= reg_out5;
			
			when "110" => Dout1 <= reg_out6;
			
			when "111" => Dout1 <= reg_out7;
			
		end case;

	end process;
	
	process (A2, reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6, reg_out7)
	
	begin

		case A2 is
		
			when "000" => Dout2 <= reg_out0;
			
			when "001" => Dout2 <= reg_out1;
			
			when "010" => Dout2 <= reg_out2;
			
			when "011" => Dout2 <= reg_out3;
			
			when "100" => Dout2 <= reg_out4;
			
			when "101" => Dout2 <= reg_out5;
			
			when "110" => Dout2 <= reg_out6;
			
			when "111" => Dout2 <= reg_out7;
			
		end case;

	end process;
	
	process (A3, wr)
	
	begin

		if (wr = '1') then
			
			case A3 is
		
				when "000" => reg_wr <= "00000001";
			
				when "001" => reg_wr <= "00000010";
			
				when "010" => reg_wr <= "00000100";
			
				when "011" => reg_wr <= "00001000";
			
				when "100" => reg_wr <= "00010000";
			
				when "101" => reg_wr <= "00100000";
			
				when "110" => reg_wr <= "01000000";
			
				when "111" => reg_wr <= "10000000";
			
			end case;
			
		else
		
			reg_wr <= "00000000";
			
		end if;

	end process;

end architecture;