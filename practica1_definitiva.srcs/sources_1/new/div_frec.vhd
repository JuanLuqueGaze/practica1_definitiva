----------------------------------------------------------------------------------
-- Engineer: Juan Luque Girón
-- Create Date: 28.09.2023 13:23:57
-- Module Name: div_frec - Behavioral

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY div_frec IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        sat : OUT STD_LOGIC;
        sat2 : OUT STD_LOGIC
    );
END div_frec;

ARCHITECTURE Behavioral OF div_frec IS
    SIGNAL p_cuenta, cuenta : unsigned(25 DOWNTO 0);
    --A la hora de subirlo a la FPGA ponemos 25 DOWNTO 0, mientras que simulemos pondremos 3 bits
    SIGNAL cuenta14 : unsigned (14 DOWNTO 0);
BEGIN

    sinc : PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            cuenta <= (OTHERS => '0');
        ELSIF (rising_edge(clk)) THEN
            cuenta <= cuenta + 1;
        END IF;
    END PROCESS;

    comb : PROCESS (cuenta)
    BEGIN
        IF cuenta = "11111111111111111111111111" THEN
            sat <= '1';
        ELSE
            sat <= '0';
        END IF;

        IF cuenta(14 DOWNTO 0) = "111111111111111" THEN
            sat2 <= '1';
        ELSE
            sat2 <= '0';
        END IF;

    END PROCESS;

END Behavioral;