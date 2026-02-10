#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "alt_types.h"
#include "altera_avalon_pio_regs.h"
int main()
{
 unsigned char switches, rotacion=1, contador=0, parpadeo=0;
 printf("Hello from Nios II!\n");
 printf("EE604 Introduccion a Microcontroladores - 3er Laboratorio 2022-2\n");
 while (1) {
 switches = IORD(SWITCHES_BASE, 0) & 0x0F;
 if(switches & (1<<3)) {//1xxx
	 //parpadeo
	 parpadeo ^= 0xAA;
	 IOWR(LEDS_BASE, 0, parpadeo);
 }else if(switches & (1<<2)) {//01xx
	 //Desplazamiento derecha
	 if(rotacion==1) {
		 rotacion=128;
	 }else{
		 rotacion >>= 1;
	 }
 }else if(switches & (1<<1)) {//001x
	 //Desplazamiento izquierda
	 if(rotacion==128) {
		 rotacion=1;
	 }else{
		 rotacion <<= 1;
	 }
 }else if(switches & (1<<0)) {//0001
	 //cuenta
	 contador++;
 }else{
	 //leds apagados
	 IOWR(LEDS_BASE, 0, 0x00);//0000
 }

 usleep(275*1000);//retardo de aproximadamente 1s
 }
 return 0;
}
