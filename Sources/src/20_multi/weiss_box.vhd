entity weiss_box is
	port( 
		a_in,b_in,s_in,c_in : in BIT;	
		s_out,c_out,a_out,b_out : out BIT
		);
end weiss_box;

architecture behave of weiss_box is

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

signal out_mult : BIT;
	
begin
	
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
		c_out => c_out,
		s => s_out
	);
	
	a_out <= a_in;
	b_out <= b_in;

end behave;

		
		