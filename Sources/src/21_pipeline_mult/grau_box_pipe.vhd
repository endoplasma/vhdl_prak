entity grau_box_pipe is
	generic(
		delay_in : Integer
	);
	port(
	s_in, c_in, u_in : in BIT;
	s_out, u_out : out BIT;
	takt :in BIT	
	);
end grau_box_pipe;

architecture behave of grau_box_pipe is

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
	
	signal s_in_delay,c_in_delay, u_out_no_delay : BIT := '0';
begin
	c_delay : s_reg_pipe
	generic map(
		breite => 2*delay_in
	)
	port map(
		i => c_in,
		takt => takt,
		o => c_in_delay
	);
	s_delay : s_reg_pipe
	generic map(
		breite => 2*delay_in
	)
	port map(
		i => s_in,
		takt => takt,
		o => s_in_delay
	);
	u_delay : s_reg_pipe
	generic map(
		breite => 1
	)
	port map(
		i => u_out_no_delay,
		takt => takt,
		o => u_out
	);
	
	voll: voll_add
	port map(
		a => s_in_delay,
		b => c_in_delay,
		c_in => u_in,
		c_out => u_out_no_delay,
		s => s_out
	);
end behave;
