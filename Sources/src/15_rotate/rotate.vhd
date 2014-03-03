entity rotate is
    PORT (direction : in integer;
		i : in bit_vector;
		o : out bit_vector; 
		takt : in bit);
END rotate;

architecture behave of rotate is
signal shift : INTEGER := 0;
signal in_tmp, out_tmp : BIT_VECTOR(0 to i'length-1);
begin
	shift <= direction mod i'length;
	in_tmp <= i;
	
	p1: process
	begin
		wait on takt until takt='0';
		for x in 0 to i'length-1 loop
			out_tmp((x-shift) mod i'length) <= in_tmp(x);
		end loop;	
		
	end process; 
	o <= out_tmp;
end behave;
