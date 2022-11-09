library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity signchange is
    Port ( an : in STD_LOGIC_VECTOR (3 downto 0); -- recebe uma entrada e realiza sua troca de sinal
           res : out STD_LOGIC_VECTOR (3 downto 0);
           signflag : out STD_LOGIC;
           coutsign : out STD_LOGIC); -- gera, como saídas, -valor de entrada e suas flags
end signchange;

architecture Behavioral of signchange is

component MOD_ADDER is -- componente somador completo de 1 bit

    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
			  cout : out STD_LOGIC;
           sum : out  STD_LOGIC);
 
end component;

signal coutaux : STD_LOGIC_VECTOR (3 downto 0); -- sinal de carry intermediário
signal notA : STD_LOGIC_VECTOR (3 downto 0); -- sinal auxiliar da negação do vetor de entrada

begin
notA <= not an; -- nega-se o valor de entrada
-- aqui, é feita a soma de 'notA' com o vetor "0000" e carry in inicial de valor '1'
c0 : mod_adder port map (notA(0),'0','1',coutaux(0),res(0));
c1 : mod_adder port map (notA(1),'0',coutaux(0),coutaux(1),res(1));
c2 : mod_adder port map (notA(2),'0',coutaux(1),coutaux(2),res(2));
c3 : mod_adder port map (notA(3),'0',coutaux(2),coutaux(3),res(3));
coutsign <= coutaux(3);
signflag <= not an(3); -- flag de sinal é contrária ao sinal de entrada

end Behavioral;
