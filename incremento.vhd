library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity increment is
    Port ( avec : in  STD_LOGIC_VECTOR (3 downto 0); -- recebe uma entrada de 4 bits para a realização da operação de incremento de 1
           res : out  STD_LOGIC_VECTOR (3 downto 0);
           ovflw : out  STD_LOGIC;
           couti : out STD_LOGIC); -- gera saídas contendo o resultado da operação, bem como suas flags
end increment;

architecture Behavioral of increment is

component MOD_ADDER is -- componente somador completo de 1 bit

    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
			  cout : out STD_LOGIC;
           sum : out  STD_LOGIC);
 
end component;

signal coutaux : STD_LOGIC_VECTOR (3 downto 0); -- sinal de carry auxiliar

begin
-- aqui, é realizada a soma da entrada com o vetor de bits "0000" com carry in de valor '1'
i0 : mod_adder port map (avec(0),'0','1',coutaux(0),res(0));
i1 : mod_adder port map (avec(1),'0',coutaux(0),coutaux(1),res(1));
i2 : mod_adder port map (avec(2),'0',coutaux(1),coutaux(2),res(2));
i3 : mod_adder port map (avec(3),'0',coutaux(2),coutaux(3),res(3));
ovflw <= coutaux(3) xor coutaux(2);
couti <= coutaux(3);

end Behavioral;
