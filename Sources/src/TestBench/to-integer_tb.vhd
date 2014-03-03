--============================================================
-- Design           : to_integer_test
--
-- Dateiname        : to_integern_test.vhd
--
-- Funktion         : Testbench zum Überprüfen des 
--                    Modells "to_integer"
--
-- Bemerkungen      :
--
-- Fehler           :
--
-- Library          : PRAKT
--
-- Autor            : Edwin Naroska
--=============================================================
ENTITY to_integer_test IS
END to_integer_test;

--======================== ARCHITECTURE =======================
ARCHITECTURE behave OF to_integer_test IS

------------------------------------------------------------
-- Hier muss jetzt die Funktion "to_integer" eingefügt werden
------------------------------------------------------------
function to_integer(constant i : in bit_vector) return integer is
variable result : INTEGER;
	variable i_tmp : BIT_VECTOR(i'length-1 downto 0);
begin
	result := 0;
	i_tmp := i;	   
			for x in 0 to i_tmp'length-1 loop
				if i_tmp(x) = '1' then
					result := result + 2**x ;
				end if;	
			end loop; 					   
		return result;	
end to_integer;
------------------------------------------------------------
------------------------------------------------------------

CONSTANT 	a1 : bit_vector(0 to 7) := "10001111"; -- = 143
CONSTANT 	a2 : bit_vector(0 to 7) := "00001111"; -- = 15
CONSTANT 	a3 : bit_vector(0 to 7) := "01001100"; -- = 76
signal 		input_a : bit_vector(0 to 7) := (others => '0');

CONSTANT    b1 : bit_vector(1 to 16) := "0001111100000011"; -- = 7939
CONSTANT    b2 : bit_vector(1 to 16) := "0001000000000011"; -- = 4099
CONSTANT    b3 : bit_vector(1 to 16) := "0001000011110011"; -- = 4339
signal 		input_b : bit_vector(1 to 16) := (others => '0');

CONSTANT 	c1 : bit_vector(8 downto 1) := "10001111"; -- = 143
CONSTANT 	c2 : bit_vector(8 downto 1) := "00001111"; -- = 15
CONSTANT 	c3 : bit_vector(8 downto 1) := "01001100"; -- = 76
signal 		input_c : bit_vector(8 downto 1) := (others => '0');

SIGNAL		output_a, output_b, output_c : INTEGER := 0;

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
output_a <= to_integer(input_a);
output_b <= to_integer(input_b);
output_c <= to_integer(input_c);

END behave;
