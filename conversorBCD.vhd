-- o conversor é de 4 bits, entao lembrem-se de instanciá-lo quantas vezes for necessário.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conversorBCD is
port( BCD : in STD_LOGIC_VECTOR(3 DOWNTO 0);      
      SEG : out STD_LOGIC_VECTOR(6 DOWNTO 0));
begin   
end conversorBCD;

architecture um of conversorBCD is
signal seg_int : integer;
                       -- segmento amostrador:     abcdefg 
constant ds0  :  std_logic_vector (6 downto 0) := "1000000"; -- codigo do numero 0
constant ds1  :  std_logic_vector (6 downto 0) := "1111001"; -- codigo do numero 1
constant ds2  :  std_logic_vector (6 downto 0) := "0100100"; -- codigo do numero 2
constant ds3  :  std_logic_vector (6 downto 0) := "0110000"; -- codigo do numero 3
constant ds4  :  std_logic_vector (6 downto 0) := "0011001"; -- codigo do numero 4
constant ds5  :  std_logic_vector (6 downto 0) := "0010010"; -- codigo do numero 5
constant ds6  :  std_logic_vector (6 downto 0) := "0000010"; -- codigo do numero 6
constant ds7  :  std_logic_vector (6 downto 0) := "1111000"; -- codigo do numero 7
constant ds8  :  std_logic_vector (6 downto 0) := "0000000"; -- codigo do numero 8 
constant ds9  :  std_logic_vector (6 downto 0) := "0010000"; -- codigo do numero 9
constant ds10 :  std_logic_vector (6 downto 0) := "0001000"; -- codigo do numero A
constant ds11 :  std_logic_vector (6 downto 0) := "0000011"; -- codigo do numero B
constant ds12 :  std_logic_vector (6 downto 0) := "1000110"; -- codigo do numero C
constant ds13 :  std_logic_vector (6 downto 0) := "0100001"; -- codigo do numero D
constant ds14 :  std_logic_vector (6 downto 0) := "0000110"; -- codigo do numero E
constant ds15 :  std_logic_vector (6 downto 0) := "0001110"; -- codigo do numero F
constant dsn  :  std_logic_vector (6 downto 0) := "1111111"; -- apagado

begin
seg_int <= to_integer(unsigned(BCD));

seg <= ds0  when seg_int= 0 else 
       ds1  when seg_int= 1 else
       ds2  when seg_int= 2 else
       ds3  when seg_int= 3 else
       ds4  when seg_int= 4 else
       ds5  when seg_int= 5 else
       ds6  when seg_int= 6 else
       ds7  when seg_int= 7 else 
       ds8  when seg_int= 8 else
       ds9  when seg_int= 9 else
       ds10 when seg_int= 10 else
       ds11 when seg_int= 11 else
       ds12 when seg_int= 12 else
       ds13 when seg_int= 13 else
       ds14 when seg_int= 14 else
       ds15;
end;
