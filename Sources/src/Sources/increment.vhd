package numeric_conv is
	function inc_1( constant i: in BIT_VECTOR) return BIT_VECTOR;
end package;

package body numeric_conv is

	function inc_1( constant i: in BIT_VECTOR) return BIT_VECTOR is
	variable result : BIT_VECTOR(0 to i'length-1);
	variable x : INTEGER;
		begin
			result := i; 
			x := result'length-1;
			while result(x) /= '0' or x >= 0 loop
				result(x) := not result(x);
				x := x-1; 
			end loop;
			
			if x =0 and result(x)='0' then
				result := i;
			end if;
			return result;
		end inc_1;
end numeric_conv;
