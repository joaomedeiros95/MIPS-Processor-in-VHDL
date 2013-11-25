library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ula is
  port ( s: in std_logic_vector (31 downto 0);
    t: in std_logic_vector (31 downto 0);
    HI, LO: in std_logic_vector (31 downto 0);
    Op: in std_logic_vector (5 downto 0);
    Funct: in std_logic_vector (5 downto 0);
    sHI, sLO: out std_logic_vector (31 downto 0);
    d: out std_logic_vector (31 downto 0) );
end ula;

architecture arc of ula is
signal mult: std_logic_vector(63 downto 0);
begin
process (Op,Funct,s,t,HI,LO)
begin
  case Op is
    when "000001" => d <= s + t;
    when "000011" => d <= not (s - t) + 1;
    when "000100" => mult <= s * t;
                     sHI <= mult(63 downto 32);
                     sLO <= mult(31 downto 0);
    when "100011" => d <= s;
    when "101011" => d <= s;
    when "001111" => d <= HI;
    when "001110" => d <= LO;
    when others => if (Funct(1 downto 0) = "00") then
                       d <= s and t;
                     elsif (Funct(1 downto 0) = "01") then
                       d <= s or t;
                     elsif (Funct(1 downto 0) = "10") then
                       d <= not s;
		     end if;
end case;
end process;
end arc;
