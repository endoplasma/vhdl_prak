entity not1 is
	generic (tphl, tplh : TIME:= 0ns);
	port(i1 : in BIT; o : out BIT);
end not1;

architecture behavior of not1 is
begin
	o <= '1' after tplh when i1='0' else '0' after tphl when i1='1';
end	behavior;


