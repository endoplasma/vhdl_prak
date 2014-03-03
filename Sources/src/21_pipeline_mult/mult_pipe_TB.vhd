entity mult_pipe_TB is
end mult_pipe_TB;

architecture behave of mult_pipe_tb is

	component mult_pipe
	port(
		a : in BIT_VECTOR;
		b : in BIT_VECTOR;
		s : inout BIT_VECTOR;
		takt : in BIT);
	end component;
	for all: mult_pipe use entity work.mult_pipe(behave); 

	component takt_gen
	generic(
		puls : TIME;
		pause : TIME);
	port(
		s : in BIT;
		o : out BIT);
	end component;
	for all: takt_gen use entity work.takt_gen(behavior);
		
	component mult
	port(
		a : in BIT_VECTOR;
		b : in BIT_VECTOR;
		s : inout BIT_VECTOR);
	end component;
	for all: mult use entity work.mult(behave);

	signal a : BIT_VEctor(6 downto  0);
	signal b : BIT_VEctor(2 downto  0);
	signal s_normal,s_pipe : BIT_VECTOR(9 downto 0);
	signal takt : BIT;
	signal takt_select : BIT;
	
begin							   	
	multi_pipe : mult_pipe
	port map(
		a => a,
		b => b,
		s => s_pipe,
		takt => takt
	);
	
	mult_norm : mult
	port map(
		a => a,
		b => b,
		s => s_normal
	);
	
	takt_Generator : takt_gen
	generic map (
	1ns,
	1ns)
	port map(
		s => takt_select,
		o => takt
	);
	
	
	
	--a <= "0110"	after 0ns, "0110" after 5ns,"0101" after 10ns, "1110" after 15ns;
	--b <= "0110"	after 0ns, "0110" after 5ns,"0101" after 10ns, "1110" after 15ns;
	
	
	b <= "101" after 3ns, "010" after 5ns,"010" after 7ns, "111" after 9ns, "000" after 11ns;
	a <= "0110110"	after 3ns, "1100110" after 5ns,"0110011" after 7ns,"1111111" after 9ns, "0000000" after 11ns;
	takt_select <= '1' after 0ns;
	
	
end behave;
