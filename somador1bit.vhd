library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MOD_ADDER is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC; 
           cin : in  STD_LOGIC; -- recebe três entradas de 1 bit(2 operandos e um carry) e realiza a operação de soma com elas
           cout : out  STD_LOGIC;
           sum : out  STD_LOGIC); -- gera, como saída, a soma das entradas, bem como o valor de carry out da operação
end MOD_ADDER;

architecture Behavioral of MOD_ADDER is

begin

sum <= a XOR b XOR cin;
cout <= (a AND b) or (b AND cin) or (a AND cin);

end Behavioral;
