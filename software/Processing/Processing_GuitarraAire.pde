import processing.serial.*;
import processing.sound.*;
SoundFile svab1;
SoundFile svab2;
SoundFile svab3;
SoundFile svab4;
SoundFile svab5;

SoundFile svag1;
SoundFile svag2;
SoundFile svag3;
SoundFile svag4;
SoundFile svag5;

byte leer[] = new byte [5];
int canal[] = new int [5];
int ACEL = 0;        // Canal del acelerometro
int UL = 0;          // Canal del Ultrasonido
int BOTON[] = new int [800];       // Canal del boton del DEMOQE
boolean play = false;              // Permite chequear si cumple una cierta condicion para reproducir el sonido y evitar el bucle con el acelerometro

int i = 0;
boolean j = true;
int c = 0;

int a = 0;

Serial puerto;

void setup(){
  frameRate(120);
  size(400, 400);
  background (255);
  
  svab1  = new SoundFile(this, "SVAB1.wav");
  svab2  = new SoundFile(this, "SVAB2.wav");
  svab3  = new SoundFile(this, "SVAB3.wav");
  svab4  = new SoundFile(this, "SVAB4.wav");
  svab5  = new SoundFile(this, "SVAB5.wav");
  
  svag1  = new SoundFile(this, "SVAG1.wav");
  svag2  = new SoundFile(this, "SVAG2.wav");
  svag3  = new SoundFile(this, "SVAG3.wav");
  svag4  = new SoundFile(this, "SVAG4.wav");
  svag5  = new SoundFile(this, "SVAG5.wav");


  
  
  String portName = Serial.list()[0];
  puerto = new Serial(this, portName,115200);
  puerto.buffer(5);
  
  

}

void draw(){
  
  // Ciclo en donde producira los sonidos 
 //println("acelerometro = "+ACEL);
  println("Ultransonido =" +UL);
 //println("boton ="+c);
  if (i == 0){
    if (c == 16) j = true; // Si el boton se presiona, se vuelve true la variable j, en donde cambia en entre la guitarra y el bajo
    else j = false;
   acel();
  } if (i < 10){
    i++;
  } else i = 0;
}

void serialEvent(Serial puerto){
  if ((puerto.available() > 0) ){
     do {
      leer[0] = byte(puerto.read());
     // println("preuab");
  } while (int(leer[0]) < 255);
  
   leer[1] = byte(puerto.read());
   leer[2] = byte(puerto.read());
   leer[3] = byte(puerto.read());
   leer[4] = byte(puerto.read());
   
  }
 Desempaquetado();
  
}



void Desempaquetado(){
  int aux[] = new int[2];
  aux[0] = leer[1] & byte (15);
  aux[0] = aux[0] << 8;
  aux[1] = leer[2] & 255;
  canal[0] = (aux[0] + aux[1]); // Acelerometro listo
  
  aux[0] = leer[3] & byte (63);
  aux[0] = aux[0] << 8;
  aux[1] = leer[4] & 255;
  canal[1] = (aux[0] + aux[1]); // Ultrasonido listo
  
  aux[0] = leer[1] & byte (16);
  canal[2] = aux[0];             // Boton listo
  
  ACEL = canal[0];
  
  UL = canal[1];
  
  c = canal[2];

}  

void acel(){ //Funcion para accionar la guitarra
  if (ACEL > 2250) {
    
    play = true;
    
  } 
  
  if (ACEL < 1900){
    if (play == true){
      if (j == true){   // Bajo para la cancion "Seven Nation Army" de The White Stripes
      
        svab1.stop();
        svab2.stop();
        svab3.stop();
        svab4.stop();
        svab5.stop();
          if(UL >= 28 && UL <= 36){
            svab4.play();
          }
          else if(UL >= 38 && UL <= 48){
            svab5.play();
          }
          else if(UL >= 18 && UL <= 24){
            svab3.play();
          }
          else if(UL >= 10 && UL <= 17){
            svab1.play();
           }
          else if(UL >= 3 && UL <= 7){
            svab2.play();
          }
      }
       else {  // Guitarra para la cancion "Smoke in the Water" de Deep Purple
      svag1.stop();
      svag2.stop();
      svag3.stop();
      svag4.stop();
      svag5.stop();
      if(UL >= 25 && UL <= 36){
        svag1.play();
      }else if(UL >= 37 && UL <= 70){
        svag5.play();
      }else if(UL >= 18 && UL <= 24){
        svag2.play();
      }else if(UL >= 10 && UL <= 17){
        svag3.play();
      }else if(UL >= 2 && UL <= 7){
        svag4.play();
      } 
      }
  play = false;
  
  }
  }
}
