entity barrel_TB is
end barrel_TB;

architecture behave of barrel_TB is	

	component barrel4
	port(
		i0 : in BIT;
		i1 : in BIT;
		i2 : in BIT;
		i3 : in BIT;
		q0 : out BIT;
		q1 : out BIT;
		q2 : out BIT;
		q3 : out BIT;
		shift : in INTEGER);
	end component;
	for all: barrel4 use entity work.barrel4(behave);
	signal input : BIT_VECTOR(0 to 3);
	signal output : BIT_VECTOR(0 to 3); 
	signal shift : INTEGER := 0;
begin
	
	Shifter: barrel4
	port map(
		i0 => input(0),
		i1 => input(1),
		i2 => input(2),
		i3 => input(3),
		q0 => output(0),
		q1 => output(1),
		q2 => output(2),	  
		q3 => output(3),
		shift => shift
	);
	
	input <= "1011"; 
	shift <= 1 after 10ns, 2 after 20ns, 3 after 30ns, -1 after 40 ns, -23 after 50ns , 1234 after 60 ns, 4 after 70 ns;
	
	
end behave;