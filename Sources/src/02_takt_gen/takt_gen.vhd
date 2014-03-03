entity takt_gen is
	generic (puls, pause: TIME);
	port (s: in BIT := '1'; o : out BIT);
end takt_gen;

architecture behavior of takt_gen is
-- sigan etc
begin
	process
	begin	 
		o <= '1' and s after 0 ns, '0' after puls;
		wait for puls+pause;
	end process;
end	behavior;

