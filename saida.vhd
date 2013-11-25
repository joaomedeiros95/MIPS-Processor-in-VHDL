library ieee;
use ieee.std_logic_1164.all;

entity saida is
  port (
    lin: in bit; --Inidica se a operação acabou ou não (1 Verdadeiro, 0 Falso);
    lout: out bit); --Acende ou não o LED
end saida;

architecture arc of saida is
  begin
    process(lin)
      begin
        if ( lin = '0' ) then
          lout <= '0';
        end if;
        if ( lin = '1' ) then
          lout <= '1';
        end if;
      end process;
end arc;      
