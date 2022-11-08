library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dobro is
    Port ( q : in  STD_LOGIC_VECTOR (3 downto 0); -- recebe uma entrada de 4 bits
	 resdobro : out STD_LOGIC_VECTOR (3 downto 0);
	 extra : out STD_LOGIC; -- saída para o bit mais significativo após o deslocamento
	 zeroflagdobroc : out STD_LOGIC); -- gera, como saídas, o dobro do valor de entrada e sua flag
	 
end dobro;
architecture Behavioral of dobro is
  
signal resdobroaux : STD_LOGIC_VECTOR(3 downto 0); -- sinal auxiliar do resultado do deslocamento

begin
extra <= q(3); -- MSB é armazenado na saída 'extra'
resdobroaux(3 downto 0) <= q(2 downto 0) & '0'; -- o vetor de entrada é deslocado e o bit '0' é adicionado à sua esquerda
resdobro <= resdobroaux;
zeroflagdobroc <= (resdobroaux(0) nor resdobroaux(1)) and (resdobroaux(2) nor resdobroaux(3));
end Behavioral;
