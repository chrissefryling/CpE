library ieee;
use ieee.std_logic_1164.all;
entity exp2lab9 is
port(
	x:in std_logic;
	clock:in std_logic;
	y1: inout std_logic;
	y2: inout std_logic;
	z: out std_logic
);
end exp2lab9;
architecture behavior of exp2lab9 is
signal D: std_logic_vector(2 downto 1);
signal zin: std_logic;
component DFFslow
port(
clk_in: in std_logic;
din: in std_logic;
qout: out std_logic;
qout_not: out std_logic
);
end component;
begin
D(2) <= ((not x) and y1) or (y2 and y1);
D(1) <= (y2 and (not y1));
zin <= (not x and not y1) or (x and y2);
D1FF: DFFslow port map (din=>D(1), clk_in=>clock, qout=>y1);
D2FF: Dffslow port map (din=>D(2), clk_in=>clock, qout=>y2);
D3FF: Dffslow port map (din=>zin, clk_in=>clock, qout=>z);
end behavior;
