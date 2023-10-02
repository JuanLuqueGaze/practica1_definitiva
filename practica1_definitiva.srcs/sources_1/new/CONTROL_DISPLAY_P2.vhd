----------------------------------------------------------------------------------
-- Engineer: Juan Luque Girón

-- Create Date: 29.09.2023 09:05:06

-- Module Name: CONTROL_DISPLAY_P2 - Behavioral
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY CONTROL_DISPLAY_P2 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        resta : IN STD_LOGIC;
        dos : IN STD_LOGIC;
        A : OUT STD_LOGIC;
        B : OUT STD_LOGIC;
        C : OUT STD_LOGIC;
        D : OUT STD_LOGIC;
        E : OUT STD_LOGIC;
        F : OUT STD_LOGIC;
        G : OUT STD_LOGIC;
        DP : OUT STD_LOGIC;
        AN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END CONTROL_DISPLAY_P2;

ARCHITECTURE Behavioral OF CONTROL_DISPLAY_P2 IS

    COMPONENT div_frec
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            sat : OUT STD_LOGIC;
            sat2 : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT decodificador
        PORT (
            binario : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            siete_seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT reg_desp
        PORT (
            enable : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            display_enable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT cont_digito
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            resta : IN STD_LOGIC;
            dos : IN STD_LOGIC;
            sat : OUT STD_LOGIC;
            cuenta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)

        );
    END COMPONENT;

    SIGNAL saldiv : STD_LOGIC; --Salida del div_frec
    SIGNAL e1, e2, e3, e4 : STD_LOGIC; --Enable para los contadores
    SIGNAL ei2, ei3, ei4 : STD_LOGIC; --Enable intermedio para pasar por las and
    SIGNAL ed : STD_LOGIC; --Enable del reg desp
    SIGNAL shiftout : STD_LOGIC_VECTOR(3 DOWNTO 0); -- Salida del shiftregister
    SIGNAL cuen1, cuen2, cuen3, cuen4 : STD_LOGIC_VECTOR(3 DOWNTO 0); --Salidas de los contadores
    SIGNAL num : STD_LOGIC_VECTOR(3 DOWNTO 0); --Salida del mux
    SIGNAL asoc : STD_LOGIC_VECTOR(6 DOWNTO 0); --Salida del decoder
BEGIN
    df : div_frec
    PORT MAP(
        clk => clk,
        reset => reset,
        sat => e1,
        sat2 => ed
    );

    -- Contadores

    c1 : cont_digito
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => e1,
        resta => resta,
        dos => dos,
        sat => ei2,
        cuenta => cuen1
    );

    c2 : cont_digito
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => e2,
        resta => resta,
        dos => '0',
        sat => ei3,
        cuenta => cuen2
    );

    c3 : cont_digito
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => e3,
        resta => resta,
        dos => '0',
        sat => ei4,
        cuenta => cuen3
    );

    c4 : cont_digito
    PORT MAP(
        clk => clk,
        reset => reset,
        resta => resta,
        dos => '0',
        enable => e4,
        cuenta => cuen4 --Hemos quitado el sat ya que no utilizamos ese puerto
    );

    -- Declaración de los ands y uso de las señales intermedias

    e2 <= ei2 AND e1;
    e3 <= ei3 AND e2;
    e4 <= ei4 AND e3;

    --Registro de desplazamiento

    shiftreg : reg_desp
    PORT MAP(
        clk => clk,
        reset => reset,
        enable => ed,
        display_enable => shiftout);
    -- Multiplexor
    mux : PROCESS (cuen1, cuen2, cuen3, cuen4, shiftout)
    BEGIN
        CASE (shiftout) IS
            WHEN "0111" => num <= cuen1;
            WHEN "1011" => num <= cuen2;
            WHEN "1101" => num <= cuen3;
            WHEN "1110" => num <= cuen4;
            WHEN OTHERS => num <= "1111";
        END CASE;
    END PROCESS;
    -- Decodificador
    dec : decodificador
    PORT MAP(
        binario => num,
        siete_seg => asoc
    );
    --Asignación de asoc a la salida

    A <= asoc(6);
    B <= asoc(5);
    C <= asoc(4);
    D <= asoc(3);
    E <= asoc(2);
    F <= asoc(1);
    G <= asoc(0);
    DP <= '1';
    AN <= (shiftout);
END Behavioral;