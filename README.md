# PWM_VHDL

Modulação é uma forma básica de transmissão de informações, geralmente embarcando as informações em uma
onda principal, chamada Portadora. Neste projeto, a modulação a ser explorada é a PWM (Pulse-Width
Modulation), ou Modulação por Largura de Pulso. Observe as formas de onda figura a seguir:
<p align="center" >
<img src="https://user-images.githubusercontent.com/65405310/168207910-af3a7a5c-1d7b-4247-afe4-e8b54d4a521f.png">
  </p>
As marcações verticais tracejadas indicam o período do sinal. A modulação do PWM é feita de modo a variar a
largura do sinal, ou seja, a porcentagem do período em que o sinal possui valor ‘1’, no caso digital. Em nosso
projeto, vamos considerar que queremos uma codificação de 8 bits, então a modulação deve ser tal que permita
transmitirmos valores na faixa 0-255.
Os seguintes sinais são necessários em sua DUT:

* Input – (1 bit) CLOCK1 – sinal de clock gerado pelo testbench;
* Input – (8 bits) VALOR - valor a ser modulado;
* Input – (1 bit) RESET - forçando o valor da saída PWM para zero;
* Output – (1 bit) PWM – sinal modulado.
