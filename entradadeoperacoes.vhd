library ieee;
use ieee.std_logic_1164.all;

entity operacoes_de_entrada is
  port(
    num: in std_logic_vector(15 downto 0);
    reset: in std_logic;
    clock: in std_logic;
    BT1,BT2: in bit := '1';
    Op,Funct: out std_logic_vector(5 downto 0);
    Rs,Rt,Rd,Shamt: out std_logic_vector(4 downto 0)
    
);
end operacoes_de_entrada;

architecture arc of operacoes_de_entrada is
  signal saida : std_logic_vector(31 downto 0);
  signal espera : bit_vector (1 downto 0) := "00"; 
begin
process(clock,BT1,BT2,reset,espera)
    begin
      if(clock'event and clock = '1' and reset = '0')then
        saida <= "00000000000000000000000000000000";
	espera <= "00";
      elsif(clock'event and clock = '1' and reset = '1')then
        if(BT1 = '0' and espera = "00")then
          saida(31 downto 16) <= num;
          espera <= "01";
      	end if;
      	if(BT1 = '1' and espera = "01") then
      	  espera <= "10";
        end if;
        if(BT1 = '0' and espera = "10")then
          saida(15 downto 0) <= num;
        end if;
        if(BT2 = '0')then
          Op <= saida(31 downto 26);
          Rs <= saida(25 downto 21); 
          Rt <= saida(20 downto 16);
          Rd <= saida(15 downto 11);
          Shamt <= saida(10 downto 6);
          Funct <= saida(5 downto 0);
			 espera <= "00";
        end if;
 end if;
 end process;
 end arc;
