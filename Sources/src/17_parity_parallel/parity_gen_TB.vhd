entity parity_gen_TB is
end parity_gen_TB;

architecture behave of parity_gen_TB is

	component parity_gen
	port(
		d : in BIT_VECTOR;
		s : in BIT;
		p : out BIT);
	end component;
	for all: parity_gen use entity work.parity_gen(behave);


	signal i2: BIT_VECTOR(0 to 1);
	signal i3: BIT_VECTOR(0 to 15);
	signal i4: BIT_VECTOR(20 to 27 );
	signal i5: BIT_VECTOR(32 downto 25);

	signal result2 : BIT := '0';
	signal result3 : BIT := '0';
	signal result4 : BIT := '0';
	signal result5 : BIT := '0';
	
	signal s : BIT := '0';
	
begin
	
	par1 : parity_gen
	port map(
		d => i2,
		s => s,
		p => result2
	);
	
		par2 : parity_gen
	port map(
		d => i3,
		s => s,
		p => result3
	);
	
		par3 : parity_gen
	port map(
		d => i4,
		s => s,
		p => result4
	);
	
		par4 : parity_gen
	port map(
		d => i5,
		s => s,
		p => result5
	);
	
	s <= '0' after 0ns, '1' after 2500 ns, '0' after 5000 ns, '1' after 7500 ns, '0' after 10000 ns, '1' after 12500 ns, '0' after 15000 ns, '1' after 17500 ns, '0' after 20000 ns;
	
	i2 <= "00" after 0us, "01" after 5us, "10" after 10us, "11" after 15us;
	i3 <= "0000000000000000" after 0us, "1100110011001100" after 5us, "1111111111111110" after 10us,"1111111111111111" after 15us;
	i4 <= "00000000" after 0us, "11111111" after 5us, "10110110" after 10us, "10100101" after 15us;
	i5 <= "00000000" after 0us, "11111111" after 5us, "10110110" after 10us, "10100101" after 15us;
	
	
end behave;
