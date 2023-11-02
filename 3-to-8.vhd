LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decoder1 IS

PORT (
X:IN STD_LOGIC_VECTOR(2 downto 0);
Y:OUT STD_LOGIC_VECTOR(7 downto 0)
);
END decoder1;

ARCHITECTURE behavior OF decoder1 IS
begin

process(X) 
begin

if (X = "000") then
​	Y<= "00000001";
elsif (X = "001") then
​	Y<= "00000010";
elsif (X = "010") then
​	Y<= "00000100";
elsif (X = "011") then
​	Y<= "00001000";
​elsif (X = "100") then
​	Y<= "00010000";
​elsif (X = "101") then
​	Y<= "00100000";
​elsif (X = "110" )then
​	Y<= "01000000";
​else
​	Y<= "10000000";
end if;
end process;
end behavior;