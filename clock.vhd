
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity clk_slow is

PORT(
clkDivi : in std_logic;
clkDivo: out std_logic
);
end clk_slow;

architecture behavior of clk_slow is
signal clock_tmp: std_logic;
begin

process(clkDivi)
variable x : integer := 0;
begin
if(clkDivi'event and clkDivi='1') then

    x:=x+1;
    if x=50000000 then
        x:=0;
        clock_tmp<= not clock_tmp;
        clkDivo<= clock_tmp;
    end if;
end if;
end process;
end behavior;