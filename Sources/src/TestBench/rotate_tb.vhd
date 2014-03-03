--============================================================
-- Design           : rotate_test
--
-- Dateiname        : rotate_tb.vhd
--
-- Funktion         : Testbench zum Überprüfen des Rotierbaustein-
--                    Modells "rotate"
--
-- Bemerkungen      :
--
-- Fehler           :
--
-- Library          : PRAKT
--
-- Autor            : Edwin Naroska
--=============================================================
LIBRARY GAT;
USE GAT.ALL;

ENTITY rotate_test IS
END rotate_test;

--======================== ARCHITECTURE =======================
USE WORK.ALL; -- Das zu testende Modell und den Taktgenerator 
              -- sichtbar machen
ARCHITECTURE behave OF rotate_test IS

  COMPONENT takt_gen
    GENERIC (puls, pause: TIME);
    PORT (s : IN BIT := '1'; o : OUT BIT);
  END COMPONENT;

  COMPONENT rotate
    PORT (direction : in integer; i : in bit_vector;
		  o : out bit_vector; takt : in bit);
  END COMPONENT;

  SIGNAL        control : BIT := '1';
  SIGNAL        takt : BIT := '0';
  SIGNAL 		dir : integer := 0;
  SIGNAL		input, output : bit_vector(0 to 7) := (others => '0');
BEGIN

---------------------------------------------------------------
-- Der Taktgenerator
---------------------------------------------------------------
tgen: takt_gen
	GENERIC MAP (puls => 10 ns, pause => 10 ns)
	PORT MAP (s => control, o => takt);

control <= '1', '0' AFTER 1000 ns;

---------------------------------------------------------------
-- Das zu testende Modell
---------------------------------------------------------------
testobjekt: rotate
	PORT MAP (direction => dir, i => input, o => output, takt => takt);

---------------------------------------------------------------
-- Die Eingangsstimuli erzeugen
---------------------------------------------------------------
input <= "10101010", "00001111" AFTER 105 ns, "11000011" AFTER 205 ns,
		 "00100111" AFTER 405 ns;
		 
dir <= 0, 1 AFTER 25 ns, 2 AFTER 45 ns, -3 AFTER 65 ns, 0 AFTER 85 ns,
	   1 AFTER 105 ns, 2 AFTER 125 ns, -3 AFTER 145 ns, 0 AFTER 165 ns,
	   4 AFTER 185 ns, 2 AFTER 205 ns, -3 AFTER 225 ns, 0 AFTER 245 ns,
	   3 AFTER 305 ns, 2 AFTER 325 ns, -3 AFTER 345 ns, 0 AFTER 405 ns,
	   3 AFTER 425 ns, -2 AFTER 445 ns;

END behave;
