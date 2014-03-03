-------------------------------------------------------------------------------
--
-- Title       : intro
-- Design      : prakt
-- Author      : it
-- Company     : TU Dortmund
--
-------------------------------------------------------------------------------
--
-- File        : intro.vhd
-- Generated   : Sun Aug 21 16:39:32 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {intro} architecture {intro}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity intro is			
	generic (
		delay: Time := 10ns
	);
	port(
	in1: in BIT;
	out1: out BIT
	);
end intro;

--}} End of automatically maintained section

architecture intro of intro is
begin

	 out1 <= in1 after delay;
end intro;
