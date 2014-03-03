entity end_reduce_TB is
end end_reduce_TB;

architecture behave of end_reduce_TB is

	component end_reduce
	port(
		i : in BIT_VECTOR;
		result : out BIT);
	end component;
	for all: end_reduce use entity work.end_reduce(behave);

	signal i1: BIT_VECTOR(0 to 0);
	signal i2: BIT_VECTOR(0 to 1);
	signal i3: BIT_VECTOR(0 to 15);
	signal i4: BIT_VECTOR(20 to 27 );
	signal i5: BIT_VECTOR(32 downto 25);
	signal result1 : BIT := '0';
	signal result2 : BIT := '0';
	signal result3 : BIT := '0';
	signal result4 : BIT := '0';
	signal result5 : BIT := '0';
	
	
begin 
	
	end_red_test1: end_reduce
	port map(
		i => i1,
		result => result1
	);

	end_red_test2: end_reduce
	port map(
		i => i2,
		result => result2
	);
	end_red_test3: end_reduce
	port map(
		i => i3,
		result => result3
	);
	end_red_test4: end_reduce
	port map(
		i => i4,
		result => result4
	);
	end_red_test5: end_reduce
	port map(
		i => i5,
		result => result5
	);
	
	i1 <= "0" after 0ns, "1" after 5 ns;
	i2 <= "00" after 0ns, "01" after 5ns, "10" after 10ns, "11" after 15ns;
	i3 <= "0000000000000000" after 0ns, "1100110011001100" after 5ns, "1111111111111110" after 10ns,"1111111111111111" after 15ns;
	i4 <= "00000000" after 0ns, "11111111" after 5ns, "10110110" after 10ns, "10100101" after 15ns;
	i5 <= "00000000" after 0ns, "11111111" after 5ns, "10110110" after 10ns, "10100101" after 15ns;
	
	
end behave;
