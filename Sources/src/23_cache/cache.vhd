use numeric_conv.all;

entity cache is
	port(
	clk : in BIT;
	-- Prozessor
	addr_proc : in BIT_VECTOR(15 downto 0);
	data_proc_in : in BIT_VECTOR(7 downto 0);
	data_proc_out : out BIT_VECTOR(7 downto 0);
	request : in BIT;
	rw_proc: in BIT;
	delay : out BIT;
	
	-- Memory Interface
	addr_mem : out BIT_VECTOR(15 downto 0);
	data_mem_in : in BIT_VECTOR(7 downto 0);
	data_mem_out : out BIT_VECTOR(7 downto 0);
	rw_mem : out BIT := '1'
	);

end cache;

architecture behave of cache is

subtype byte is BIT_VECTOR(7 downto 0)	;
--array (7 downto 0) of BIT;
--type tag is array (6 downto 0) of BIT;
type cache_line is array (0 to 3) of byte;

type TAG_TABLE_TYPE is array (0 to 127) of BIT_VECTOR(6 downto 0 ) ;
type FLAG_TABLE_TYPE is array (0 to 127) of BIT;
type CACHE_MAT is array (0 to 127) of CACHE_LINE;

signal hit : BIT := '0';
signal rw_start,w_start,r_start : BIT := '0';


signal Tag_Table : TAG_TABLE_TYPE := (others=>(others=>'0'));
signal Flag_Table : FLAG_TABLE_TYPE:=(others=>'0');
signal Cache_Speicher : CACHE_MAT:=(others=>(others=>(others=>'0'))) ;

type steuer_zust is (idle, r_hit, r_miss, write, write_delay1, r_miss_delay1,write_delay2, r_miss_delay2);	
--type read_zust is (idle, c_B1_1, c_B1_2, c_B1_3, c_B1_4
--			, c_B2_1, c_B2_2, c_B2_3, c_B2_4
--			, c_B3_1, c_B3_2, c_B3_3, c_B3_4
--			, c_B4_1, c_B4_2, c_B4_3, c_B4_4);	
--type write_zust is (idle, w_miss, w_hit, w_pulse, w_pulse_end, w_wait);

type read_zust is (idle, c_B1_1, c_B1_2, c_B1_3, c_B1_4
			, c_B2_1, c_B2_2, c_B2_3, c_B2_4
			, c_B3_1, c_B3_2, c_B3_3, c_B3_4
			, c_B4_1, c_B4_2, c_B4_3, c_B4_4
			, w_miss, w_hit, w_pulse, w_pulse_end, w_wait);	

signal s_akt_zust, s_next_zust : steuer_Zust := idle;
--signal r_akt_zust, r_next_zust : read_Zust := idle;
--signal w_akt_zust, w_next_zust : write_Zust := idle;
signal r_akt_zust, r_next_zust : read_Zust := idle;

begin
	
	--                                          cacheline(index)                       offset
	data_proc_out  <=   Cache_Speicher(to_integer(addr_proc(8 downto 2)))(to_integer(addr_proc(1 downto 0)));

	
