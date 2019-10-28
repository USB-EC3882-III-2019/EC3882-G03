/* ###################################################################
**     Filename    : main.c
**     Project     : EC3882-G03
**     Processor   : MC9S08QE128CLK
**     Version     : Driver 01.12
**     Compiler    : CodeWarrior HCS08 C Compiler
**     Date/Time   : 2019-09-30, 13:34, # CodeGen: 0
**     Abstract    :
**         Main module.
**         This module contains user's application code.
**     Settings    :
**     Contents    :
**         No public methods
**
** ###################################################################*/
/*!
** @file main.c
** @version 01.12
** @brief
**         Main module.
**         This module contains user's application code.
*/         
/*!
**  @addtogroup main_module main module documentation
**  @{
*/         
/* MODULE main */


/* Including needed modules to compile this module/procedure */
#include "Cpu.h"
#include "Events.h"
#include "TI1.h"
#include "AS1.h"
#include "AD1.h"
#include "D1.h"
#include "D2.h"
#include "boton.h"
#include "boton2.h"
/* Include shared modules, which are used for whole project */
#include "PE_Types.h"
#include "PE_Error.h"
#include "PE_Const.h"
#include "IO_Map.h"



/* User includes (#include below this line is not maintained by Processor Expert) */

void empaquetar(unsigned char b[], unsigned char valor[], unsigned char valor2[]){
	b[0] = 0b11111111 | b[0];// encabezado: ADUANA CETIE
	
	b[2] |=  valor[0]; //preguntar como limitar el tamanio del int guardo los 8 bits en valor
	b[1] |= valor[1];
	
	b[4] |= valor2[0]; //preguntar como limitar el tamanio del int guardo los 8 bits en valor
		b[3] |= valor2[1];
	
	
	
	
}
	

int medir;
//int Z = 0;
unsigned char *olakase;
void main(void)
{
	//VALO[0] | B[2]		VALO[1]  | B[1]
//XXXXXXXX			0000XXXX
	unsigned char valor[2]; // valor[0] = primeros 8 bits del ch1. valor[1] tendra 4 blancos y los 4 restantes de la medicion 
	unsigned char valor2[2];
	unsigned char b[5];
	unsigned char D1;
	unsigned char D2;
  /* Write your local variable definition here */
  /*** Processor Expert internal initialization. DON'T REMOVE THIS CODE!!! ***/
  PE_low_level_init();
  
  /*** End of Processor Expert internal initialization.                    ***/

  /* Write your code here */
  
  /* For example: for(;;) { } */
  for(;;) { 
	  valor[0]=0;
	  valor[1]=0;
	  valor2[0]=0;
	  valor2[1]=0;
	  b[0]=0;
	  b[1]=0;
	  b[2]=0;
	  b[3]=0;
	  b[4]=0;
	  if(medir ==1){
	
	AD1_Measure(TRUE);
/*	AD1_GetChanValue(0, valor); // el valor que arraja el ch1 se guarda en int valor
	AD1_GetChanValue(1, valor2);*/
	//D1 = D1_GetVal();
	//D2 = D2_GetVal();
	
			
	empaquetar(b,valor,valor2);
	
	 if(D1==0){
			b[1] = 0b000010000; //asigno el bit del canal digital al b[1]
		}
		if(D2==0){
				b[3] |= 0b000010000; //asigno el bit del canal digital al b[3]
			}
	// Envio de la data
	
	AS1_SendBlock(b,5, &olakase); // envio de la data para ser procesada
	
	medir =0;
}
  }
  /*** Don't write any code pass this line, or it will be deleted during code generation. ***/
  /*** RTOS startup code. Macro PEX_RTOS_START is defined by the RTOS component. DON'T MODIFY THIS CODE!!! ***/
  #ifdef PEX_RTOS_START
    PEX_RTOS_START();                  /* Startup of the selected RTOS. Macro is defined by the RTOS component. */
  #endif
  /*** End of RTOS startup code.  ***/
  /*** Processor Expert end of main routine. DON'T MODIFY THIS CODE!!! ***/
  for(;;){}
  /*** Processor Expert end of main routine. DON'T WRITE CODE BELOW!!! ***/
} /*** End of main routine. DO NOT MODIFY THIS TEXT!!! ***/

/* END main */
/*!
** @}
*/
/*
** ###################################################################
**
**     This file was created by Processor Expert 10.3 [05.09]
**     for the Freescale HCS08 series of microcontrollers.
**
** ###################################################################
*/
