entity weiss_TB is
end weiss_TB;

architecture behave of weiss_TB is

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

signal a_in,b_in,c_in,s_in : BIT;
signal a_out,b_out,c_out,s_out: BIT;

begin
	
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
	
	a_in <= '0' after 0ns, '1' after 80ns;
	b_in <= '0' after 0ns, '1' after 40ns, '0' after 80ns, '1' after 120ns;
	c_in <= '0' after 0ns, '1' after 20ns, '0' after 40ns, '1' after 60ns,'0' after 80ns, '1' after 100ns, '0' after 120ns, '1' after 140ns;
	s_in <= '0' after 0ns, '1' after 10ns, '0' after 20ns, '1' after 30ns,'0' after 40ns, '1' after 50ns, '0' after 60ns, '1' after 70ns,'0' after 80ns, '1' after 90ns, '0' after 100ns, '1' after 110ns,'0' after 120ns, '1' after 130ns, '0' after 140ns, '1' after 150ns;
	
	
end behave;
