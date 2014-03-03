entity s_reg_pipe is
	generic ( breite : INTEGER);
	port (
		i, takt : in BIT;
		o : out BIT
	);
end s_reg_pipe;	   

architecture behave of s_reg_pipe is
	component dt_b
	port(
		d : in BIT;
		t : in BIT;
		q : out BIT;
		qn : out BIT);
	end component;
	for all: dt_b use entity work.dt_b(behave);
	signal o_int : BIT_VECTOR(0 to breite-1);

begin
	zero_delay: if breite < 1 generate 
		o <= i;
	end generate zero_delay;
	
	delay: if breite > 0 generate 
		o <= o_int(breite-1);
		
		ff1 : dt_b
		port map(
			d => i,
			t => takt,
			q => o_int(0),
			qn => open
		);
		
		gen: for j in 1 to breite-1 generate
			msflipflop: entity dt_b
				port map (
					d => o_int(j-1),
					t => takt,
					q => o_int(j),
					qn => open
				);
		end generate gen;
	end generate delay;
end behave;