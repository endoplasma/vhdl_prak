entity gatter_tb is	
end gatter_tb;


architecture behavior of gatter_tb is
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
	component xor2					  
		generic (tphl, tplh : TIME:= 0ns);
		port(i1, i2 : in BIT; o : out BIT);
	end component;					  
	component xor2_s					  
		generic (tphl, tplh : TIME:= 0ns);
		port(i1, i2 : in BIT; o : out BIT);
	end component;
	signal input1, input2, out_not, out_and2, out_or2, out_xor2, out_xor2_s : BIT :='0';
begin
	testobj_not1: not1 			   
		generic map (2 ns, 1ns)
		port map (input1, out_not);
	
	testob_and2: and2 	
		generic map (2 ns, 1ns)
		port map (input1, input2, out_and2);	
	
	testob_or2: or2
		generic map (2 ns, 1ns)
		port map (input1, input2, out_or2);	
	
	testob_xor2: xor2 
		generic map (3 ns, 3ns)
		port map (input1, input2, out_xor2);
		
	testob_xor2_s: xor2_s 
		generic map (1 ns, 1ns)
		port map (input1, input2, out_xor2_s);
	
	input1 <= '0' after 0 ns, '1' after 5 ns, '0' after 35 ns, '1' after 55 ns, '0' after 70 ns, '1' after 80 ns, '0' after 85 ns, '1' after 90 ns, '0' after 95 ns, '1' after 100 ns;
	input2 <= '1' after 0 ns, '0' after 15 ns, '1' after 20 ns, '0' after 40 ns, '1' after 50 ns, '0' after 60 ns, '1' after 70 ns, '0' after 75 ns, '1' after 80 ns, '0' after 90 ns, '1' after 100 ns, '0' after 105 ns;
end behavior;
	
		