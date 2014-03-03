entity and2 is				  
	generic (tphl, tplh : TIME:= 0ns);
	port(i1,i2 : in BIT; o : out BIT);
end and2;

architecture behavior of and2 is
begin
	o <= '1' after tplh when i1='1' AND i2='1' else '0' after tphl;
end	behavior;

