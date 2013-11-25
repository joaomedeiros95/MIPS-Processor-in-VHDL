library ieee;
use ieee.std_logic_1164.all;

entity moduloSaida is
	port(q: in STD_LOGIC_VECTOR(31 downto 0);        -- Porta de entrada que recebe o valor do resultado da ULA.
		 display: out STD_LOGIC_VECTOR(55 downto 0)	 -- Porta de saída para os displays de 7 segmentos = (32/4)*7 => ((bits do resultado)/(bits em cada display))* 8 saídas em cada display. 
	);
end moduloSaida;

architecture arc of moduloSaida is
component conversorBCD is                              -- Componente para conversão do valor de 4 bits em saídas para o display de 7 segmentos.
	port(BCD : in STD_LOGIC_VECTOR(3 DOWNTO 0);      
		 SEG : out STD_LOGIC_VECTOR(6 DOWNTO 0)
	);  
end component;
begin 
	c1: conversorBCD port map  (q(3 downto 0), display(6 downto 0));				-- Portmaps para os oito displays que exibirão os dados.
	c2: conversorBCD port map  (q(7 downto 4), display(13 downto 7));
	c3: conversorBCD port map  (q(11 downto 8), display(20 downto 14));
	c4: conversorBCD port map  (q(15 downto 12), display(27 downto 21));
	c5: conversorBCD port map  (q(19 downto 16), display(34 downto 28));
	c6: conversorBCD port map  (q(23 downto 20), display(41 downto 35));
	c7: conversorBCD port map  (q(27 downto 24), display(48 downto 42));
	c8: conversorBCD port map  (q(31 downto 28), display(55 downto 49));
end arc;	
