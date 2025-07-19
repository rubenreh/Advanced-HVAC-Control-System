--library ieee;
--use ieee.std_logic_1164.all;
--
--
--entity LogicalStep_Lab3_top is port (
--	clkin_50		: in 	std_logic;
--	pb_n			: in	std_logic_vector(3 downto 0);
-- 	sw   			: in  std_logic_vector(7 downto 0); 	
--	
--	----------------------------------------------------
----	HVAC_temp : out std_logic_vector(3 downto 0); -- used for simulations only. Comment out for FPGA download compiles.
--	----------------------------------------------------
--	
--   leds			: out std_logic_vector(7 downto 0);
--   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
--	seg7_char1  : out	std_logic;				    		-- seg7 digit1 selector
--	seg7_char2  : out	std_logic				    		-- seg7 digit2 selector
--	
--); 
--end LogicalStep_Lab3_top;
--
--architecture design of LogicalStep_Lab3_top is
----
---- Provided Project Components Used
--------------------------------------------------------------------- 
--
--component SevenSegment  port (
--   hex	   :  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
--   sevenseg :  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
--); 
--end component SevenSegment;
--
--component segment7_mux port (
--          clk        : in  std_logic := '0';
--			 DIN2 		: in  std_logic_vector(6 downto 0);	
--			 DIN1 		: in  std_logic_vector(6 downto 0);
--			 DOUT			: out	std_logic_vector(6 downto 0);
--			 DIG2			: out	std_logic;
--			 DIG1			: out	std_logic
--        );
--end component segment7_mux;
--
--  component Compx4
--    port (
--      input_A : in  std_logic_vector(3 downto 0);
--      input_B : in  std_logic_vector(3 downto 0);
--      AGTB    : out std_logic_vector(3 downto 0);
--      AEQB    : out std_logic_vector(3 downto 0);
--      ALTB    : out std_logic_vector(3 downto 0)
--    );
--  end component Compx4;
--  
----	
----component Tester port (
---- MC_TESTMODE				: in  std_logic;
---- I1EQI2,I1GTI2,I1LTI2	: in	std_logic;
----	input1					: in  std_logic_vector(3 downto 0);
----	input2					: in  std_logic_vector(3 downto 0);
----	TEST_PASS  				: out	std_logic							 
----	); 
----	end component;
------	
----component HVAC 	port (
----	HVAC_SIM					: in boolean;
----	clk						: in std_logic; 
----	run		   			: in std_logic;
----	increase, decrease	: in std_logic;
----	temp						: out std_logic_vector (3 downto 0)
----	);
----end component;
--------------------------------------------------------------------
---- Add any Other Components here
--------------------------------------------------------------------
--
--------------------------------------------------------------------	
---- Create any additional internal signals to be used
--------------------------------------------------------------------	
--constant HVAC_SIM : boolean := TRUE; -- set to FALSE when compiling for FPGA download to LogicalStep board 
--                                      -- or TRUE for doing simulations with the HVAC Component
--------------------------------------------------------------------	
--
---- global clock
--signal clk_in					: std_logic;
--signal hex_A, hex_B 			: std_logic_vector(3 downto 0);
--signal hexA_7seg, hexB_7seg: std_logic_vector(6 downto 0);
--------------------------------------------------------------------- 
--
--  signal AGTB, AEQB, ALTB : std_logic_vector(3 downto 0);
--
--begin
--
--  clk_in <= clkin_50;
--
--  hex_A <= sw(3 downto 0);
--  hex_B <= sw(7 downto 4);
--
--  inst1 : SevenSegment port map (hex_A, hexA_7seg);
--  inst2 : SevenSegment port map (hex_B, hexB_7seg);
--  inst3 : segment7_mux port map (clk_in, hexA_7seg, hexB_7seg, seg7_data, seg7_char2, seg7_char1);
--
--  inst4 : Compx4 port map (hex_A, hex_B, AGTB, AEQB, ALTB);
--
--  -- Connect the 3 magnitude comparison outputs of Compx4 to leds[2..0]
--  leds(2) <= AGTB(3);
--  leds(1) <= AEQB(3);
--  leds(0) <= ALTB(3);
--end design;



library ieee;
use ieee.std_logic_1164.all;


entity LogicalStep_Lab3_top is port (
	clkin_50		: in 	std_logic;
	pb_n			: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); 	
	
	----------------------------------------------------
--	HVAC_temp : out std_logic_vector(3 downto 0); -- used for simulations only. Comment out for FPGA download compiles.
	----------------------------------------------------
	
   leds			: out std_logic_vector(7 downto 0);
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  : out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab3_top;

architecture design of LogicalStep_Lab3_top is
--
-- Provided Project Components Used
------------------------------------------------------------------- 

