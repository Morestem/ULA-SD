library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_and is
    Port ( s : in  STD_LOGIC_VECTOR (3 downto 0);
           d : in  STD_LOGIC_VECTOR (3 downto 0); -- recebe duas entradas de 4 bits, que serão comparados coma porta lógica AND
           asd : out  STD_LOGIC_VECTOR (3 downto 0);
           zeroflagandc : out STD_LOGIC); -- gera, como saída, o vetor da comparação das entradas e sua flag de zero, em caso de resulato igual a "0000"
end full_and;

architecture Behavioral of full_and is
signal resand : STD_LOGIC_VECTOR(3 downto 0); -- sinal auxiliar para a comparação das entradas

begin
resand <= s AND d; -- entradas são comparadas
asd <= resand;
zeroflagandc <= (resand(0) nor resand(1)) and (resand(2) nor resand(3));
end Behavioral;
