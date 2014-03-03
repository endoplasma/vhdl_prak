entity mult_pipe is
	port(
		a,b : in BIT_VECTOR;
		s: inout BIT_VECTOR;
		takt : in BIT);
end mult_pipe;

architecture behave of mult_pipe is

	component weiss_box_pipe
	port(
		a_in : in BIT;
		b_in : in BIT;
		s_in : in BIT;
		c_in : in BIT;
		s_out : out BIT;
		c_out : out BIT;
		a_out : out BIT;
		b_out : out BIT;
		takt : in BIT);
	end component;
	for all: weiss_box_pipe use entity work.weiss_box_pipe(behave);


	component grau_box_pipe
	generic(
		delay_in : INTEGER);
	port(
		s_in : in BIT;
		c_in : in BIT;
		u_in : in BIT;
		s_out : out BIT;
		u_out : out BIT;
		takt : in BIT);
	end component;
	for all: grau_box_pipe use entity work.grau_box_pipe(behave);

	component s_reg_pipe
	generic(
		breite : INTEGER);
	port(
		i : in BIT;
		takt : in BIT;
		o : out BIT);
	end component;
	for all: s_reg_pipe use entity work.s_reg_pipe(behave);


type BitMatrix is array (0 to b'length, 0 to a'length) of BIT;
type BitMatrix_2_a is array (0 to b'length, 0 to a'length-1) of BIT;	  
type BitMatrix_2_b is array (0 to b'length-1, 0 to a'length) of BIT;

signal s_int, c_int : BitMatrix := ((others=> (others=>'0')));  --	 
signal a_int : BitMatrix_2_a := ((others=> (others=>'0')));  --  
signal b_int : BitMatrix_2_b := ((others=> (others=>'0')));  --
signal u : BIT_VECTOR(a'length-1 downto 0) := (others=> '0');		  
signal a_tmp : BIT_VECTOR(a'length-1 downto 0);
signal b_tmp : BIT_VECTOR(b'length-1 downto 0);	 
signal s_tmp : BIT_VECTOR(s'length-1 downto 0);	
signal s_tmp_delay : BIT_VECTOR(s'length-1 downto 0);	

begin 
	
	-- Weiss box generate
	a_tmp<=a;
	b_tmp<=b;
	s<=s_tmp_delay;
	
	a_map: for i in 0 to a_tmp'length-1 generate
		s_reg_a_map : s_reg_pipe
		generic map(
			breite => a_tmp'length-i
		)
		port map(
			i => a_tmp(i),
			takt => takt,
			o => a_int(0,i)
		);
		--a_int(0,i) <= a_tmp(i);
	end generate a_map;
	
	b_map: for i in 0 to b_tmp'length-1 generate
		s_reg_b_map : s_reg_pipe
		generic map(
			breite => i+1
		)
		port map(
			i => b_tmp(i),
			takt => takt,
			o => b_int(i,a_tmp'length)
		);
		--b_int(i,0) <= b_tmp(i);
	end generate b_map;   
	
	spalten: for i in 0 to b_tmp'length-1 generate 
		zeilen: for j in 0 to a_tmp'length-1 generate
			weiss : weiss_box_pipe
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
				b_out => b_int(i,j),
				takt => takt
			); 
		end generate zeilen;
		
	
	end generate spalten;
	
	grau_gen: for i in 0 to a_tmp'length-2 generate
		
		grau : grau_box_pipe
		generic map(
			i
			)
		port map(
			s_in => s_int(b_tmp'length,i+1),
			c_in => c_int(b_tmp'length,i),
			u_in => u(i),
			s_out => s_tmp(b_tmp'length+i),
			u_out => u(i+1),
			takt => takt
		);
	end generate grau_gen;
	
	-- ausgägnge mappen
	s_tmp(b_tmp'length+a_tmp'length-1) <= u(u'length-1); --fertig
	
	sig_map: for i in 1 to b_tmp'length generate
		s_tmp(i-1) <= s_int(i,0);
	end generate sig_map; 
	
	output_delay: for i in 0 to s_tmp'length-1 generate
		lower_map: if i < b_tmp'length generate 
			s_reg_b : s_reg_pipe
			generic map(
				breite => (2*a'length+b'length-1)-(a'length+i+2)
			)
			port map(
				i => s_tmp(i),
				takt => takt,
				o => s_tmp_delay(i)
			);
		end generate lower_map;
		
		upper_map: if i >= b_tmp'length generate 
			s_reg_a : s_reg_pipe
			generic map(
				breite => a'length+b'length-1-i
			)
			port map(
				i => s_tmp(i),
				takt => takt,
				o => s_tmp_delay(i)
			);
		end generate upper_map;
		
		
	end generate output_delay;

	
end behave;

		