entity sp_automat is	  
	port (start : in BIT := '0';
	reset, takt: in BIT;
	t4 : out BIT := '0');
end sp_automat;

architecture drei_proc of sp_automat is
type Zustaende is (a,b,c,d,e,f,warte);	
signal akt_zust, next_zust : Zustaende := warte; 
begin
	-- Der nächster Zustand Prozess
	NZ: process (akt_zust, start)
	begin	 
		case akt_zust is
			when a => 
			next_zust <= b;
						
			when b =>
			next_zust <= c;
						
			when c =>
			next_zust <= d;
						
			when d =>
			if start='1' then next_zust <= f;
			else next_zust <= e;
			end if ; 
			
			when e =>		  
			if start='1' then next_zust <= a;
			else next_zust <= warte;
			end if;
						
			when f =>
			next_zust <= b;
			
						
			when warte =>
			if start='1' then next_zust <= a;
			end if ;						   
			
			when others => next_zust <= warte;
		end case;
	end process;			 
	
	-- Zustandsspeicher Process
	ZS: process (takt, reset)
	begin
		if reset ='1' then akt_zust <= warte;
		elsif takt'event and takt ='1' then
			akt_zust <= next_zust;
		end if;
	end process;

	-- Ausgangslogik
	AL: process (akt_zust)
	begin
		if akt_zust = f or akt_zust = e then
			t4 <= '1';
		else t4 <= '0';
		end if ;
	end process;
end drei_proc;

