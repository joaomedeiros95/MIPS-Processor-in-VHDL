library ieee;
use ieee.std_logic_1164.all;

entity controlador is
  port (
    num_a: in std_logic_vector(15 downto 0);
    reset_a: in std_logic;
    clock0: in std_logic;
    BT1,BT2: in bit := '1';
    lout: out bit;
    display: out STD_LOGIC_VECTOR(55 downto 0)
);
end controlador;

architecture arc of controlador is

-- PortMap da entrada
component operacoes_de_entrada is
port (
  num: in std_logic_vector(15 downto 0);
  reset: in std_logic;
  clock: in std_logic;
  BT1,BT2: in bit := '1';
  Op,Funct: out std_logic_vector(5 downto 0);
  Rs,Rt,Rd,Shamt: out std_logic_vector(4 downto 0)
);
end component;

-- PortMap do Banco de registradores
component Banco_reg is
PORT(
  Clk: IN STD_LOGIC; -- Clock do banco de registradores
  Reset: IN STD_LOGIC; -- Reinicializa o conteudo dos registradores
  RegWrite: IN std_logic; -- Indica se a operação é de escrita ou leitura
  ReadReg1: IN STD_LOGIC_VECTOR (4 downto 0);	-- Indica o registrador #1 a ser lido
  ReadReg2: IN STD_LOGIC_VECTOR (4 downto 0);	-- Indica o registrador #2 a ser lido
  WriteReg: IN STD_LOGIC_VECTOR (4 downto 0);	-- Indica o registrador a ser escrito
  WriteData: IN STD_LOGIC_VECTOR (31 downto 0);	-- Indica o dado a ser escrito
  ReadData1: OUT STD_LOGIC_VECTOR (31 downto 0);	-- Mostra a informaçao presente no registrador #1
  ReadData2: OUT STD_LOGIC_VECTOR (31 downto 0)	-- Mostra a informação presente no registrador #2
);
end component;

-- Component de Acesso a memória
component acessomemoria is
    port (
      address: in std_logic_vector (4 downto 0);
      clock: in std_logic;
      data: in std_logic_vector (31 downto 0);
      wren: in std_logic;
      q: out std_logic_vector (31 downto 0) );
  end component;

-- Component da ULA
component ula is
     port ( s: in std_logic_vector (31 downto 0);
       t: in std_logic_vector (31 downto 0);
       HI, LO: in std_logic_vector (31 downto 0);
       Op: in std_logic_vector (5 downto 0);
       Funct: in std_logic_vector (5 downto 0);
       sHI, sLO: out std_logic_vector (31 downto 0);
       d: out std_logic_vector (31 downto 0) );
end component;

-- Component do módulo de saída
component moduloSaida is
     port ( q: in STD_LOGIC_VECTOR(31 downto 0);
		 display: out STD_LOGIC_VECTOR(55 downto 0) );
end component;

