-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CONTROL_DISPLAY_P2_tb IS
END CONTROL_DISPLAY_P2_tb;

ARCHITECTURE test_bench OF CONTROL_DISPLAY_P2_tb IS
    -- Signals for connection to the DUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC;
    SIGNAL A : STD_LOGIC;
    SIGNAL B : STD_LOGIC;
    SIGNAL C : STD_LOGIC;
    SIGNAL D : STD_LOGIC;
    SIGNAL E : STD_LOGIC;
    SIGNAL F : STD_LOGIC;
    SIGNAL G : STD_LOGIC;
    SIGNAL DP : STD_LOGIC;
    SIGNAL AN : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Component declaration
    COMPONENT CONTROL_DISPLAY_P2
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            A : OUT STD_LOGIC;
            B : OUT STD_LOGIC;
            C : OUT STD_LOGIC;
            D : OUT STD_LOGIC;
            E : OUT STD_LOGIC;
            F : OUT STD_LOGIC;
            G : OUT STD_LOGIC;
            DP : OUT STD_LOGIC;
            AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : CONTROL_DISPLAY_P2
    PORT MAP(
        clk => clk,
        reset => reset,
        A => A,
        B => B,
        C => C,
        D => D,
        E => E,
        F => F,
        G => G,
        DP => DP,
        AN => AN);

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        reset <= '1'; -- EDIT Initial value

        -- Wait one clock period
        WAIT FOR 3 * clockPeriod;
        reset <= '0';

        -- EDIT Genererate stimuli here

        WAIT;
    END PROCESS;

END test_bench;