entity transport_test is
end transport_test;

architecture behave of transport_test  is
signal s : INTEGER := 0;
begin
	p1: process
	begin  
		s <=  transport 1 after 10ns, 3 after 20ns;
		s <=  2 after 20ns, 4 after 40ns;
		s <= transport 3 after 30ns, 4 after 50ns;
		wait for 100ns;
	end process;
end behave;
