entity UD_counter is
	port (up : in BIT := '1';
	reset, takt: in BIT;
	count0, count1, overfl : out BIT);
end UD_counter;

architecture drei_proc of UD_counter is
--type Zustaende is ("000","010","100","110","111","001");
	
signal akt_zust, next_zust : BIT_VECTOR(0 to 2) := "000";--Zustaende; 
begin
	-- Der nächster Zustand Prozess
	NZ: process (akt_zust, up)
	begin	 
		case akt_zust is
			when "000" => 
			if up='1' then next_zust <= "010";
			elsif up='0' then next_zust <= "001";
			end if ;
			
			when "010" =>
			if up='1' then next_zust <= "100";
			elsif up='0' then next_zust <= "000"; 
			end if ;
			
			when "100" =>
			if up='1' then next_zust <= "110";
			elsif up='0' then next_zust <= "010";
			end if ;
			
			when "110" =>
			if up='1' then next_zust <= "111";
			elsif up='0' then next_zust <= "100";
			end if ;
			
			when "111" =>
			if up='1' then next_zust <= "111";
			elsif up='0' then next_zust <= "100";
			end if ;						   
			
			when "001" =>
			if up='1' then next_zust <= "010";
			elsif up='0' then next_zust <= "001";
			end if ;
			
			when others => next_zust <= "000";
		end case;
	end process;			 
	
	-- Zustandsspeicher Process
	ZS: process (takt, reset)
	begin
		if reset ='1' then akt_zust <= "000";
		elsif takt'event and takt ='1' then
			akt_zust <= next_zust;
		end if;
	end process;

	-- Ausgangslogik
	AL: process (akt_zust)
	begin
		count0 <= akt_zust(1);
		count1 <= akt_zust(0);
		overfl <= akt_zust(2);
	end process;
end drei_proc;

