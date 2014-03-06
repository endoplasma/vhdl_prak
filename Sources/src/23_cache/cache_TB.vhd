use ram_pack.all;
use numeric_conv.all;

entity cache_TB is
end cache_TB;

architecture behave of cache_TB is 

	component cache
	port(
		clk : in BIT;
		addr_proc : in BIT_VECTOR(15 downto 0);
		data_proc_in : in BIT_VECTOR(7 downto 0);
		data_proc_out : out BIT_VECTOR(7 downto 0);
		request : in BIT;
		rw_proc : in BIT;
		delay : out BIT;
		addr_mem : out BIT_VECTOR(15 downto 0);
		data_mem_in : in BIT_VECTOR(7 downto 0);
		data_mem_out : out BIT_VECTOR(7 downto 0);
		rw_mem : out BIT);
	end component;
	for all: cache use entity work.cache(behave);


	component ram
	generic(
		adr_breite : INTEGER);
	port(
		adr : in BIT_VECTOR(0 to adr_breite-1);
		din : in byte;
		do : out byte;
		read : in BIT);
	end component;
	for all: ram use entity work.ram(behave);


	component takt_gen
	generic(
		puls : TIME;
		pause : TIME);
	port(
		s : in BIT;
		o : out BIT);
	end component;
	for all: takt_gen use entity work.takt_gen(behavior);
	
		
	signal clk : BIT;
	signal sel : BIT;
	signal delay,request,rw_proc : BIT;
	signal addr_proc :  BIT_VECTOR(15 downto 0);
	signal data_proc_in :  BIT_VECTOR(7 downto 0);
	signal data_proc_out :  BIT_VECTOR(7 downto 0);
	signal addr_mem :  BIT_VECTOR(15 downto 0);
	signal data_mem_in : BIT_VECTOR(7 downto 0);
	signal data_mem_out : BIT_VECTOR(7 downto 0);
	signal rw_mem :  BIT;
	
		
begin
	
	
	takt_1 : takt_gen
	generic map(25ns,25ns)
	port map(
		s => sel,
		o => clk
	);
	
	memory : ram
	generic map(
		adr_breite => 16
	)
	port map(
		adr => addr_mem,
		din => data_mem_out,
		do => data_mem_in,
		read => rw_mem
	);
	
	
	cacheBaustein : cache
	port map(
		clk => clk,
		addr_proc => addr_proc,
		data_proc_in => data_proc_in,
		data_proc_out => data_proc_out,
		request => request,
		rw_proc => rw_proc,
		delay => delay,
		addr_mem => addr_mem,
		data_mem_in => data_mem_in,
		data_mem_out => data_mem_out,
		rw_mem => rw_mem
	);
	

	request <= '0' after 0ns, '1' after 65 ns, '0' after 100ns;
	rw_proc <= '1' after 0ns, '0' after 65 ns;
	addr_proc <= "0100001000101001" after 0ns; 
	data_proc_in <= "01010101" after 0ns, "10101010" after 0ns;
	
	sel <= '1' after 0ns;
	
	
	
end behave;
