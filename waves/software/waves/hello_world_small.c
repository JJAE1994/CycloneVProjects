#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "alt_types.h"
#include "altera_avalon_pio_regs.h"

#define ADC_ADDR 0x08001000
#define DAC_ADDR 0x08001020
#define LED_ADDR 0x08001030
#define SWS_ADDR 0x08001040



int main()
{
 unsigned int wave1[4096];
 unsigned int wave2[8190];
 int i=0;
 volatile int * adc = (int*)(ADC_ADDR);
 unsigned int data, switches;
 int channel=0;
 data = 0;
 double voltaje;

 //Diente de sierra
 for(i=0;i<4096;i++) {
		 wave1[i]=i;
 }

 //Señal triangular
 for(i=0;i<8190;i++) {
	 if(i<4096) {
		 wave2[i]=i;
	 }else{
		 wave2[i]=8190 - i;
	 }
 }

/*
 *  k = Vref/2(12)
 *  vin = k[D]
 *  Vref = 4.096 V
 *  k = 0.001
 *  [D] = vin/k = 2.5V/0.001 = 2500
 */

 while (1){
	 *(adc) = 0; //Inicializo lectura del ADC
	 data = *(adc+channel); //Capturo el valor del canal seleccionado
	 if (data<2500){
		 //barriendo wave1
		 for(i=0;i<4096;i++) {
			 IOWR(DAC_ADDR, 0, wave1[i]);
		 }

	 }else{
		 //barriendo wave2
		 for(i=0;i<8190;i++) {
			 IOWR(DAC_ADDR, 0, wave2[i]);
		 }

	 }
	 switches = IORD(SWS_ADDR, 0);//lectura de switches
	 IOWR(LED_ADDR, 0, switches);//escritura del valor de switches en los leds
	 voltaje = data*0.001;
	 //printf("%d\n\r", data);
	 printf("%.2f\n\r", voltaje);//Valor analogico leido
 }
 return 0;
}
