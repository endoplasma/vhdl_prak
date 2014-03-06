package ram_pack is
	subtype byte is bit_vector(0 to 7);
	--array (0 to 7) of BIT;
	type s_mat is array (NATURAL range <>) of byte;
end ram_pack;

package body ram_pack is
	
end ram_pack;

--#############################################################################################################			
--   		Fehlermeldungen																		  
--##############################################################################################################
--# : WARNING: Zykluszeit wurde nicht eingehalten
--# : Time: 1 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Fehler beim Lesen
--# : Time: 61 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Zykluszeit wurde nicht eingehalten
--# : Time: 160 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Schreib-Impuls zu kurz
--# : Time: 381 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Fehler beim Lesen
--# : Time: 410 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Daten liegen noch nicht lang genug an
--# : Time: 435 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Daten lagen nicht schnell genug an.
--# : Time: 435 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Daten liegen noch nicht lang genug an
--# : Time: 570 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Daten lagen nicht schnell genug an.
--# : Time: 570 ns,  Iteration: 0,  Instance: /Testobject.
--# : WARNING: Fehler beim Lesen
--# : Time: 599 ns,  Iteration: 0,  Instance: /Testobject.