hit_proc: process(addr_proc)
begin 

	--- Hit Process
	
	if (addr_proc(15 downto 9) = Tag_Table(to_integer(addr_proc(8 downto 2)))) AND flag_table(to_integer(addr_proc(8 downto 2)))='1' then
		hit <= '1' ;
	else
		hit <= '0';
	end if;		
	end process hit_proc;

	--- ##############################################################
	--- # Steuer Prozess											  
	--- ##############################################################
	s_NZ: process (s_akt_zust, request, w_start, r_start)									  
	begin	 
		case s_akt_zust is

			when idle =>
			if request='1' and rw_proc='1' and hit='1' then s_next_zust <= r_hit;
			elsif request='1' and rw_proc='1' and hit='0' then s_next_zust <= r_miss; 
			elsif request='1' and rw_proc='0' then s_next_zust <= write;
			end if ; 
			
			when r_hit =>
			s_next_zust <= idle; 
			
			when r_miss =>
			s_next_zust <= r_miss_delay1;
			
			when write =>
			s_next_zust <= write_delay1;
			
			when write_delay1 =>
			s_next_zust <= write_delay2;
			
			when r_miss_delay1 =>
			s_next_zust <= r_miss_delay2;
						
			when r_miss_delay2 =>
			if r_start='0' then s_next_zust <= idle;
			end if ; 
					
			when write_delay2 =>
			if w_start='0' then s_next_zust <= idle;
			end if ; 
		
			when others => s_next_zust <= idle;
		end case;
	end process;			 
	
	-- Zustandsspeicher Process
	s_ZS: process (clk)
	begin
		if clk'event and clk ='1' then
			s_akt_zust <= s_next_zust;
		end if;
	end process;

	-- Ausgangslogik
	s_AL: process (s_akt_zust)
	begin
		case s_akt_zust is

			when idle => 
			delay <= '0';
			rw_Start <= '0';

			when r_hit => 
			--                                          cacheline(index)                       offset
			--data_proc_out  <=   Cache_Speicher(to_integer(addr_proc(8 downto 2)))(to_integer(addr_proc(1 downto 0)));

			when r_miss => 
				delay <= '1';
				rw_Start <= '1';
			
			when write =>
				delay <= '1';
				rw_Start <= '1';
				
				
			when write_delay2 =>
			rw_start <= '0';
			
			when r_miss_delay2 =>
				rw_start <= '0';
			when others => 
				null;
		end case;

	end process;

	--- ##############################################################
	--- # Lesen/Schreiben Prozess	
	--- ##############################################################
	
		r_NZ: process (r_akt_zust, rw_start)									  
	begin	 
		case r_akt_zust is

			when idle =>
			if rw_start = '1' and rw_proc='1' then 
				r_next_zust <= c_B1_1;
			elsif rw_start = '1' and rw_proc='0' and hit = '0' then 
				r_next_zust <= w_miss;
			elsif rw_start = '1' and rw_proc='0' and hit = '1' then  
				r_next_zust <= w_hit;
			end if ;
-- B1			
			when c_B1_1 =>
			r_next_zust <=	c_B1_2;	 
			
			when  c_B1_2 =>
			r_next_zust <=	c_B1_3;
			
			when  c_B1_3 =>
			r_next_zust <=	c_B1_4;	

			when  c_B1_4 =>
			r_next_zust <=	c_B2_1;
--B2			
			when  c_B2_1    =>
			r_next_zust <=	c_B2_2;	

			when  c_B2_2		  =>
			r_next_zust <=	c_B2_3;
			
			when  c_B2_3		=>
			r_next_zust <=	c_B2_4;	

			when  c_B2_4			  =>
			r_next_zust <=	c_B3_1;
--B3
			when  c_B3_1			=>
			r_next_zust <=	c_B3_2;	

			when  c_B3_2				  =>
			r_next_zust <=	c_B3_3;
			
			when  c_B3_3				=>
			r_next_zust <=	c_B3_4;	

			when  c_B3_4					 =>
			r_next_zust <=	c_B4_1;			
--B4
			when  c_B4_1				   =>
			r_next_zust <=	c_B4_2;	

			when  c_B4_2						 =>
			r_next_zust <=	c_B4_3;
			
			when  c_B4_3					   =>
			r_next_zust <=	c_B4_4;	
													 
			when  c_B4_4							 =>
			r_next_zust <=	idle;
			
			
--- Write Zustände
			when w_miss =>
			r_next_zust <= w_pulse;
			
			when w_hit =>
			r_next_zust <= w_pulse;
						
			when w_pulse =>
			r_next_zust <= w_pulse_end;
			
			when w_pulse_end =>
			r_next_zust <= w_wait;
			
			when w_wait =>
			r_next_zust <= idle;
			

			when others => r_next_zust <= idle;
		end case;
	end process;			 
	
	-- Zustandsspeicher Process
	r_ZS: process (clk)
	begin
		if clk'event and clk ='1' then
			r_akt_zust <= r_next_zust;
		end if;
	end process;

	-- Ausgangslogik
	r_AL: process (r_akt_zust)
	begin
		if r_akt_zust = idle then
			r_start <= '0';			 
			w_start <= '0';			 
-- Byte 1
		elsif r_akt_zust = c_B1_1 then
			r_start <= '1';
			flag_table(to_integer(addr_proc(8 downto 2))) <= '0';
			addr_mem <= addr_proc;
			addr_mem(1 downto 0) <= "00";
		elsif r_akt_zust = c_B1_4 then
			Cache_Speicher(to_integer(addr_proc(8 downto 2)))(0) <= data_mem_in;
