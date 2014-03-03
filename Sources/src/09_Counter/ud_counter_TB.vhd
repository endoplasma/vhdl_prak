entity ud_counter_TB is
end ud_counter_TB;

architecture behave of ud_counter_TB is 

	component ud_counter
	port(
		up : in BIT;
		reset : in BIT;
		takt : in BIT;
		count0 : out BIT;
		count1 : out BIT;
		overfl : out BIT);
	end component;
	for all: ud_counter use entity work.ud_counter(drei_proc);
	
	component takt_gen
	generic(
		puls : TIME;
		pause : TIME);
	port(
		s : in BIT;
		o : out BIT);
	end component;
	for all: takt_gen use entity work.takt_gen(behavior);  
		
signal input, reset, takt, s: BIT := '0';
signal output : BIT_VECTOR(0 to 1);
signal overfl : BIT := '0';

begin
	takt_g : takt_gen
	generic map (
		1ns,
		1ns)
	port map(
		s => s,
		o => takt
	);
	
	counter1 : ud_counter
	port map(
		up => input,
		reset => reset,
		takt => takt,
		count0 => output(1),
		count1 => output(0),
		overfl => overfl
	);
	s <= '1' after 5 ns;
	input <= '1' after 0 ns, '0' after 35 ns, '1' after 55 ns, '0' after 70 ns, '1' after 80 ns, '0' after 85 ns, '1' after 90 ns, '0' after 95 ns, '1' after 100 ns;	
	reset <= '1' after 22ns, '0' after 27ns, '1' after 70 ns, '0' after 75ns;
end  behave;


