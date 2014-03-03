entity latch is
	generic ( breite : INTEGER);
	port (
		takt : in BIT;
		i : in BIT_VECTOR(0 to breite-1) ;
		o : inout BIT_VECTOR(0 to breite-1) 
	);
end latch;	   

architecture behave of latch is
	component dt_b
	port(
		d : in BIT;
		t : in BIT;
		q : out BIT;
		qn : out BIT);
	end component;
	for all: dt_b use entity work.dt_b(behave);

begin
	gen: for j in 0 to breite-1 generate
		msflipflop: entity dt_b
			port map (
				d => i(j),
				t => takt,
				q => o(j),
				qn => open
			);
	end generate;
end behave;