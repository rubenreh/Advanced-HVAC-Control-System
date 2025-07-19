--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
--entity Compx1 is port (
--
--           input_A : in std_logic;
--           input_B : in std_logic;
--           AGTB : out std_logic;
--           AEQB : out std_logic;
--           ALTB : out std_logic
--            
--);
--end entity Compx1;
--
--
--architecture comp of Compx1 is
--
--      begin
--
--      AGTB <= (input_A AND (not input_B));
--      AEQB <= (input_A XNOR input_B);
--      ALTB <= (input_B AND (not input_A));
--      
--end comp;


library ieee;
use ieee.std_logic_1164.all;
entity Compx1 is 
	port(
			A, B: in std_logic;
			AGTB, AEQB, ALTB: out std_logic
);
end Compx1;

architecture Compx1_Arch of Compx1 is
begin
	AGTB <= A AND (NOT B);
	AEQB <= A XNOR B;
	ALTB <= (NOT A) AND B;
end Compx1_Arch;
			