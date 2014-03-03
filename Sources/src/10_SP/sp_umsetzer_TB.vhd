library gat;
use gat.generator;

entity sp_umsetzer_TB is
end sp_umsetzer_TB;

architecture behave of sp_umsetzer_TB is 

	component sp_umsetzer
	port(
		takt : in BIT;
		start : in BIT;
		t4 : inout BIT;
		daten_in : in BIT;
		daten_out : inout BIT_VECTOR(0 to 3));
	end component;
	for all: sp_umsetzer use entity work.sp_umsetzer(behave);
		
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

	sp_umsetzer1 : sp_umsetzer
	port map(
		takt => takt,
		start => start,
		t4 => t4,
		daten_in => daten,
		daten_out => output
	);

end  behave;


