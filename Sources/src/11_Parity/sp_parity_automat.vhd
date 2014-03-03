entity sp_parity_automat is	  
	port (start, daten : in BIT := '0';
	reset, takt: in BIT;
	t4 : out BIT := '0');
end sp_parity_automat;

architecture drei_proc of sp_parity_automat is
type Zustaende is (	
		warten,
		bit1_u, bit1_g,
		bit1_u_sent_t4, bit1_g_sent_t4,
		bit2_u, bit2_g,
		bit3_u, bit3_g,
		bit4_u, bit4_g,
		sent_t4	);	
signal akt_zust, next_zust : Zustaende := warten; 
begin
	-- Der nächster Zustand Prozess
	NZ: process (akt_zust, start, daten)
	begin	 
		case akt_zust is
			when warten =>
			if start='1' and daten = '1' then next_zust <= bit1_u;
			elsif start='1' and daten = '0' then next_zust <= bit1_g;
			end if;
			
			--bit1
			when bit1_u =>
			if daten = '1' then next_zust <= bit2_g;
			else next_zust <= bit2_u;
			end if;					
			
			when bit1_g =>
			if daten = '1' then next_zust <= bit2_u;
			else next_zust <= bit2_g;
			end if;	 
			
			when bit1_u_sent_t4 =>
			if daten = '1' then next_zust <= bit2_g;
			else next_zust <= bit2_u;
			end if;					
			
			when bit1_g_sent_t4 =>
			if daten = '1' then next_zust <= bit2_u;
			else next_zust <= bit2_g;
			end if;	
			
			--bit 2
			when bit2_u =>
			if daten = '1' then next_zust <= bit3_g;
			else next_zust <= bit3_u;
			end if;
			when bit2_g =>
			if daten = '1' then next_zust <= bit3_u;
			else next_zust <= bit3_g;
			end if;		
			
			--bit3
			when bit3_u =>
			if daten = '1' then next_zust <= bit4_g;
			else next_zust <= bit4_u;
			end if;
			when bit3_g =>
			if daten = '1' then next_zust <= bit4_u;
			else next_zust <= bit4_g;
			end if;
			
			--bit4
			when bit4_u =>
			if start='1' then
				if daten = '1' then
					next_zust <= bit1_u;
				else next_zust <= bit1_g;
				end if;
			else next_zust <= warten;
			end if;	  
			
			when bit4_g =>
			if start='1' then
				if daten = '1' then
					next_zust <= bit1_u_sent_t4;
				else next_zust <= bit1_g_sent_t4;
				end if;
			else next_zust <= sent_t4;
			end if;
			
			-- sent_t4
			when sent_t4 =>
			if start='1' and daten = '1' then next_zust <= bit1_u;
			elsif start='1' and daten = '0' then next_zust <= bit1_g;
			else next_zust <= warten;
			end if;
			
			
			
			when others => next_zust <= warten;
		end case;
	end process;			 
	
	-- Zustandsspeicher Process
	ZS: process (takt, reset)
	begin
		if reset ='1' then akt_zust <= warten;
		elsif takt'event and takt ='1' then
			akt_zust <= next_zust;
		end if;
	end process;

	-- Ausgangslogik
	AL: process (akt_zust)
	begin
		if akt_zust = sent_t4 
				or akt_zust = bit1_g_sent_t4 
				or akt_zust = bit1_u_sent_t4 then
			t4 <= '1';
		else t4 <= '0';
		end if ;
	end process;
end drei_proc;

