library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity metade is
    Port ( r : in  STD_LOGIC_VECTOR (3 downto 0); -- recebe uma entrada de 4 bits e retorna o valor inicial dividido por 2 e aproximado à parte inteira da divisão com o deslocamento para a esquerda
	 resmetade : out STD_LOGIC_VECTOR (3 downto 0);
	 zeroflagmet : out STD_LOGIC); -- gera, como saída, o resultado da divisão por 2 e a flag zero, em caso de resultado igual a "0000"
end metade;
  
architecture Behavioral of metade is
signal resmetadeaux : STD_LOGIC_VECTOR(3 downto 0); -- sinal auxiliar para o resultado do deslocamento
begin

resmetadeaux(3 downto 0) <= '0' & r(3 downto 1); -- valor de entrada é deslocado para a esquerda e e tem o bit '0' adicionado à sua direita
resmetade <= resmetadeaux;
zeroflagmet <= (resmetadeaux(0) nor resmetadeaux(1)) and (resmetadeaux(2) nor resmetadeaux(3));
end Behavioral;
