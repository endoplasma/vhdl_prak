entity parity_gen is				
	port(
		d : in BIT_VECTOR;
		s: in BIT;
		p: out BIT);
end parity_gen;

architecture behave of parity_gen is
	component xor2
	generic(
		tphl : TIME := 0 ns;
		tplh : TIME := 0 ns);
	port(
		i1 : in BIT;
		i2 : in BIT;
		o : out BIT);
	end component;
	for all: xor2 use entity work.xor2(behavior);


signal temp : BIT_VEctor (0 to 2*d'length-2);

begin
	
	temp(0 to d'length-1) <= d;
	
	
	gen_loop: for x in 0 to d'length-2 generate 
	
	xor_gen : xor2
	generic map( 5ns, 5ns)
	port map(
		i1 => temp(2*x),
		i2 => temp(2*x+1),
		o => temp(d'length+x)
	);
	end generate;
	
	xor_par : xor2
	generic map( 5ns, 5ns)
	port map(
		i1 => temp(temp'length-1),
		i2 => s,
		o => p
	);	

	
		

end behave;