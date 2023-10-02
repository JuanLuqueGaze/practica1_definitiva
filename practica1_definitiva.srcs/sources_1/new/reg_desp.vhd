----------------------------------------------------------------------------------
-- Engineer: Juan Luque Girón

-- Create Date: 29.09.2023 08:20:05

-- Module Name: reg_desp - Behavioral
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY reg_desp IS
    PORT (
        enable : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        display_enable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END reg_desp;

ARCHITECTURE Behavioral OF reg_desp IS
    -- SIGNAL desplaz : STD_LOGIC_VECTOR(3 DOWNTO 0);
    --SIGNAL ndesplaz : STD_LOGIC_VECTOR(3 DOWNTO 0);
    --TYPE ESTADOS IS (c1, c2, c3, c4);
    --SIGNAL estado, estadoant : ESTADOS;
    SIGNAL sm : unsigned(3 DOWNTO 0) := "1110";
    SIGNAL sm2 : unsigned(3 DOWNTO 0) := "1110";
BEGIN
    sm2 <= sm(0) & sm(3 DOWNTO 1);
    display_enable <= STD_LOGIC_VECTOR(sm);
    secuencial : PROCESS (clk, reset, enable)
    BEGIN
        IF (reset = '1') THEN
            sm <= "1110";
        ELSIF (rising_edge(clk) AND enable = '1') THEN
            sm <= sm2;
        END IF;
    END PROCESS;

END Behavioral;