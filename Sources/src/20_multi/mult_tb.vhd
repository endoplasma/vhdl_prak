entity mult_TB is
end mult_TB;

architecture behave of Mult_tb is
	component mult
	port(
		a : in BIT_VECTOR;
		b : in BIT_VECTOR;
		s : inout BIT_VECTOR);
	end component;
	for all: mult use entity work.mult(behave);

	signal a : BIT_VEctor(6 downto  0);
	signal b : BIT_VEctor(2 downto  0);
	signal s : BIT_VECTOR(15 downto 0);
begin							   	
	multi : mult
	port map(
		a => a,
		b => b,
		s => s
	);
	
	b <= "101" after 0ns, "010" after 5ns,"010" after 10ns, "111" after 15ns;
	a <= "0110110"	after 0ns, "1100110" after 5ns,"0110011" after 10ns,"1111111" after 15ns;
end behave;
