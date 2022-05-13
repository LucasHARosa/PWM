-- Aluno: Lucas Henrique Alves Rosa
-- Matricula: 180042572
-- Trabalho 5
-- Simulacao de um PWM
-- Periodo do clock = 2500 ns =  2*(variavel periodo) = 2*1025 = 2500 ns
-- Frequencia clock = 244 hz
-- Valor a ser modulado continha 8 bits variando de (0 - 255)
-- Porcentagem PWM = (Valor/ 2**8 - 1) * 100
-- duty cycle = (Valor/2**8 -1) * periodo do clock/2

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity dut_pwm is
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
end dut_pwm;

architecture basic of dut_pwm is
	

	--Copia o valor a ser modulado
   	signal modulado : unsigned(7 downto 0);

	--dut_cycle = (Valor/2**8 -1) * periodo do clock/2
	--dut_cycle contém 11 bits, sendo 1 o bit de sinal, portanto varia de 0 ate 1023
	signal duty_cycle : signed(10 downto 0);

	--Sinal apenas para o PWM comecar com valor 1
	signal saida_pwm : std_logic := '1';
  	
    

	begin
	modulado <= unsigned(valor);
	
	-- Trata o valor pra gerar o valor de duty_cycle
	process (valor)
		variable duty : integer := 0;
		begin
		duty := (to_integer(modulado)*periodo)/255;
		duty_cycle <= to_signed(duty,duty_cycle'length);
		
		
	end process;
	
	--Fluxo de processo:
	--Soma 1 ao contador a cada passagem do clock
	--Se o contador chegar ao valor do periodo ele reinicia a contagem
	--Se reset for acionado o contador volta ao valor zero
	--Se o valor da contagem passar do duty_cycle a saida pwm vai a zero e muda seu estado
	process (clock1)
		variable count : integer := 0;
		begin
		if (rising_edge(clock1)) then
			if (count < to_integer(duty_cycle)) then
				saida_pwm <= '1';
			else
				saida_pwm <= '0';
			end if;
		
			if (reset = '1') then
				count := 0;
			end if;
			
			if(count = (periodo-1)) then
				count := 0;
			else
				count := count +1;
			end if;
		

		end if;
	end process;
	pwm <= saida_pwm;
			
	
		

end basic;