library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_or is
    Port ( l : in  STD_LOGIC_VECTOR (3 downto 0);
           p : in  STD_LOGIC_VECTOR (3 downto 0); -- recebe duas entradas de 4 bits e as compara com a porta lógica OR
           resor : out  STD_LOGIC_VECTOR (3 downto 0);
           zeroflagorc : out STD_LOGIC); --  gera, como saída, o resultado da comparação das entradas e a flag zero, em caso de resultado igual a "0000"
end full_or;

architecture Behavioral of full_or is
signal resoraux : STD_LOGIC_VECTOR(3 downto 0); -- sinal auxiliar para a comparação das entradas
begin
resoraux <= l OR p; -- entradas são comparadas
resor <= resoraux;
zeroflagorc <= (resoraux(0) nor resoraux(1)) and (resoraux(2) nor resoraux(3));
end Behavioral;
