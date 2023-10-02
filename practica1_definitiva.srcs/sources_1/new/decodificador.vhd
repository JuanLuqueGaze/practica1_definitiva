----------------------------------------------------------------------------------

-- Engineer: Juan Luque Giron

-- Create Date: 29.09.2023 08:43:48

-- Module Name: decodificador - Behavioral

----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.NUMERIC_STD.ALL;

ENTITY decodificador IS
    PORT (
        binario : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        siete_seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END decodificador;

ARCHITECTURE Behavioral OF decodificador IS

BEGIN
    conversion : PROCESS (binario)
    BEGIN
        CASE (binario) IS
            WHEN "0000" => siete_seg <= "0000001";
            WHEN "0001" => siete_seg <= "1001111";
            WHEN "0010" => siete_seg <= "0010010";
            WHEN "0011" => siete_seg <= "0000110";
            WHEN "0100" => siete_seg <= "1001100";
            WHEN "0101" => siete_seg <= "0100100";
            WHEN "0110" => siete_seg <= "0100000";
            WHEN "0111" => siete_seg <= "0001111";
            WHEN "1000" => siete_seg <= "0000000";
            WHEN "1001" => siete_seg <= "0000100";
            WHEN OTHERS => siete_seg <= "1111110"; --ponemos una raya horizontal
        END CASE;

    END PROCESS;
END Behavioral;