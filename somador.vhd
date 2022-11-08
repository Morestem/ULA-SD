library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder4b is
    Port (
    vetorbits1 : in STD_LOGIC_VECTOR (3 downto 0); 
    vetorbits2 : in STD_LOGIC_VECTOR (3 downto 0); -- recebe duas entradas de 4 bits
    resultado : out STD_LOGIC_VECTOR (3 downto 0);
    zeroflag : out  STD_LOGIC;
    cout : out STD_LOGIC;
    overflow : out  STD_LOGIC); -- gera, como saídas, o resultado da soma entre as entradas e suas flags
 
end full_adder4b;

architecture Behavioral of full_adder4b is

component MOD_ADDER is -- componente somador completo de 1 bit

    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
 cout : out STD_LOGIC;
           sum : out  STD_LOGIC);
 
end component;

signal coutaux : STD_LOGIC_VECTOR (3 downto 0); -- sinal de carry intermediário
signal auxans : STD_LOGIC_VECTOR (3 downto 0); -- sinal de resultado auxiliar
begin
-- aqui, são realizadas 4 operações de soma de 1 bit com carry propagado, juntamente à atribuição de valores às saídas
f0 : mod_adder port map (vetorbits1(0),vetorbits2(0),'0',coutaux(0),auxans(0));
f1 : mod_adder port map (vetorbits1(1),vetorbits2(1),coutaux(0),coutaux(1),auxans(1));
f2 : mod_adder port map (vetorbits1(2),vetorbits2(2),coutaux(1),coutaux(2),auxans(2));
f3 : mod_adder port map (vetorbits1(3),vetorbits2(3),coutaux(2),coutaux(3),auxans(3));
overflow <= coutaux(3) xor coutaux(2);
cout <= coutaux(3);
resultado <= auxans;
zeroflag <= (auxans(0) nor auxans(1)) and (auxans(2) nor auxans(3));


end Behavioral;
