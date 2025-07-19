library ieee;
use ieee.std_logic_1164.all;

entity Energy_Monitor is
	port(
		vacation_mode, MC_test_mode, window_open, door_open, AGTB, AEQB, ALTB : in std_logic;
		furnace, at_temp, AC, blower, window, door, vacation, decrease, increase, run : out std_logic
	);
end entity Energy_Monitor;

architecture Energy_Monitor_arch of Energy_Monitor is
begin

run <= (MC_test_mode OR window_open OR door_open) NOR AEQB;
increase <= AGTB;
decrease <= ALTB;
vacation <= vacation_mode;
door <= door_open;
window <= window_open;
AC <= ALTB;
furnace <= AGTB;
at_temp <= AEQB;
blower <= (MC_test_mode OR window_open OR door_open) NOR AEQB;

end Energy_Monitor_arch;