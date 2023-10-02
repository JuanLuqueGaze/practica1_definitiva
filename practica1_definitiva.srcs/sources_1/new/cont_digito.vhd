----------------------------------------------------------------------------------

-- Engineer: Juan Luque Giron

-- Create Date: 28.09.2023 17:23:15

-- Module Name: cont_digito - Behavioral

----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY cont_digito IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        resta : IN STD_LOGIC;
        dos : IN STD_LOGIC;
        sat : OUT STD_LOGIC;
        cuenta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)

    );
END cont_digito;

ARCHITECTURE Behavioral OF cont_digito IS
    SIGNAL intercuenta : unsigned(3 DOWNTO 0) := "0000";
    SIGNAL ncuenta : unsigned(3 DOWNTO 0) := "0000";
BEGIN

    cuenta <= STD_LOGIC_VECTOR(intercuenta);

    sinc : PROCESS (clk, reset, enable)
    BEGIN
        IF reset = '1' THEN
            intercuenta <= (OTHERS => '0');
        ELSIF (rising_edge(clk) AND enable = '1') THEN
            intercuenta <= ncuenta;
        END IF;
    END PROCESS;

    comb : PROCESS (intercuenta, enable)
    BEGIN
        IF (resta = '0') THEN
            IF (intercuenta = 9) THEN -- Desborde sumando 2 en 9
                IF (dos = '0') THEN
                    ncuenta <= (OTHERS => '0');
                    sat <= '1';
                ELSE
                    ncuenta <= "0001";
                    sat <= '1';
                END IF;
            ELSIF (intercuenta = 8 AND dos = '1') THEN --Desborde sumando 2 en 8
                ncuenta <= (OTHERS => '0');
                sat <= '1';
            ELSE
                sat <= '0';
                IF (dos = '0') THEN --Suma normal 
                    ncuenta <= intercuenta + 1;
                ELSE
                    ncuenta <= intercuenta + 2;
                END IF;
            END IF;
        ELSE
            IF (intercuenta = 0) THEN -- Desborde sumando 2 en 9
                IF (dos = '0') THEN
                    ncuenta <= "1001";
                    sat <= '1';
                ELSE
                    ncuenta <= "1000";
                    sat <= '1';
                END IF;
            ELSIF (intercuenta = 1 AND dos = '1') THEN --Desborde sumando 2 en 8
                ncuenta <= "1001";
                sat <= '1';
            ELSE
                sat <= '0';
                IF (dos = '0') THEN --Suma normal 
                    ncuenta <= intercuenta - 1;
                ELSE
                    ncuenta <= intercuenta - 2;
                END IF;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;