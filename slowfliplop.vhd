library ieee;
use ieee.std_logic_1164.all;
entity modulo8_c is
port(
	CLK: in std_logic;
	X: in std_logic;
	Q: inout std_logic_vector(2 downto 0)
);
end modulo8_c;

architecture behavior of modulo8_c is
signal D : std_logic_vector(2 downto 0);
component slow_flip_flop
port(
	newD:in std_logic;
	newclock_in: in std_logic;
	newQ: out std_logic;
	newQNOT: out std_logic
);
end component;

begin
D(0)<= not Q(0);
D(1)<=(not X and not Q(1) and Q(0)) or (X and not Q(1) and not Q(0)) or (X and Q(1) and Q(0)) or(not X and Q(1) and not Q(0));
D(2)<=(not X and not Q(2) and Q(1) and Q(0)) or (X and not Q(2)and not Q(1) and not Q(0)) or (not X and Q(2) and not Q(1)) or (X and Q(2) and Q(0)) or (Q(2) and Q(1)and not Q(0));
map1: slow_flip_flop port map(newD => D(0),newclock_in => CLK, newQ => Q(0) );
map2: slow_flip_flop port map(newD => D(1),newclock_in => CLK, newQ => Q(1));
map3: slow_flip_flop port map(newD => D(2),newclock_in => CLK, newQ => Q(2));
end behavior;