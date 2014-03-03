entity dt_b_tb is
end dt_b_tb;

architecture behave of dt_b_tb is
 
	component dt_b
	port(
		d : in BIT;
		t : in BIT;
		q : out BIT;
		qn : out BIT);
	end component;
	for all: dt_b use entity work.dt_b(behave);	
		
	component takt_gen
	generic(
		puls : TIME;
		pause : TIME);
	port(
		s : in BIT;
		o : out BIT);
	end component;
	for all: takt_gen use entity work.takt_gen(behavior);
	
	component xor2
	generic(
		tphl : TIME := 0 ns;
		tplh : TIME := 0 ns);
	port(
		i1 : in BIT;
		i2 : in BIT;
		o : out BIT);
	end component;
	for all: xor2 use entity work.xor2(behavior);

signal i1,i2 : BIT :='0';
signal input, output_q , output_qn , takt, s : BIT := '0';

begin
	
	FF: dt_b
	port map(
		d => input,
		t => takt,
		q => output_q,
		qn => output_qn
	);
	
	takt_g : takt_gen
	generic map (
		1ns,
		1ns)
	port map(
		s => s,
		o => takt
	);
	
	xor_1 : xor2
	port map(
		i1 => i1,
		i2 =>i2,
		o => input
	);
	
	s <= '1' after 10 ns;
	i1 <= '0' after 0 ns, '1' after 5 ns, '1' after 35 ns, '1' after 55 ns, '0' after 70 ns, '1' after 80 ns, '0' after 85 ns, '1' after 90 ns, '0' after 95 ns, '1' after 100 ns;	
	i2 <= '1' after 0 ns, '0' after 5 ns, '0' after 35 ns, '0' after 55 ns, '1' after 70 ns, '0' after 80 ns, '1' after 85 ns, '0' after 90 ns, '0' after 95 ns, '1' after 100 ns;	

	--input <= '0' after 0 ns, '1' after 5 ns, '1' after 35 ns, '1' after 55 ns, '0' after 70 ns, '1' after 80 ns, '0' after 85 ns, '1' after 90 ns, '0' after 95 ns, '1' after 100 ns;	
end  behave;


