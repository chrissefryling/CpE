library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity full_adder is
  port (
    X1  : in std_logic;
    X2 : in std_logic;
    X3 : in std_logic;
    SUM  : out std_logic;
    CARRY: out std_logic
    );
end full_adder;

architecture behavior of full_adder is
begin
o_sum   <= X1 xor X2 xor X3;
 o_carry <= (X1 xor X2) and X3) or (X1 and X2);
end Behavioral;

Part Two: Multiple Ports Code

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder3 is
PORT (
	X1:IN STD_LOGIC_VECTOR(3 downto 0);
	X2:IN STD_LOGIC_VECTOR(3 downto 0);
	F:OUT STD_LOGIC_VECTOR(4 downto 0)
);
END adder3;
ARCHITECTURE behavior OF adder3 IS
SIGNAL C:STD_LOGIC_VECTOR(3 downto 0);
component full_adder
PORT(
    X1  : in std_logic;
    X2 : in std_logic;
    X3 : in std_logic;
    SUM  : out std_logic;
    CARRY : out std_logic
);
end component;


BEGIN
IV1: full_adder port map(X1 => X1(0), X2 => X2(0), X3 => '0', SUM => F(0), CARRY => C(0));
IV2: full_adder port map(X1 => X1(1), X2 => X2(1), X3 => C(0), SUM => F(1), CARRY => C(1));
IV3: full_adder port map(X1 => X1(2), X2 => X2(2), X3 => C(1), SUM => F(2), CARRY => C(2));
IV4: full_adder port map(X1 => X1(3), X2 => X2(3), X3 => C(2), SUM => F(3), CARRY =>