component SevenSegment  port (
   hex	   :  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg :  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
); 
end component SevenSegment;

component Bidir_shift_reg port (
		CLK : in std_logic := '0';
		RESET : in std_logic := '0';
		CLK_EN : in std_logic := '0';
		LEFT0_RIGHT1 : in std_logic := '0';
		REG_BITS : out std_logic_vector(7 downto 0)
);
end component Bidir_shift_reg;

component U_D_Bin_Counter8bit port (
	CLK, RESET, CLK_EN, UP1_DOWN0	  : in std_logic;
	COUNTER_BITS 						  : out std_logic_vector(7 downto 0)
	);
end component U_D_Bin_Counter8bit;

component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);	
			 DIN1 		: in  std_logic_vector(6 downto 0);
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
        );
end component segment7_mux;

-- Component for pb inverter
component PB_Inverters port (
	pb_n : in std_logic_vector(3 downto 0);
	pb : out std_logic_vector(3 downto 0)
);
end component PB_Inverters;

-- Component for the 4 bit comparator
component Compx4 port (
	A, B : std_logic_vector (3 downto 0); -- 4-bit input A, and B
	AGTB, AEQB, ALTB : out std_logic -- Outputs for A greater than, equal to and less than B
);
end component Compx4;

component HVAC port
	(
		HVAC_SIM					: in boolean;
		clk						: in std_logic; 
		run		   			: in std_logic;
		increase, decrease	: in std_logic;
		temp						: out std_logic_vector (3 downto 0)
	);
end component HVAC;

component mux port(
			vacation_temp, desired_temp : in std_logic_vector(3 downto 0); 
			vacation_mode: in std_logic;
			mux_temp: out std_logic_vector(3 downto 0)
);
end component mux;

component Energy_Monitor port(
		vacation_mode,MC_test_mode, window_open, door_open, AGTB, AEQB, ALTB : in std_logic;
		furnace, at_temp, AC, blower, window, door, vacation, decrease, increase, run : out std_logic
	);
end component Energy_Monitor;

--	
component Tester port (
MC_TESTMODE				: in  std_logic;
I1EQI2,I1GTI2,I1LTI2	: in	std_logic;
input1					: in  std_logic_vector(3 downto 0);
input2					: in  std_logic_vector(3 downto 0);
TEST_PASS  				: out	std_logic							 ); 
end component;
	
------------------------------------------------------------------
-- Add any Other Components here
------------------------------------------------------------------

------------------------------------------------------------------	
-- Create any additional internal signals to be used
------------------------------------------------------------------	
constant HVAC_SIM : boolean := FALSE; -- set to FALSE when compiling for FPGA download to LogicalStep board 
                                      -- or TRUE for doing simulations with the HVAC Component
------------------------------------------------------------------	

-- global clock
signal clk_in					: std_logic;
signal hex_A, hex_B 			: std_logic_vector(3 downto 0);
signal hexA_7seg, hexB_7seg: std_logic_vector(6 downto 0);

-- pb inverter
signal pb_inverted : std_logic_vector(3 downto 0);
signal AGTB, AEQB, ALTB : std_logic;
signal run, increase, decrease: std_logic;
signal current_temp, mux_temp : std_logic_vector(3 downto 0);
------------------------------------------------------------------- 
begin -- Here the circuit begins

clk_in <= clkin_50;	--hook up the clock input

-- temp inputs hook-up to internal busses.
hex_A <= sw(3 downto 0);
hex_B <= sw(7 downto 4);

-- Instances for the seven seg display
inst1: sevensegment port map (mux_temp, hexA_7seg);
inst2: sevensegment port map (current_temp, hexB_7seg);

inst3: segment7_mux port map (clk_in, hexA_7seg, hexB_7seg, seg7_data, seg7_char2, seg7_char1);
		
-- Instances for the 4-bit Comparator
inst4: Compx4 port map(mux_temp, current_temp, AGTB, AEQB, ALTB);

-- inverter
inst6: PB_Inverters port map(pb_n, pb_inverted); 

--HVAC instance
inst7: HVAC port map(HVAC_SIM, clk_in, run, increase, decrease, current_temp);

-- Energy monitor
inst8: Energy_Monitor port map(pb_inverted(3), pb_inverted(2), pb_inverted(1), pb_inverted(0), AGTB, AEQB, ALTB, leds(0), leds(1), leds(2), leds(3), leds(4), leds(5), leds(7), decrease, increase, run);

-- Instance for Tester
inst9: Tester port map(pb_inverted(2),AEQB, AGTB, ALTB, hex_A, current_temp, leds(6));

-- instance for mux, hex_B first since vacation temp declared first
inst10: mux port map(hex_B, hex_A, pb_inverted(3), mux_temp);

end design;




