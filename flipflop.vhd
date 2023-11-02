
library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop1 is 
port(
	clock_in:in std_logic;
	D:in std_logic;
	Q:out std_logic;
	QNOT:out std_logic
);
end d_flip_flop1;

architecture behavior of d_flip_flop1 is 
begin 
process(clock_in)
begin 
if(clock_in'event and clock_in='1') then
	Q<=D;
	QNOT<= not D;
end if;
end process;
end behavior;