entity or2 is	 
	generic (tphl, tplh : TIME:= 0ns);
	port(i1, i2 : in BIT; o : out BIT);
end or2;

architecture behavior of or2 is
begin	
	o <= '1' after tplh when i1='1' OR i2='1' else '0' after tphl;
end	behavior;

