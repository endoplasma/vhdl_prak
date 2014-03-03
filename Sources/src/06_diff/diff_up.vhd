entity diff_up is  
	generic (td, tp : TIME:= 0ns); -- td = delay, tp = puls
	port(i : in BIT; o : out BIT);
end diff_up;

architecture behavior of diff_up is
	component not1
		generic (tphl, tplh : TIME:= 0ns);
		port(i1 : in BIT; o : out BIT);
	end component;					   
	
	component and2					   
		generic (tphl, tplh : TIME:= 0ns);
		port(i1, i2 : in BIT; o : out BIT);
	end component;
	
	signal not_to_and : BIT := '0';
begin	 	  
	
	not_1: not1 			   
		generic map (tp, tp)
		port map (i, not_to_and);
	
	and_1: and2 	
		generic map (td, td)
		port map (i, not_to_and, o);	
				
end	behavior;  


architecture behavior_proc of diff_up is
begin	 	  
	process
	begin				   
		wait on i until i ='1' ;
			o <= '1' after td, '0' after td+tp;
	end process;
						
end	behavior_proc;