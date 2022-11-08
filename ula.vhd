library ieee;
use ieee.std_logic_1164.all;

entity ULA is
port    (x, y: in std_logic_vector (3 downto 0); -- recebe duas entradas de 4 bits
        sel: in std_logic_vector (2 downto 0); -- recebe uma entrade de 3 bits para a seleção da operação
        overflow, zeroflag, signflag, coutflag : out std_logic; -- flags de saída
        z: out std_logic_vector (3 downto 0)); -- saída de 4 bits com o resultado da operação
end ULA;

architecture behavioral of ULA is
        signal resultsoma, resultsub, resultinc, resultsc, resultdobro, resultfulland,
        resultfullor, resultmetade: std_logic_vector (3 downto 0); -- sinais dos resultados das operações
        signal coutsc, signflagsc, extrabitdobro,coutsoma, zeroflagsub, overflowinc, overflowsoma, overflowsub, zeroflagsoma,
        zeroflagdobro, zeroflagmetade, zeroflagand, zeroflagor, coutsub, coutinc, signalflags : std_logic; -- sinais das flags de todas as operações
	 
        component full_adder4b is -- módulo somador
        Port (
            vetorbits1 : in STD_LOGIC_VECTOR (3 downto 0);
            vetorbits2 : in STD_LOGIC_VECTOR (3 downto 0);
            resultado : out STD_LOGIC_VECTOR (3 downto 0);
            zeroflag : out  STD_LOGIC;
            cout : out STD_LOGIC;
            overflow : out  STD_LOGIC);
        end component;
        
                component full_sub4b is -- módulo subtrator
        Port (
           avec : in  STD_LOGIC_VECTOR (3 downto 0);
           bvec : in  STD_LOGIC_VECTOR (3 downto 0);
           zeroflag : out  STD_LOGIC;
           res : out  STD_LOGIC_VECTOR (3 downto 0);
           signalflagsu : out STD_LOGIC;
           couts : out STD_LOGIC;
           overflows : out STD_LOGIC);
        end component;
        
                component increment is -- módulo incremento
        Port ( avec : in  STD_LOGIC_VECTOR (3 downto 0);
             res : out  STD_LOGIC_VECTOR (3 downto 0);
             ovflw : out  STD_LOGIC;
             couti : out STD_LOGIC);
        end component;
        
                component signchange is -- módulo troca de sinal
        Port (
           an : in STD_LOGIC_VECTOR (3 downto 0);
           res : out STD_LOGIC_VECTOR (3 downto 0);
           signflag : out STD_LOGIC;
           coutsign : out STD_LOGIC);
        end component;
        
        component dobro -- módulo dobro(shift left)
      Port ( q : in  STD_LOGIC_VECTOR (3 downto 0);
  	 resdobro : out STD_LOGIC_VECTOR (3 downto 0);
  	 extra : out STD_LOGIC;
  	 zeroflagdobroc : out STD_LOGIC);
  end component;
        
        component full_and is -- módulo AND bit a bit
        Port ( s : in  STD_LOGIC_VECTOR (3 downto 0);
           d : in  STD_LOGIC_VECTOR (3 downto 0);
           asd : out  STD_LOGIC_VECTOR (3 downto 0);
           zeroflagandc : out STD_LOGIC);
        end component;
        
        component full_or is -- módulo OR bit a bit
         Port ( l : in  STD_LOGIC_VECTOR (3 downto 0);
           p : in  STD_LOGIC_VECTOR (3 downto 0);
           resor : out  STD_LOGIC_VECTOR (3 downto 0);
           zeroflagorc : out STD_LOGIC);
        end component;
        
        component metade is -- módulo metade(shift right)
        Port ( r : in  STD_LOGIC_VECTOR (3 downto 0);
	 resmetade : out STD_LOGIC_VECTOR (3 downto 0);
	 zeroflagmet : out STD_LOGIC);
	   end component;


        begin 
        -- aqui, todas as operações são realizadas previamente à seleção do resultado a ser mostrado
                op1: full_adder4b port map (x, y, resultsoma, zeroflagsoma, coutsoma, overflowsoma);
                op2: full_sub4b port map (x, y, zeroflagsub, resultsub, signalflags, coutsub, overflowsub);
                op3: increment port map (x, resultinc, overflowinc, coutinc);
                op4: signchange port map (x, resultsc, signflagsc, coutsc);
                op5: dobro port map (x, resultdobro, extrabitdobro, zeroflagdobro);
                op6: full_and port map (x, y, resultfulland, zeroflagand);
                op7: full_or port map (x, y, resultfullor, zeroflagor);
                op8: metade port map (x, resultmetade, zeroflagmetade);
                     
        process (sel, resultsoma, resultsub, resultinc, resultsc, resultdobro, resultfulland,
        resultfullor, resultmetade)
        begin
        -- aqui, é feita a seleção e a atribuição de valores às saídas que serão mostradas nos LEDs da placa
                if sel = "000" then -- seleciona os resultados da soma
                        z <= resultsoma;
                        overflow <= overflowsoma;
                        coutflag <= coutsoma;
                        zeroflag <= zeroflagsoma;
                        signflag <= '0';
                elsif sel = "001" then -- seleciona os resultados da subtração
                        z <= resultsub;
                        overflow <= overflowsub;
                        coutflag <= coutsub;
                        zeroflag <= zeroflagsub;
                        signflag <= signalflags;
                elsif sel = "010" then -- seleciona os resultados do incremento
                        z <= resultinc;
                        overflow <= overflowinc;
                        coutflag <= coutinc;
                        zeroflag <= '0';
                        signflag <= '0';
                elsif sel = "011" then -- seleciona os resultados da troca de sinal
                        z <= resultsc;
                        overflow <= '0';
                        coutflag <= coutsc;
                        zeroflag <= '0';
                        signflag <= signflagsc;
                elsif sel = "100" then -- seleciona os resultados do shift left
                        z <= resultdobro;
                        overflow <= '0';
                        coutflag <= extrabitdobro;
                        zeroflag <= zeroflagdobro;
                        signflag <= '0';
                elsif sel = "101" then -- seleciona os resultados da operação AND bit a bit
                        z <= resultfulland;
                        overflow <= '0';
                        coutflag <= '0';
                        zeroflag <= zeroflagand;
                        signflag <= '0';
                elsif sel = "110" then -- seleciona os resultados da operação OR bit a bit
                        z <= resultfullor;
                        overflow <= '0';
                        coutflag <= '0';
                        zeroflag <= zeroflagor;
                        signflag <= '0';
                elsif sel = "111" then -- seleciona os resultados do shift right
                        z <= resultmetade;
                        overflow <= '0';
                        coutflag <= '0';
                        zeroflag <= zeroflagmetade;
                        signflag <= '0';
                end if;
        end process;
end behavioral;