-- Byte 2
		elsif r_akt_zust = c_B2_1 then
			addr_mem(1 downto 0) <= "01";
		elsif r_akt_zust = c_B2_4 then
			Cache_Speicher(to_integer(addr_proc(8 downto 2)))(1) <= data_mem_in;
-- Byte	3	
		elsif r_akt_zust = c_B3_1 then
			addr_mem(1 downto 0) <= "10";
		elsif r_akt_zust = c_B3_4 then
			Cache_Speicher(to_integer(addr_proc(8 downto 2)))(2) <= data_mem_in;
-- Byte 4		
		elsif r_akt_zust = c_B4_1 then
			addr_mem(1 downto 0) <= "11";
		elsif r_akt_zust = c_B4_4 then
			Cache_Speicher(to_integer(addr_proc(8 downto 2)))(3) <= data_mem_in;
			tag_table(to_integer(addr_proc(8 downto 2))) <= addr_proc(15 downto 9) ;
			flag_table(to_integer(addr_proc(8 downto 2))) <= '1';
--			data_proc_out <= Cache_Speicher(to_integer(addr_proc(8 downto 2)))(to_integer(addr_proc(1 downto 0)));
		
		elsif r_akt_zust = idle then
			w_start <= '0';			 
		elsif r_akt_zust = w_miss then 
			addr_mem <= addr_proc;
			data_mem_out <= data_proc_in;
			w_start <= '1';
		
		elsif r_akt_zust = w_hit then
			addr_mem <= addr_proc;
			data_mem_out <= data_proc_in;
			w_start <= '1';
			Cache_Speicher(to_integer(addr_proc(8 downto 2)))(to_integer(addr_proc(1 downto 0))) <= data_proc_in;
			
		elsif r_akt_zust = w_pulse then
			rw_mem <= '0';
		
		elsif r_akt_zust = w_pulse_end then
			rw_mem <= '1';
		
		end if;

	end process;

	
--	- ##############################################################
--	- # Schreiben Prozess						 
--	- idle, w_miss, w_hit, w_pulse, w_pulse_end, w_wait
--	- ##############################################################
--		w_NZ: process (w_akt_zust, rw_start)									  
--	begin	 
--		case w_akt_zust is
--
--			when idle =>
--			if rw_start = '1' and rw_proc='0' and hit = '0' then 
--				r_next_zust <= w_miss;
--			elsif rw_start = '1' and rw_proc='0' and hit = '1' then  
--				w_next_zust <= w_hit;
--			end if ;
--			
--			when w_miss =>
--			w_next_zust <= w_pulse;
--			
--			when w_hit =>
--			w_next_zust <= w_pulse;
--						
--			when w_pulse =>
--			w_next_zust <= w_pulse_end;
--			
--			when w_pulse_end =>
--			w_next_zust <= w_wait;
--			
--			when w_wait =>
--			w_next_zust <= idle;
--			
--			when others => w_next_zust <= idle;
--		end case;
--	end process;			 
--	
--	 Zustandsspeicher Process
--	w_ZS: process (clk)
--	begin
--		if clk'event and clk ='1' then
--			w_akt_zust <= w_next_zust;
--		end if;
--	end process;
--
--	 Ausgangslogik
--	w_AL: process (w_akt_zust)
--	begin
--		if w_akt_zust = idle then
--			w_start <= '0';			 
--		elsif w_akt_zust = w_miss then 
--			addr_mem <= addr_proc;
--			data_mem_out <= data_proc_in;
--			w_start <= '1';
--		
--		elsif w_akt_zust = w_hit then
--			addr_mem <= addr_proc;
--			data_mem_out <= data_proc_in;
--			w_start <= '1';
--			Cache_Speicher(to_integer(addr_proc(8 downto 2)))(to_integer(addr_proc(1 downto 0))) <= data_proc_in;
--			
--		elsif w_akt_zust = w_pulse then
--			rw_mem <= '0';
--		
--		elsif w_akt_zust = w_pulse_end then
--			rw_mem <= '1';
--		
--		end if;
--		
--
--			
--			
--
--	end process;
	
end behave;	  
