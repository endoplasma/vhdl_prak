entity pmodell is
end pmodell;

architecture behave of pmodell is
signal  a,b : INTEGER := 0;
begin
	p1:process
	begin 
		a <= a+1 after 15ns;
		wait on a,b;
		a <= a-1 after 20ns;
		wait on b;
	end process;
	
	p2:process
	begin
		wait on a;
		b <= a + 10 after 5 ns;
		wait on b;
	end process;
end behave;
