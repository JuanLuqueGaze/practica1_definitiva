-- Testbench automatically generated

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

ENTITY cont_digito_tb IS
END cont_digito_tb;

ARCHITECTURE test_bench OF cont_digito_tb IS
    -- Signals for connection to the DUT
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC;
    SIGNAL enable : STD_LOGIC;
    SIGNAL resta : STD_LOGIC;
    SIGNAL sat : STD_LOGIC;
    SIGNAL cuenta : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Component declaration
    COMPONENT cont_digito
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            resta : IN STD_LOGIC;
            sat : OUT STD_LOGIC;
            cuenta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    CONSTANT clockPeriod : TIME := 10 ns; -- EDIT Clock period

BEGIN
    DUT : cont_digito
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => enable,
        resta => resta,
        sat => sat,
        cuenta => cuenta);

    clk <= NOT clk AFTER clockPeriod/2;

    stimuli : PROCESS
    BEGIN
        reset <= '0'; -- EDIT Initial value
        enable <= '0'; -- EDIT Initial value
        resta <= '0'; -- EDIT Initial value

        -- Wait one clock period
        WAIT FOR 1 * clockPeriod;
        enable <= '1';

        WAIT FOR 20 * clockPeriod;
        resta <= '1';
        -- EDIT Genererate stimuli here

        WAIT FOR 30 * clockPeriod;
        resta <= '0';
        WAIT;
    END PROCESS;

END test_bench;