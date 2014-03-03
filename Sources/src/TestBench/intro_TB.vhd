library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity intro_tb is
end intro_tb;

architecture TB_ARCHITECTURE of intro_tb is
	-- Component declaration of the tested unit
	component intro
	generic (
		delay: Time
	);
	port(
		in1 : in BIT;
		out1 : out BIT );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal in1_tb : BIT;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal out1_tb : BIT;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : intro		 
	generic map(
		delay => 40ns
	)
		port map (
			in1 => in1_tb,
			out1 => out1_tb
		);

	-- Add your stimulus here ...
	
	in1_tb <= '1' after 0ns, '0' after 10ns, '1' after 20ns;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_intro of intro_tb is
	for TB_ARCHITECTURE
		for UUT : intro
			use entity work.intro(intro);
		end for;
	end for;
end TESTBENCH_FOR_intro;

