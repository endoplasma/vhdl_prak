---------------------------------------------------------------------------------
-- Filename    	: intsort_proc.vhd
-- Author      	: juergen.kemper@udo.edu
-- Date        	: 14.06.2006
-- Version     	: 1.0
-- Dependency  	: none
-- Target      	: none
---------------------------------------------------------------------------------
-- Description 	: Testbench der Integer-Sortier-Funktion
-- Generics    	: none
---------------------------------------------------------------------------------	


ENTITY intsort_proc IS
END intsort_proc;

--======================== ARCHITECTURE =======================
ARCHITECTURE behave OF intsort_proc IS
	type int_vector is array (positive range <>) of Integer;
	signal test	: int_vector(1 to 20); 
	
	function min (a,b : INTEGER) return INTEGER is
	begin
		if a<b then return a;
		else
			return b;
		end if;
	end min;
	
	
	
	procedure merge (a : inout int_vector; start_1, end_1, start_2, end_2 : INTEGER) is
	variable temp : int_vector(1 to end_1 - start_1 + end_2 - start_2 + 2);
	variable i,j,x : integer;
	begin
		i:=start_1;
		j:=start_2;	 
		x:=1;
		while i<= end_1 and j<= end_2 loop
			if a(i) > a(j) then
				temp(x):=a(j);
				x := x+1;
				j:= j+1;
			elsif a(i) < a(j) then
				temp(x):=a(i);
				x := x+1;
				i:= i+1;	
			else
				temp(x):=a(i);
				x := x+1;
				i:= i+1;	
				temp(x):=a(j);
				x := x+1;
				j:= j+1;
			end if;
		end loop;
				
		while i<= end_1 loop
			temp(x):=a(i);
			x := x+1;
			i:=i+1;
		end loop;
		
		while j<= end_2 loop
			temp(x):=a(j);
			x := x+1;
			j:= j+1;
		end loop;
			
		a(start_1 to end_2) := temp;
		
	end merge;
	
	
	procedure sort(variable i: inout int_vector) is
	variable m,n,j : INTEGER;
	variable i2 : int_vector(1 to i'length);
	begin
		i2 := i;
		m:=1;
		n:=i2'length;
		while m <= n loop
			j:=1;
			while j <= n-m loop
				merge(i2,j,j+m-1,j+m,min(j+2*m-1,n));
				j:=j+2*m;
			end loop;
		m := m*2;
		end loop;
		
		i:=i2;
	end sort;

BEGIN  
	-- Testvektor
	test  <= (1,5,3,7,2,10,23,74,1,7,9,345,34,2,23,72,13,16,37,50); 
	
	process(test)	   
		variable test_cp	: int_vector(1 to test'length);
	Begin
		-- Für den Aufruf wird eine Variable benötigt
		-- Nur die Variable wird sortiert, nicht "test";
		test_cp	:= test;
		sort(test_cp);
	end process;
END behave;