-- Sinais
signal Op_a,Funct_a: std_logic_vector(5 downto 0);
signal Rs_a,Rt_a,Rd_a,Shamt_a: std_logic_vector(4 downto 0);
signal HI_a, LO_a, sHI_a, sLO_a: std_logic_vector (31 downto 0);
signal RegWrite_a: bit; -- Indica se a operação é de escrita ou leitura
signal ReadReg1_a: STD_LOGIC_VECTOR (4 downto 0);	-- Indica o registrador #1 a ser lido
signal ReadReg2_a: STD_LOGIC_VECTOR (4 downto 0);	-- Indica o registrador #2 a ser lido
signal WriteReg_a: STD_LOGIC_VECTOR (4 downto 0);	-- Indica o registrador a ser escrito
signal WriteData_a: STD_LOGIC_VECTOR (31 downto 0);	-- Indica o dado a ser escrito
signal ReadData1_a: STD_LOGIC_VECTOR (31 downto 0);	-- Mostra a informaçao presente no registrador #1
signal ReadData2_a: STD_LOGIC_VECTOR (31 downto 0);	-- Mostra a informação presente no registrador #2
signal d_a: STD_LOGIC_VECTOR (31 downto 0);
signal address_a: std_logic_vector (4 downto 0);
signal DataMem_a: std_logic_vector (31 downto 0);
signal s_a, t_a: std_logic_vector (31 downto 0);
signal wren_a: std_logic;
signal data_a: std_logic_vector (31 downto 0);
signal q_a: STD_LOGIC_VECTOR(31 downto 0);
signal estados: bit_vector(2 downto 0) := "000";
begin
  p0: operacoes_de_entrada PORT MAP (num_a, reset_a, clock0, BT1, BT2, Op_a, Funct_a, Rs_a, Rt_a, Rd_a, Shamt_a);
  
  -- Ler as informações passadas:
  br1: Banco_reg PORT MAP (clock0, reset_a, wren_a, ReadReg1_a, ReadReg2_a, WriteReg_a, WriteData_a, ReadData1_a, ReadData2_a);

  -- Ler as informações da memória:
  m1: acessomemoria PORT MAP (address_a, clock0, data_a, wren_a, DataMem_a);

  -- Jogar as informações pra ULA:
  u1: ula PORT MAP (s_a, t_a, HI_a, LO_a, Op_a, Funct_a, sHI_a, sLO_a, d_a);

  -- Jogar saída no BCD:
  bcd1: moduloSaida PORT MAP (q_a, display);

  pro1: process(clock0, num_a, reset_a, BT1, BT2, estados)
  begin
    if (clock0'event and clock0 = '1' and estados = "000") then
      lout <= '1';
      if ( BT2 = '0' ) then
        estados <= "001";
        lout <= '0';
      end if;
    end if;
    if(clock0'event and clock0 = '1' and estados = "001") then
      wren_a <= '0';
      if (Op_a = "000001" and Funct_a = "000000") then
        ReadReg1_a <= Rs_a;
        ReadReg2_a <= Rt_a;
      end if;
      if (Op_a = "000001" and Funct_a = "000001") then
	     ReadReg1_a <= Rs_a;
        address_a <= Rt_a;
      end if;
      if (Op_a = "000011") then
        ReadReg1_a <= Rs_a;
        address_a <= Rt_a;
      end if;
      if (Op_a = "000100") then
        ReadReg1_a <= Rs_a;
        ReadReg2_a <= Rt_a;
      end if;
      if (Op_a = "100011") then
        address_a <= Rs_a;
      end if;
      if (Op_a = "101011") then
        ReadReg1_a <= Rs_a;
      end if;
      if (Op_a = "001111") then
        ReadReg1_a <= "11110";
      end if;
      if (Op_a = "001110") then
        ReadReg1_a <= "11111";
      end if;
      if (Op_a = "000000") then
        if (Funct_a(1 downto 0) = "00") then
          ReadReg1_a <= Rs_a;
          ReadReg2_a <= Rt_a;
        elsif (Funct_a(1 downto 0) = "01") then
          ReadReg1_a <= Rs_a;
          ReadReg2_a <= Rt_a;
        elsif (Funct_a(1 downto 0) = "10") then
          ReadReg1_a <= Rs_a;
        end if;
      end if;
      estados <= "010";
    end if;
    if (clock0'event and clock0 = '1' and estados = "010") then 
      if (Op_a = "000001" and Funct_a = "000000") then
        s_a <= ReadData1_a;
        t_a <= ReadData2_a;
      elsif (Op_a = "000001" and Funct_a = "000001") then
        t_a <= ReadData1_a;
        s_a <= DataMem_a;
      elsif (Op_a = "000011") then
        t_a <= ReadData1_a;
        s_a <= DataMem_a;
      elsif (Op_a = "000100") then
        s_a <= ReadData1_a;
        t_a <= ReadData2_a;
      elsif (Op_a = "100011") then
        s_a <= DataMem_a;
      elsif (Op_a = "101011") then
        s_a <= ReadData1_a;
      elsif (Op_a = "001111") then
        HI_a <= ReadData1_a;
      elsif (Op_a = "001110") then
        LO_a <= ReadData1_a;
      elsif (Op_a = "000000" and Funct_a(1 downto 0) = "00") then
        s_a <= ReadData1_a;
        t_a <= ReadData2_a;
      elsif (Op_a = "000000" and Funct_a(1 downto 0) = "01") then
        s_a <= ReadData1_a;
        t_a <= ReadData2_a;
      elsif (Op_a = "000000" and Funct_a(1 downto 0) = "10") then
        s_a <= ReadData1_a;
      end if;
      estados <= "011";
    end if;
    if (clock0'event and clock0 = '1' and estados = "011") then
	   wren_a <= '1';
		if (Op_a = "000100") then
		   WriteReg_a <= "11110";
		   WriteData_a <= sHI_a;
		end if;
	   estados <= "100";
     end if;
     if (clock0'event and clock0 = '1' and estados = "100") then
	   wren_a <= '1';
           if (Op_a = "000100") then
		 WriteReg_a <= "11111";
		 WriteData_a <= sLO_a;
	   elsif (Op_a = "101011") then
                 data_a <= d_a;
           else
                 WriteData_a <= d_a;
		 WriteReg_a <= Rd_a;
           end if;
	   estados <= "101";
      end if;
      if (clock0'event and clock0 = '1' and estados = "101") then
	   estados <= "110";
      end if;
      if (clock0'event and clock0 = '1' and estados = "110") then
           wren_a <= '0';
           ReadReg1_a <= Rd_a;
	   if (Op_a = "000100") then
		q_a <= sLO_a;	 	  
           else  
                q_a <= d_a;
           end if;
	   estados <= "000";
      end if;
  end process pro1;
end arc;
