entity schiebe_reg is
	generic ( breite : INTEGER);
	port (
		i, takt : in BIT;
		o : inout BIT_VECTOR(0 to breite-1) 
	);
end schiebe_reg;	   

architecture behave of schiebe_reg is
	component dt_b
	port(
		d : in BIT;
		t : in BIT;
		q : out BIT;
		qn : out BIT);
	end component;
	for all: dt_b use entity work.dt_b(behave);

begin
	ff1 : dt_b
	port map(
		d => i,
		t => takt,
		q => o(0),
		qn => open
	);
	
	gen: for j in 0 to breite-2 generate
		msflipflop: entity dt_b
			port map (
				d => o(j),
				t => takt,
				q => o(j+1),
				qn => open
			);
	end generate;
end behave;