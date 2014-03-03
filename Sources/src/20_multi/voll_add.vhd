entity voll_add is
	port( a,b,c_in :in BIT;
		c_out,s :out BIT);		
end voll_add;		 

architecture behave of voll_add is

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
	  
	component or2
	generic(
		tphl : TIME := 0 ns;
		tplh : TIME := 0 ns);
	port(
		i1 : in BIT;
		i2 : in BIT;
		o : out BIT);
	end component;
	for all: or2 use entity work.or2(behavior);

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
	 
signal out_h_add1, out_and1, out_and2 : BIT := '0';		
begin
	
	xor_1 : xor2
	port map(
		i1 => a,
		i2 => b,
		o => out_h_add1
	);
	xor_2 : xor2
	port map(
		i1 => out_h_add1,
		i2 => c_in,
		o => s
	);
	
	and_1: and2
	port map(
		i1 => a,
		i2 => b,
		o => out_and1
	);
	
	and_2: and2
	port map(
		i1 => c_in,
		i2 => out_h_add1,
		o => out_and2
	);
	
	or_1 : or2
	port map(
		i1 => out_and1,
		i2 => out_and2,
		o => c_out
	);
	
end behave;

