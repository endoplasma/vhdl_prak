library gat;
use gat.generator;

entity sp_parity_TB is
end sp_parity_TB;

architecture behave of sp_parity_TB is 

	component sp_parity_umsetzer
	port(
		takt : in BIT;
		start : in BIT;
		t4 : inout BIT;
		daten_in : in BIT;
		daten_out : inout BIT_VECTOR(0 to 3));
	end component;
	for all: sp_parity_umsetzer use entity work.sp_parity_umsetzer(behave);


	component generator
	port(
		daten : inout BIT;
		takt : inout BIT;
		start : inout BIT);
	end component;
	for all: generator use entity gat.generator(behavior); 
		
	
signal takt, start, daten : BIT := '0';
signal output : BIT_VECTOR(0 to 3);
signal t4 : BIT := '0';

begin 
	
	generator1 : generator
	port map(
		daten => daten,
		takt => takt,
		start => start
	);


parity_umsetzer : sp_parity_umsetzer
	port map(
		takt => takt,
		start => start,
		t4 => t4,
		daten_in => daten,
		daten_out => output
	);	


end  behave;


