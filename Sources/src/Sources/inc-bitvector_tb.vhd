--============================================================
-- Design           : inc_bit_vector_test
--
-- Dateiname        : inc-bitvector-tb.vhd
--
-- Funktion         : Testbench zum Überprüfen der Funktion
--                    "inc_bit_vector"
--
-- Bemerkungen      :
--
-- Fehler           :
--
-- Library          : PRAKT
--
-- Autor            : Edwin Naroska
--=============================================================
ENTITY inc_bit_vector_test IS
END inc_bit_vector_test;

--======================== ARCHITECTURE =======================
ARCHITECTURE behave OF inc_bit_vector_test IS

------------------------------------------------------------
-- Hier muss jetzt die Funktion "inc_bit_vector" eingefügt werden
------------------------------------------------------------
function inc_bit_vector(constant i : in bit_vector) return bit_vector is	 
	variable result : BIT_VECTOR(0 to i'length-1);
	variable x : INTEGER;
		begin
			result := i; 
			x := result'length-1;
			while x > 0  and result(x) /= '0' loop
				result(x) := '0';
				x := x-1; 
			end loop;
			result(x) := not result(x);
			
			if x =0 and result(x)='0' then
				result := i;
			end if;
			return result;
end inc_bit_vector;
------------------------------------------------------------
------------------------------------------------------------

CONSTANT 	a1 : bit_vector(0 to 7) := "10001111"; -- = 143
CONSTANT 	a2 : bit_vector(0 to 7) := "00001111"; -- = 15
CONSTANT 	a3 : bit_vector(0 to 7) := "11111111"; -- = 76
signal 		input_a, output_a : bit_vector(0 to 7) := (others => '0');

CONSTANT    b1 : bit_vector(1 to 16) := "0001111100000011"; -- = 7939
CONSTANT    b2 : bit_vector(1 to 16) := "0001000000000011"; -- = 4099
CONSTANT    b3 : bit_vector(1 to 16) := "0001000011110011"; -- = 4339
signal 		input_b, output_b : bit_vector(1 to 16) := (others => '0');

CONSTANT 	c1 : bit_vector(8 downto 1) := "10001111"; -- = 143
CONSTANT 	c2 : bit_vector(8 downto 1) := "00001111"; -- = 15
CONSTANT 	c3 : bit_vector(8 downto 1) := "01001100"; -- = 76
signal 		input_c, output_c : bit_vector(8 downto 1) := (others => '0');

BEGIN

---------------------------------------------------------------
-- Die Eingangsstimuli erzeugen
---------------------------------------------------------------
input_a <= a1 after 100 ns, a2 after 200 ns, a3 after 300 ns;
input_b <= b1 after 100 ns, b2 after 200 ns, b3 after 300 ns;
input_c <= c1 after 100 ns, c2 after 200 ns, c3 after 300 ns;

---------------------------------------------------------------
-- Die Funktion testen!
---------------------------------------------------------------
output_a <= inc_bit_vector(input_a);
output_b <= inc_bit_vector(input_b);
output_c <= inc_bit_vector(input_c);

END behave;
