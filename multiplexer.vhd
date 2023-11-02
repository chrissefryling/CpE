library ieee;
use ieee.std_logic_1164.all;

entity partfour is
port(
S1: in std_logic_vector(1 downto 0);
X1: in std_logic_vector(1 downto 0);
F1: out std_logic
);
end partfour;

architecture behavior of partfour is
component multiplexer
port(
S: in std_logic_vector(1 downto 0);
A,B,C,D: in std_logic;
F: out std_logic
);
end component;
begin
addOne: multiplexer port
map(S=>S1, A=>X1(0) and X1(1), B=>X1(0) or X1(1), C=>X1(0), D=>X1(1), F=>F1);
end behavior;

library ieee;
use ieee.std_logic_1164.all;

entity partfour is
port(
S1: in std_logic_vector(1 downto 0);
X1: in std_logic_vector(1 downto 0);
F1: out std_logic
);
end partfour;

architecture behavior of partfour is
component multiplexer
port(
S: in std_logic_vector(1 downto 0);
A,B,C,D: in std_logic;
F: out std_logic
);
end component;
begin
addOne: multiplexer port
map(S=>S1, A=>X1(0) and X1(1), B=>X1(0) or X1(1), C=>X1(0), D=>X1(1), F=>F1);
if (S = "0000") then
F <= "0";
elsif (S = "0001") then
F <= "0";
elsif (S = "0010") then
F <= "0";
elsif (S = "0011") then
F <= "1";
elsif (S = "0100") then
F <= "0";
elsif (S = "0101") then
F <= "1";
elsif (S = "0110") then
F <= "1";
elsif (S = "0111") then
F <= "0";
elsif (S="1000") then
F <= "0";
elsif (S="1001") then
F <= "1";
elsif (S="1010") then
F <= "0";
elsif (S="1011") then
F <= "1";
elsif (S="1100") then
F <= "0";
elsif (S="1101") then
F <= "1";
elsif (S="1110") then
F <= "0";
else
F<= "1";
end if
end behavior;