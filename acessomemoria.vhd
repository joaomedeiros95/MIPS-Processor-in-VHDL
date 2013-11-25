library ieee;
use ieee.std_logic_1164.all;

entity acessomemoria is
  port (
    address: in std_logic_vector (4 downto 0);
      clock: in std_logic;
      data: in std_logic_vector (31 downto 0);
      wren: in std_logic;
      q: out std_logic_vector (31 downto 0) );
end acessomemoria;

architecture arc of acessomemoria is
  component memoria
    port (
      address: in std_logic_vector (4 downto 0);
      clock: in std_logic;
      data: in std_logic_vector (31 downto 0);
      wren: in std_logic;
      q: out std_logic_vector (31 downto 0) );
  end component;
  begin
    import: memoria PORT MAP (address, clock, data, wren, q);
end arc;
