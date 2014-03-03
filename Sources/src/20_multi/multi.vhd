entity mult is
	port(a,b : in BIT_VECTOR;
	s: inout BIT_VECTOR);
end mult;

architecture behave of mult is

	component weiss_box
	port(
		a_in : in BIT;
		b_in : in BIT;
		s_in : in BIT;
		c_in : in BIT;
		s_out : out BIT;
		c_out : out BIT;
		a_out : out BIT;
		b_out : out BIT);
	end component; 
	
	for all: weiss_box use entity work.weiss_box(behave);
   
	component grau_box
	port(
		s_in : in BIT;
		c_in : in BIT;
		u_in : in BIT;
		s_out : out BIT;
		u_out : out BIT);
	end component;
	for all: grau_box use entity work.grau_box(behave);

type BitMatrix is array (0 to b'length, 0 to a'length) of BIT;
--type BitMatrix_2 is array (0 to b'length+1, 0 to a'length+1) of BIT;		 
type BitMatrix_2_a is array (0 to b'length, 0 to a'length-1) of BIT;	  
type BitMatrix_2_b is array (0 to b'length-1, 0 to a'length) of BIT;

signal s_int, c_int : BitMatrix := ((others=> (others=>'0')));  --	 
--signal a_int, b_int : BitMatrix_2 := ((others=> (others=>'0')));  
signal a_int : BitMatrix_2_a := ((others=> (others=>'0')));  --  
signal b_int : BitMatrix_2_b := ((others=> (others=>'0')));  --
signal u : BIT_VECTOR(a'length-1 downto 0) := (others=> '0');		  
signal a_tmp : BIT_VECTOR(a'length-1 downto 0);
signal b_tmp : BIT_VECTOR(b'length-1 downto 0);	 
signal s_tmp : BIT_VECTOR(s'length-1 downto 0);	  


begin 
	
	-- Weiss box generate
	a_tmp<=a;
	b_tmp<=b;
	s<=s_tmp;
	a_map: for i in 0 to a_tmp'length-1 generate
		a_int(0,i) <= a_tmp(i);
	end generate a_map;
	b_map: for i in 0 to b_tmp'length-1 generate
		 b_int(i,a_tmp'length) <= b_tmp(i);
	end generate b_map;   
	
	spalten: for i in 0 to b_tmp'length-1 generate 
		zeilen: for j in 0 to a_tmp'length-1 generate
			weiss : weiss_box
			port map(
				a_in => a_int(i,j),  
				--b_in => b_int(i,j),	
				b_in => b_int(i,j+1),
				s_in => s_int(i,j+1),
				c_in => c_int(i,j),
				s_out => s_int(i+1,j),
				c_out => c_int(i+1,j),
				a_out => a_int(i+1,j),
				--b_out => b_int(i,j+1), 
				b_out => b_int(i,j)
			); 
		end generate zeilen;
	end generate spalten;
	
	grau_gen: for i in 0 to a_tmp'length-2 generate
		grau : grau_box
		port map(
			s_in => s_int(b_tmp'length,i+1),
			c_in => c_int(b_tmp'length,i),
			u_in => u(i),
			s_out => s_tmp(b_tmp'length+i),
			u_out => u(i+1)
		);
	end generate grau_gen;
	
	-- ausgägnge mappen
	s_tmp(b_tmp'length+a_tmp'length-1) <= u(u'length-1);
	
	sig_map: for i in 1 to b_tmp'length generate
		s_tmp(i-1) <= s_int(i,0);
	end generate sig_map;
	

	
end behave;

		