entity diff_up_tb is
end diff_up_tb;

architecture behave of diff_up_tb is
--component diff_up
--	generic (td , tp : TIME := 0ns);
--	port(i : in BIT; o : out BIT);
--end component ;	

	component diff_up
	generic(
		td : TIME := 0 ns;
		tp : TIME := 0 ns);
	port(
		i : in BIT;
		o : out BIT);
	end component;
	for all: diff_up use entity work.diff_up(behavior);

signal input, output : BIT := '0';

begin

	diff1: diff_up
		generic map (2ns , 5ns)
		port map(input, output);
		
	input <= '0' after 0 ns, '1' after 1 ns, '0' after 2 ns, '1' after 4 ns, '0' after 70 ns, '1' after 80 ns, '0' after 85 ns, '1' after 90 ns, '0' after 95 ns, '1' after 100 ns;
	
end  behave;


