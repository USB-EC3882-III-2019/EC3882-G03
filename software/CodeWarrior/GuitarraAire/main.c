/* ###################################################################
**     Filename    : main.c
**     Project     : Guitarra de Aire
**     Processor   : MC9S08QE128CLK
**     Version     : Driver 01.12
**     Compiler    : CodeWarrior HCS08 C Compiler
**     Date/Time   : 2019-11-11, 13:14, # CodeGen: 0
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
#include "Bit2.h"
#include "TI1.h"
#include "AS1.h"
#include "AD1.h"
#include "Cap1.h"
#include "PWM1.h"
#include "Bit1.h"
#include "boton.h"
#include "Led.h"
#include "KB1.h"
/* Include shared modules, which are used for whole project */
#include "PE_Types.h"
#include "PE_Error.h"
#include "PE_Const.h"
#include "IO_Map.h"

/* User includes (#include below this line is not maintained by Processor Expert) */
  	
  	  void empaquetado(unsigned char b[], unsigned char valor[], unsigned char capture[], unsigned int boton)
	  {
		b[0] = 0b11111111 | b[0];// encabezado: ADUANA CETIE
			
			b[1] |=  valor[0] ;
			b[2] |= valor[1] ;
			b[3] |= capture[0];
			b[4] |= capture[1] ;
			if(boton == 1){
				b[1] |= 0b00010000;}
	  }
  	  
  	int medir;
  	unsigned char* olakase;
  	unsigned char capture[2];
  	unsigned int boton = 0;
void main(void)
{
  /* Write your local variable definition here */

unsigned char valor[2];
unsigned char b[5];


//empaquetado aqui


  /*** Processor Expert internal initialization. DON'T REMOVE THIS CODE!!! ***/
  PE_low_level_init();
  /*** End of Processor Expert internal initialization.                    ***/

  /* Write your code here */
  
  /* For example: for(;;) { } */
  	  for(;;){
  		  
  		  if(medir == 1){
  			//inicializacion de las variables
  			  		  valor[0]=0;
  			  		  valor[1]=0;
  			  		  b[0]=0;
  			  		  b[1]=0;
  			  		  b[2]=0;
  			  		  b[3]=0;
  			  		  b[4]=0;  			  		  //capture= capture/58;D1_GetVal();
  			  		   
  			AD1_MeasureChan(TRUE,0); 
  			AD1_GetChanValue(0,valor);
  			empaquetado(b,valor,capture,boton);
  			AS1_SendBlock(b,5,&olakase);
  			medir=0;
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
