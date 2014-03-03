entity sch_la_tb is
	generic (breite : INTEGER := 4);
end sch_la_tb;

architecture behave of sch_la_tb is
 
	component schiebe_reg
	generic(
		breite : INTEGER);
	port(
		i : in BIT;
		takt : in BIT;
		o : inout BIT_VECTOR(0 to breite-1));
	end component;
	for all: schiebe_reg use entity work.schiebe_reg(behave);
 		
	component takt_gen
	generic(
		puls : TIME;
		pause : TIME);
	port(
		s : in BIT;
		o : out BIT);
	end component;
	for all: takt_gen use entity work.takt_gen(behavior);  
		
	component latch
	generic(
		breite : INTEGER);
	port(
		takt : in BIT;
		i : in BIT_VECTOR(0 to breite-1);
		o : inout BIT_VECTOR(0 to breite-1));
	end component;
	for all: latch use entity work.latch(behave);
	

signal input, takt, s : BIT := '0';
--signal input_latch : BIT_VECTOR(0 to breite);
signal output_schiebe : BIT_VECTOR(0 to breite-1);
signal output_latch : BIT_VECTOR(0 to breite-1);

begin
	sch_reg : schiebe_reg
	generic map(
		breite
	)
	port map(
		i => input,
		takt => takt,
		o => output_schiebe
	); 
	
	la1 : latch
	generic map(
		breite
	)
	port map(
		takt => takt,
		i => output_schiebe,
		o => output_latch
	);
	
	takt_g : takt_gen
	generic map (
		1ns,
		1ns)
	port map(
		s => s,
		o => takt
	);	
	s <= '1' after 10 ns;
	input <= '0' after 0 ns, '1' after 5 ns, '0' after 35 ns, '1' after 55 ns, '0' after 70 ns, '1' after 80 ns, '0' after 85 ns, '1' after 90 ns, '0' after 95 ns, '1' after 100 ns;	
end  behave;


