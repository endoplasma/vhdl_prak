package numeric_conv is
	function to_integer( constant i: in BIT_VECTOR) return INTEGER;
end package;

package body numeric_conv is

function to_integer( constant i: in BIT_VECTOR) return INTEGER is
	variable result : INTEGER;
	--signal tmp_vec : BIT_VECTOR( 0 to i'length-1);
	begin
		result := 0;
		for x in i'left to i'right loop
			if i(x) = '1' then
				result := result + 1 ;
				result := result * 2;
			end if;
		end loop; 
		return result;
	end to_integer;
end numeric_conv;
