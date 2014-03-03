--============================================================
-- Desing           : NOR2
--
-- Dateiname        : NOR2.vhd
--
-- Funktion         : Logisches "NOR" fuer zwei Bit-Werte.
--                    Die Verzeogerungszeiten fuer die Flanken
--                    des Ausgangssignals koennen angegeben 
--                    werden.
--
-- Bemerkungen      :
--
-- Fehler           :
--
-- Library          : GAT
--
-- Autor            : Edwin Naroska
--=============================================================
ENTITY nor2 IS
	GENERIC (tphl, tplh : TIME := 0 ns);
	PORT (i1, i2 : IN BIT; o : OUT BIT);
END nor2;

--======================== ARCHITECTURE =======================
ARCHITECTURE behave OF nor2 IS
SIGNAL		old_o : BIT; -- Ein internes Signal
BEGIN

---------------------------------------------------------------
-- Ein Prozess, der sensitiv auf die Signale i1 und i2 ist
---------------------------------------------------------------
PROCESS (i1, i2)
VARIABLE	old_o, new_o : BIT := '0';
BEGIN
	-- Zunaechst den Wert der Verknuepfung berechnen
	new_o := i1 NOR i2;
	-- Wenn der aktuelle und der alte Wert ungleich sind...
	IF new_o /= old_o THEN
		IF new_o = '1' THEN	-- steigende Flanke
			o <= '1' AFTER tplh;
			old_o := '1';
		ELSE			-- fallende Flanke
			o <= '0' AFTER tphl;
			old_o := '0';
		END IF;
	END IF;
END PROCESS;

END behave;
