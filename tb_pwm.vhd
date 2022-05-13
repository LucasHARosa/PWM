-- Aluno: Lucas Henrique Alves Rosa
-- Matricula: 180042572
-- Trabalho 5
-- Simulacao de um PWM
-- Periodo do clock = 2500 ns =  2*(variavel periodo) = 2*1025 = 2500 ns
-- Frequencia clock = 244 hz
-- Valor a ser modulado continha 8 bits variando de (0 - 255)
-- Porcentagem PWM = (Valor/ 2**8 - 1) * 100
-- duty cycle = (Valor/2**8 -1) * periodo do clock/2


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_pwm is
	generic(
		--periodo do clock/2
		periodo : INTEGER := 1025
	);

end entity;

architecture sim of tb_pwm is
	component dut_pwm is
		generic(
			--periodo do clock/2
			periodo : INTEGER := 1025
		);
		port(
			--Relogio
	    		clock1     : in std_logic;
			--Valor a ser modulado
       			valor      : in std_logic_vector(7 downto 0);
			--botao reset para pwm voltar ao valor '0'
			reset	   : in std_logic;
			--saida do sinal
			pwm	   : out std_logic
    		);
	end component;
	

	signal clock1     : std_logic;
    	signal valor      : std_logic_vector(7 downto 0);
    	signal reset 	  : std_logic;
	signal pwm        : std_logic;

begin
my_pwm: dut_pwm
	port map(
		clock1 => clock1,
        	valor => valor,
        	reset => reset,
		pwm => pwm
	);

	
	--clock vai mover o sistema a cada 2 ns
	process is
		begin
			clock1 <= '0';
			wait for 1 ns;
			clock1 <= '1';
			wait for 1 ns;
	end process;
	
	-- Teste para todos os valores de 0 ate 255
	process is
		begin	
			for A in 0 to 2**8-1 loop
				valor <= std_logic_vector(to_unsigned(A,valor'length));
				reset <= '0';
				wait for 2048 ns;
				reset <= '1';
				wait for 2 ns;
			end loop;
	end process;


end architecture;

