-- Filename    	: ram_tb.vhd
-- Author      	: juergen.kemper@udo.edu
-- Date        	: 01.10.2002
-- Version     	: 1.0
-- Dependency  	: ram_pack
-- Target      	: none
---------------------------------------------------------------------------------
-- Description 	: Testbench für RAM-Baustein
-- Generics    	: none
---------------------------------------------------------------------------------
use ram_pack.all;
	
entity ram_test is
end ram_test;

architecture structure of ram_test is 
component ram
	generic (adr_breite:	Integer:=4);
	port (	adr:			in BIT_VECTOR(0 to adr_breite-1); 
			din:			in byte;
			do: 			out byte;
			read: 			in BIT);
end component;
Signal adresse:		BIT_VECTOR(0 to 3);
signal din,do:		Byte;				  
signal read:		BIT:='1';
begin
Testobject: ram
	port map(
		adr		=> Adresse,
		din		=> din,
		do		=> do,
		read	=> read
	);

Adresse <= "0000" after 0 ns, "1000" after 1 ns, "0001" after 150ns,"1000" after 160ns,"0101" after 350ns,
			"1000" after 539ns,"0000" after 700ns;
din 	<=	"00000000" after 0 ns,"00000001" after 5 ns, "01010000" after 150ns,
			"01010101" after 300ns, "01010111" after 365ns,
			"10000001" after 430ns,
			"11110000" after 560 ns;
read	<=	'1' after 0 ns, '0' after 20 ns, '1'after 31 ns,
			'0' after 360 ns,'1' after 381 ns,
			'0' after 435 ns,'1' after 446 ns,
			'0' after 570 ns,'1' after 581 ns;	  
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
end structure;