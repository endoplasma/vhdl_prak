entity sp_umsetzer is 
	port( 
	takt: in BIT;
	start: in BIT := '0';
	t4: inout BIT := '0';
	daten_in : in BIT;
	daten_out : inout BIT_VECTOR(0 to 3)
	);	
end sp_umsetzer;

architecture behave of sp_umsetzer is
	component sp_automat
	port(
		start : in BIT;
		reset : in BIT;
		takt : in BIT;
		t4 : out BIT);
	end component;
	for all: sp_automat use entity work.sp_automat(drei_proc);
		
	component latch
	generic(
		breite : INTEGER);
	port(
		takt : in BIT;
		i : in BIT_VECTOR(0 to breite-1);
		o : inout BIT_VECTOR(0 to breite-1));
	end component;
	for all: latch use entity work.latch(behave);  
		
	component schiebe_reg
	generic(
		breite : INTEGER);
	port(
		i : in BIT;
		takt : in BIT;
		o : inout BIT_VECTOR(0 to breite-1));
	end component;
	for all: schiebe_reg use entity work.schiebe_reg(behave);
		
signal daten_intern : BIT_VECTOR(0 to 3);
begin
	
	Automat : sp_automat
	port map(
		start => start,
		reset => '0',
		takt => takt,
		t4 => t4
	); 
	
	register1 : schiebe_reg
	generic map(
		breite => 4
	)
	port map(
		i => daten_in,
		takt => takt,
		o => daten_intern
	);
	
	Latch1: latch
	generic map(
		breite => 4
	)
	port map(
		takt => t4,
		i => daten_intern,
		o => daten_out
	);
	
	
	
end behave;