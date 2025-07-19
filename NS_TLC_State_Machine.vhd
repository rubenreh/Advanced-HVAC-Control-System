library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NS_TLC_State_Machine is
    Port ( clk         : in STD_LOGIC;
           reset       : in STD_LOGIC;
           sm_clken    : in STD_LOGIC; -- State machine clock enable signal
           ns_light    : out STD_LOGIC_VECTOR(2 downto 0)); -- Output for NS traffic lights: [A,G,D]
end NS_TLC_State_Machine;

architecture Behavioral of NS_TLC_State_Machine is
    type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15);
    signal current_state, next_state: state_type := S0;
begin
    -- State Transition Process
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            if sm_clken = '1' then
                current_state <= next_state;
            end if;
        end if;
    end process;

    -- Next State Logic
    next_state_logic: process(current_state)
    begin
        case current_state is
            when S0 =>
                next_state <= S1;
            when S1 =>
                next_state <= S2;
            -- Continue for other states up to S14
            when S14 =>
                next_state <= S15;
            when S15 =>
                next_state <= S0;
            when others =>
                next_state <= S0;
        end case;
    end process;

    -- Output Logic for NS Traffic Lights
    -- Note: Customize the output encoding as per your LED wiring and requirements.
    -- Here, '001' could represent Green, '010' Yellow, and '100' Red for simplicity.
    ns_light_control: process(current_state)
    begin
        case current_state is
            when S0 | S1 =>
                ns_light <= (others => '0'); -- All off for S0 and S1
            when S2 to S5 =>
                ns_light <= "100"; -- Red
            when S6 to S9 =>
                ns_light <= "010"; -- Yellow
            when S10 to S13 =>
                ns_light <= "001"; -- Green
            when others =>
                ns_light <= (others => '0');
        end case;
    end process;
end Behavioral;
