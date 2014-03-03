entity dt_b is
	port (
	d,t : in BIT;
	q : out BIT := '0';
	qn : out BIT := '1');
end dt_b; 

architecture behave of dt_b is	  
signal outmaster : BIT;
begin		   
	
	master: process
	begin
		
		wait on t until t = '1';
		outmaster <= d;
			
			
	end process;

	slave: process
	begin	 
		wait on t until t = '0';
		q <= outmaster;
		qn <= NOT outmaster;
	end process;
	
end	behave;
