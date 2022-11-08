library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_sub4b is
    Port ( avec : in  STD_LOGIC_VECTOR (3 downto 0);
           bvec : in  STD_LOGIC_VECTOR (3 downto 0); -- recebe duas entradas de 4 bits e realiza a operação: primeira entrada - segunda entrada
           zeroflag : out  STD_LOGIC;
           res : out  STD_LOGIC_VECTOR (3 downto 0);
           signalflagsu : out STD_LOGIC;
           couts : out STD_LOGIC;
           overflows : out STD_LOGIC); -- gera as saídas do resultado e das flags da subtração 
end full_sub4b;

architecture Behavioral of full_sub4b is

component MOD_ADDER is -- componente somador completo de 1 bit

    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           cout : out STD_LOGIC;
           sum : out  STD_LOGIC);
 
end component;

signal coutaux : STD_LOGIC_VECTOR (3 downto 0); -- sinal de carry auxiliar
signal TMP : STD_LOGIC_VECTOR (3 downto 0); -- sinal auxiliar para a realização das contas
signal resaux : STD_LOGIC_VECTOR (3 downto 0); -- sinal auxiliar do resultado
signal sinalflg : STD_LOGIC; -- sinal para a indicação da flag de sinal
signal garbage : STD_LOGIC; -- sinal para a realização da quinta soma, com intuito de facilitar a verificação do sinal

begin
TMP <= not bvec; -- a segunda entrada é invertida
-- aqui, são realizadas cinco somas com um carry in inicial no valor 1, para que seja realizado o complemento a dois da segunda entrada
s0 : mod_adder port map (avec(0),TMP(0),'1',coutaux(0),resaux(0));
s1 : mod_adder port map (avec(1),TMP(1),coutaux(0),coutaux(1),resaux(1));
s2 : mod_adder port map (avec(2),TMP(2),coutaux(1),coutaux(2),resaux(2));
s3 : mod_adder port map (avec(3),TMP(3),coutaux(2),coutaux(3),resaux(3));
s4 : mod_adder port map ('0','1',coutaux(3),sinalflg,garbage);
res <= resaux;
signalflagsu <= not sinalflg;
couts <= coutaux(3);
overflows <= coutaux(3) xor coutaux(2);
zeroflag <= (resaux(0) NOR resaux(1)) AND (resaux(2) NOR resaux(3));

end Behavioral;