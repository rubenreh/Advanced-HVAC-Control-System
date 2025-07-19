--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
--entity Compx4 is
--  port (
--    input_A : in std_logic_vector(3 downto 0);
--    input_B : in std_logic_vector(3 downto 0);
--    AGTB    : out std_logic_vector(3 downto 0);
--    AEQB    : out std_logic_vector(3 downto 0);
--    ALTB    : out std_logic_vector(3 downto 0)
--  );
--end entity Compx4;
--
--architecture comp of Compx4 is
--
--  -- Declare the component for the single-bit comparator
--  component Compx1
--    port (
--      input_A : in std_logic;
--      input_B : in std_logic;
--      AGTB    : out std_logic;
--      AEQB    : out std_logic;
--      ALTB    : out std_logic
--    );
--  end component Compx1;
--
--  -- Declare signals to connect to each set of 3 outputs from each instance of Compx1
--  signal AGTB_signal, AEQB_signal, ALTB_signal: std_logic_vector(3 downto 0);
--
--begin
--
--  -- Instantiate four instances of the Compx1 component
--  U0: Compx1 port map (input_A(0), input_B(0), AGTB_signal(0), AEQB_signal(0), ALTB_signal(0));
--  U1: Compx1 port map (input_A(1), input_B(1), AGTB_signal(1), AEQB_signal(1), ALTB_signal(1));
--  U2: Compx1 port map (input_A(2), input_B(2), AGTB_signal(2), AEQB_signal(2), ALTB_signal(2));
--  U3: Compx1 port map (input_A(3), input_B(3), AGTB_signal(3), AEQB_signal(3), ALTB_signal(3));
--
--  -- Combine individual comparisons to get 4-bit results
--  AGTB <= AGTB_signal;
--  AEQB <= AEQB_signal;
--  ALTB <= ALTB_signal;
--
--end comp;



library ieee;
use ieee.std_logic_1164.all;

entity Compx4 is
	port(
		A, B : std_logic_vector (3 downto 0); -- 4-bit input A, and B
		AGTB, AEQB, ALTB : out std_logic -- Outputs for A greater than, equal to and less than B
	);
end entity Compx4;

architecture Behavioral of Compx4 is
	-- Declaration of Compx1 as a component
	component Compx1
		port (
			A, B : in std_logic;
			AGTB, AEQB, ALTB: out std_logic
		);
	end component;
	
	signal AGTB_signal, AEQB_signal, ALTB_signal : std_logic_vector (3 downto 0);
	
begin
	-- Instance 1 of Compx1
	Compx1_inst1: Compx1 port map(A(0), B(0), AGTB_signal(0), AEQB_signal(0), ALTB_signal(0));
	-- Instance 2 of Compx1
	Compx1_inst2: Compx1 port map(A(1),B(1),AGTB_signal(1), AEQB_signal(1),ALTB_signal(1));
	-- Instance 3 of Compx1
	Compx1_inst3: Compx1 port map(A(2),B(2),AGTB_signal(2), AEQB_signal(2),ALTB_signal(2));
	-- Instance 4 of Compx1
	Compx1_inst4: Compx1 port map(A(3),B(3),AGTB_signal(3), AEQB_signal(3),ALTB_signal(3));
	
	
	-- If MSB is greater than, or second MSB is greater than, or third MSB is greater than, or LSB is greater than
	AGTB <= AGTB_signal(3) or 
            (AEQB_signal(3) and AGTB_signal(2)) or 
            (AEQB_signal(3) and AEQB_signal(2) and AGTB_signal(1)) or 
            (AEQB_signal(3) and AEQB_signal(2) and AEQB_signal(1) and AGTB_signal(0));
	
	-- Check if all bits are equal
	AEQB <= AEQB_signal(3) and AEQB_signal(2) and AEQB_signal(1) and AEQB_signal(0);
	
	-- If LSB is less than, or second LSB is less than, or third LSB is less than, or MSB is less than
	ALTB <= (ALTB_signal(0) and AEQB_signal(1) and AEQB_signal(2) and AEQB_signal(3)) or
              (ALTB_signal(1) and AEQB_signal(2) and AEQB_signal(3)) or
              (ALTB_signal(2) and AEQB_signal(3)) or
              ALTB_signal(3);
	
end Behavioral;
	
	