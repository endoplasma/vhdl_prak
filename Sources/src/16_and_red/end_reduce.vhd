entity end_reduce is
	port (i: in BIT_VECTOR;
	result: out BIT);
end end_reduce;

architecture behave of end_reduce is
signal i_temp : Bit_vector (0 to i'length-1);
signal intern : Bit_vector (0 to i'length);

	component and2
	generic(
		tphl : TIME := 0 ns;
		tplh : TIME := 0 ns);
	port(
		i1 : in BIT;
		i2 : in BIT;
		o : out BIT);
	end component;
	for all: and2 use entity work.and2(behavior);


begin
	i_temp <= i;
	intern(0)<='1' ;
	result <= intern(i_temp'length);
	
		
	gen_loop: for x in 0 to i_temp'length-1 generate 
		and_gen : and2
		port map(
			i1 => intern(x),
			i2 => i_temp(x),
			o => intern(x+1)
		);
	end generate gen_loop;
end behave;

