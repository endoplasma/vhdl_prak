entity grau_box is
	port(
	s_in, c_in, u_in : in BIT;
	s_out, u_out : out BIT
	);
end grau_box;

architecture behave of grau_box is

	component voll_add
	port(
		a : in BIT;
		b : in BIT;
		c_in : in BIT;
		c_out : out BIT;
		s : out BIT);
	end component;
	for all: voll_add use entity work.voll_add(behave);

begin
	voll: voll_add
	port map(
		a => s_in,
		b => c_in,
		c_in => u_in,
		c_out => u_out,
		s => s_out
	);
end behave;
