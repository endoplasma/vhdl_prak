entity xor2_s is  
	generic (tphl, tplh : TIME:= 0ns);
	port(i1, i2 : in BIT; o : out BIT);
end xor2_s;

architecture behavior of xor2_s is
	component not1
		generic (tphl, tplh : TIME:= 0ns);
		port(i1 : in BIT; o : out BIT);
	end component;					   
	
	component and2					   
		generic (tphl, tplh : TIME:= 0ns);
		port(i1, i2 : in BIT; o : out BIT);
	end component;
	
	component or2						  
		generic (tphl, tplh : TIME:= 0ns);
		port(i1, i2 : in BIT; o : out BIT);
	end component;	
	
	signal n1_to_a1, n2_to_a2, a1_to_or, a2_to_or : BIT := '0';
begin	 	  
	
	not_in_1: not1 			   
		generic map (tphl, tplh)
		port map (i1, n1_to_a1);
	not_in_2: not1 			   
		generic map (tphl, tplh)
		port map (i2, n2_to_a2);
			
	and_1: and2 	
		generic map (tphl, tplh)
		port map (n1_to_a1, i2, a1_to_or);	
	and_2: and2 	
		generic map (tphl, tplh)
		port map (n2_to_a2, i1, a2_to_or);	
	
	or_gat: or2
		generic map (tphl, tplh)
		port map (a1_to_or, a2_to_or, o);	   
			
end	behavior;