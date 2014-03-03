entity weiss_pipe_TB is
end weiss_pipe_TB;

architecture behave of weiss_pipe_TB is

	component weiss_box_pipe
	port(
		a_in : in BIT;
		b_in : in BIT;
		s_in : in BIT;
		c_in : in BIT;
		s_out : out BIT;
		c_out : out BIT;
		a_out : out BIT;
		b_out : out BIT;
		takt: in BIT
		);
	end component;
	for all: weiss_box_pipe use entity work.weiss_box_pipe(behave);
	
			component weiss_box
	port(
		a_in : in BIT;
		b_in : in BIT;
		s_in : in BIT;
		c_in : in BIT;
		s_out : out BIT;
		c_out : out BIT;
		a_out : out BIT;
		b_out : out BIT);
	end component;
	for all: weiss_box use entity work.weiss_box(behave);
	
	component takt_gen	
	generic(
		puls : TIME;
		pause : TIME);
	port(
		s : in BIT;
		o : out BIT);
	end component;
	for all: takt_gen use entity work.takt_gen(behavior);
	

signal a_in,b_in,c_in,s_in : BIT;
signal a_out,b_out,c_out,s_out: BIT;
signal a_out_p,b_out_p,c_out_p,s_out_p: BIT;
signal takt,s : BIT;

begin	
	
	takt1 : takt_gen
	generic map(
	500 ns,
	500 ns)
	port map(
		s => s,
		o => takt
	);
	
	wbox_pipe : weiss_box_pipe
	port map(
		a_in => a_in,
		b_in => b_in,
		s_in => s_in,
		c_in => c_in,
		s_out => s_out_p,
		c_out => c_out_p,
		a_out => a_out_p,
		b_out => b_out_p,
		takt => takt
	);				 
	
	
	
		wbox : weiss_box
	port map(
		a_in => a_in,
		b_in => b_in,
		s_in => s_in,
		c_in => c_in,
		s_out => s_out,
		c_out => c_out,
		a_out => a_out,
		b_out => b_out
	);
	
	s <= '1' after 0us;
	a_in <= '0' after 0us+1ns, '1' after 80us+1ns;
	b_in <= '0' after 0us+1ns, '1' after 40us+1ns, '0' after 80us+1ns, '1' after 120us+1ns;
	c_in <= '0' after 0us+1ns, '1' after 20us+1ns, '0' after 40us+1ns, '1' after 60us+1ns,'0' after 80us+1ns, '1' after 100us+1ns, '0' after 120us+1ns, '1' after 140us+1ns;
	s_in <= '0' after 0us+1ns, '1' after 10us+1ns, '0' after 20us+1ns, '1' after 30us+1ns,'0' after 40us+1ns, '1' after 50us+1ns, '0' after 60us+1ns, '1' after 70us+1ns,'0' after 80us+1ns, '1' after 90us+1ns, '0' after 100us+1ns, '1' after 110us+1ns,'0' after 120us+1ns, '1' after 130us+1ns, '0' after 140us+1ns, '1' after 150us+1ns;
	
	
end behave;
