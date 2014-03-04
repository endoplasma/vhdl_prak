use ram_pack.all;
use numeric_conv.all;

entity ram is
	generic (
		adr_breite:INTEGER
	);
	port (
		adr : in BIT_VECTOR(0 to adr_breite-1);
		din : in byte;
		do : out byte;
		read : in BIT
		);
end ram;

architecture behave of ram is 
signal Speicher_Mat : s_mat(0 to 2**adr_breite) := ((others=> (others=>'0')));
signal write_puls : BIT;
signal zyklus_zeit,write_start,testsig : TIME := 0ns;
begin
	lesen: process
	begin
		wait on adr;
		wait for 8ns;
		if read = '1' then
			wait for 52ns;
			if read = '1' and read'last_event >= 52ns then
				do <= Speicher_Mat(to_integer(adr));
			else
				assert false
				report "Fehler beim Lesen"
				severity WARNING;
			end if;
		end if;
	end process	;
	
	schreiben: process
	begin
		wait on read until read='0';
		--testsig <= adr'last_event-din'last_event;
		assert (adr'last_event-din'last_event <= 20ns)
			report "Daten lagen nicht schnell genung an!"
			severity WARNING;	
		write_start <= now;
		assert din'last_event > 10ns
			report "Daten liegen noch nicht lang genug an"
			severity WARNING;
		wait on read until read='1';
		assert (din'last_event >= (now-write_start))
			report "Daten nicht stabil!"
			severity WARNING; 
		
		Speicher_Mat(to_integer(adr)) <= din;
	end process;
	
	zyklus: process(adr)
	begin
		assert (now-zyklus_zeit) >= 120ns
			report "Zykluszeit wurde nicht eingehalten"
		  	severity WARNING;
			-- error
		zyklus_zeit <= now;
	end process;
	
	impuls: process
	begin							
		
		wait on read until read='0';
		wait for 10ns;
		assert read'last_event >= 10ns
			report "Schreib-Impuls zu kurz"
		  	severity WARNING;
			-- error
	end process;
	
end behave;