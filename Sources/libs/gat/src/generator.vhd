---------------------------------------------------------------------------------
-- Filename    	: generator.vhd
-- Author      	: Edwin Naroska
-- changed by 	: juergen.kemper@udo.edu
-- Date        	: 128.07.2006
-- Version     	: 1.1
-- Dependency  	: none
-- Target      	: none
-- Description 	: Das Programm erzeugt die Daten fuer die Seriell-Parallel-
--				  Umsetzer. Es werden dafür die Datenpakte "0101", "1101", "1010" 
--				  und "1100" uebertragen. 
-- history			 
--		v1.1 		: Fünftes Datenpaket "1011" hinzugefügt, das
--					  direkt auf das vierte folgt und damit den 
--					  entprechenden Sonderfall überprüft
---------------------------------------------------------------------------------
ENTITY generator IS
	PORT (daten, takt, start : INOUT BIT := '0');
END generator;

ARCHITECTURE behavior OF generator IS
CONSTANT dval : BIT_VECTOR := (
						'0','1','0','1',
					 	'1','1','0','1',
					 	'1','0','1','0',
					 	'1','1','0','0',
						'1','0','1','1');	   			-- weiteres Datum hinzugefügt
				
BEGIN
	start <= 	'0' after 0ns, '1' after 3750 ns,	'0' after 5250ns, '1' after 11750 ns, '0' after 13250 ns,
				'1' after 19750 ns,	'0' after 21250ns, '1' after 24000ns, '0' after 25500 ns,
				'1' after 29000 ns,	'0' after 30500ns;
	
	gen: PROCESS
		VARIABLE index, i, j : INTEGER := 0;
		BEGIN
		FOR j IN 1 TO 5 LOOP							-- 4 zu 5 geändert
			-- Zuerst ein paar Taktsignale erzeugen
			FOR i IN 0 TO 2 LOOP
				takt <= '1' AFTER 500 ns, '0' AFTER 1000 ns;
				WAIT ON takt UNTIL takt = '0';
			END LOOP;
			takt 	<= '1' AFTER 500 ns, '0' AFTER 1000 ns;
--			start 	<= '1' AFTER 750 ns, '0' AFTER 2250 ns;
			WAIT ON takt UNTIL takt = '0';
			-- Jetzt die Daten uebertragen
			FOR i IN 0 TO 3 LOOP
				daten <= dval(index);
				index := index + 1;
				takt <= '1' AFTER 500 ns, '0' AFTER 1000 ns;
				WAIT ON takt UNTIL takt = '0';
			END LOOP;
		END LOOP;
		takt <= '1' AFTER 500 ns, '0' AFTER 1000 ns;
		WAIT;
	END PROCESS;
END behavior;
