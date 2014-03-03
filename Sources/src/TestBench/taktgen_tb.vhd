--============================================================
-- Design           : takt_gen_test
--
-- Dateiname        : taktgen_tb.vhd
--
-- Funktion         : Testbench zum Überprüfen des Taktgenerator-
--                    Modells "takt_gen"
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

ENTITY takt_gen_test IS
END takt_gen_test;

--======================== ARCHITECTURE =======================
USE WORK.ALL; -- Das zu testende Modell sichtbar machen
ARCHITECTURE behave OF takt_gen_test IS

  COMPONENT takt_gen
    GENERIC (puls, pause: TIME);
    PORT (s : IN BIT := '1'; o : OUT BIT);
  END COMPONENT;

SIGNAL		control, outsig : BIT; -- Drei interne Signale
BEGIN

---------------------------------------------------------------
-- Das zu testende Modell
---------------------------------------------------------------
testobjekt: takt_gen
	GENERIC MAP (puls => 10 ns, pause => 20 ns)
	PORT MAP (s => control, o => outsig);

---------------------------------------------------------------
-- Die Eingangsstimuli erzeugen
---------------------------------------------------------------
control <= '1' AFTER 100 ns, '0' AFTER 400 ns, '1' AFTER 500 ns, 
	'0' AFTER 1000 ns;

END behave;
