entity weiss_box_pipe is
	port( 
		a_in,b_in,s_in,c_in : in BIT;	
		s_out,c_out,a_out,b_out : out BIT;
		takt : in BIT
		);
end weiss_box_pipe;

architecture behave of weiss_box_pipe is

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

	component voll_add
	port(
		a : in BIT;
		b : in BIT;
		c_in : in BIT;
		c_out : out BIT;
		s : out BIT);
	end component;
	for all: voll_add use entity work.voll_add(behave);		 
		
	component s_reg_pipe
	generic(
		breite : INTEGER);
	port(
		i : in BIT;
		takt : in BIT;
		o : out BIT);
	end component;
	for all: s_reg_pipe use entity work.s_reg_pipe(behave);
		
signal 	s_delay, c_delay : BIT :='0';
	
signal out_mult : BIT;
	
begin
	
	a_del : s_reg_pipe
	generic map(
		breite => 1
	)
	port map(
		i => a_in,
		takt => takt,
		o => a_out
	);
	
	b_del : s_reg_pipe
	generic map(
		breite => 1
	)
	port map(
		i => b_in,
		takt => takt,
		o => b_out
	);
	
	c_del : s_reg_pipe
	generic map(
		breite => 1
	)
	port map(
		i => c_delay,
		takt => takt,
		o => c_out
	);
	

	s_del : s_reg_pipe
	generic map(
		breite => 2
	)
	port map(
		i => s_delay,
		takt => takt,
		o => s_out
	);
	
	
	mult : and2
	port map(
		i1 => a_in,
		i2 => b_in,
		o => out_mult
	);
	
	voll : voll_add
	port map(
		a => out_mult,
		b => s_in,
		c_in => c_in,
		c_out => c_delay,
		s => s_delay
	);
	
end behave;

		
		