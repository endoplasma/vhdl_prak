entity barrel4 is
port(
	i0, i1, i2, i3 : in BIT;
	q0, q1, q2, q3 : out BIT;
	shift : in INTEGER
	);
end barrel4;

architecture behave of barrel4 is
signal shifter : INTEGER;
begin
	shifter <= shift mod 4;
	with shifter select
		q0 <= 	i0 when 0,
				i1 when 1,
				i2 when 2,
				i3 when others;
				
	with shifter select			
		q1 <= 	i1 when 0,
				i2 when 1,
				i3 when 2,
				i0 when others;
	with shifter select			
		q2 <= 	i2 when 0,
				i3 when 1,
				i0 when 2,
				i1 when others;
				
	with shifter select
		q3 <= 	i3 when 0,
				i0 when 1,
				i1 when 2,
				i2 when others;
		
		
end behave;
	