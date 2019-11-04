import processing.serial.*;

byte leer[];
int canal[];
int CH1[];      // Canal analogico 1
int CH2[];      // Canal analogico 2
int D1[];       // Canal digital 1
int D2[];       // Canal digital 2

int ts = 1;     // Tiempo de muestreo (timescale): 1 = 50ms, 5 = 10ms, 10 = 5ms, 50 = 1ms, 100 = 500us, 500 = 100us , 1000 = 50us
float ch1v = 0.5;  // Canal analogico 1 : voltaje por division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2v/div , 2 = 5V/div
float ch2v = 0.5;  // Canal analogico 2 : voltaje por division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2v/div , 2 = 5V/div
float d1v  = 0.5;  // Canal digital 1 : voltaje por division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2v/div , 2 = 5V/div
float d2v  = 0.5;  // Canal digital 2 : voltaje por division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2v/div , 2 = 5V/div

int i = 0;          //Variable para pintar 
int j = 0;          // variable de control indicativa de los arreglos con data para mostrar 

int circleSize=40;// tamaño del boton
int ledSize=10; // tamaño del led
int CH1divPosX, CH1divPosY;
int CH2divPosX, CH2divPosY;
int CD1divPosX, CD1divPosY;
int CD2divPosX, CD2divPosY;
int TsPosX, TsPosY;

color CH1divColor, CH2divColor, CD1divColor, CD2divColor, TsColor;

int CH1PosX, CH1PosY; //Posiciones del boton del Canal analogico 1
int CH2PosX, CH2PosY; //Posiciones del boton del Canal analogico 2
int CD1PosX, CD1PosY; //Posiciones del boton del Canal digital 1
int CD2PosX, CD2PosY; //Posiciones del boton del Canal digital 2

color CH1Color, CH2Color, CD1Color, CD2Color;
color Sobreboton;

boolean CH1Sobre = false;      //Indica si el puntero se encuentra sobre el boton del canal analogico 1
boolean CH2Sobre = false;      //Indica si el puntero se encuentra sobre el boton del canal analogico2
boolean CD1Sobre = false;      //Indica si el puntero se encuentra sobre el boton del canal digital 1
boolean CD2Sobre = false;      //Indica si el puntero se encuentra sobre el boton del canal digital 1

boolean CH1divSobre = false;   //Indica si el puntero se encuentra sobre el boton de vol/div canal analogico 1  
boolean CH2divSobre = false;   //Indica si el puntero se encuentra sobre el boton de vol/div canal analogico 2  
boolean CD1divSobre = false;   //Indica si el puntero se encuentra sobre el boton de vol/div canal digital 1  
boolean CD2divSobre = false;   //Indica si el puntero se encuentra sobre el boton de vol/div canal digital 2  
boolean TSSobre;

boolean CH1ON = false;         //Indica si la variable de estado del canal analogico 1 esta activo o apagado
boolean CH2ON = false;         //Indica si la variable de estado del canal analogico 2 esta activo o apagado
boolean CD1ON = false;         //Indica si la variable de estado del canal digital 1 esta activo o apagado
boolean CD2ON = false;         //Indica si la variable de estado del canal digital 2 esta activo o apagado

// leds indicadores de las divisiones
color ch1led1v, ch1led2v, ch1led5v, ch1led10v;
color ch2led1v, ch2led2v, ch2led5v, ch2led10v;
color d1led1v, d1led2v, d1led5v, d1led10v;
color d2led1v, d2led2v, d2led5v, d2led10v;

// leds Ts

color ms50, ms10, ms5, ms1, us500;
Serial puerto;
 
 PImage screen;

void setup() {
  size(1280, 800);
  background(#522C1B);
  //Inicializacion de los botones de escalas y Ts
  CH1divPosX = 1000; 
  CH1divPosY = 50;
  CH2divPosX = 1000; 
  CH2divPosY = 150;
  CD1divPosX = 1000; 
  CD1divPosY = 250;
  CD2divPosX = 1000; 
  CD2divPosY = 350;
  TsPosX = 925;
  TsPosY = 550;
  CH1divColor = CH2divColor = CD1divColor= CD2divColor =TsColor = color(#BFBBBB);
  //Inicializacion de los botones de los canales
  CH1PosX = 150;
  CH1PosY = 700;
  CH2PosX = 350;
  CH2PosY = 700;
  CD1PosX = 550;
  CD1PosY = 700;
  CD2PosX = 750;
  CD2PosY = 700;
  CH1Color = CH2Color= CD1Color =CD2Color = color(#BFBBBB);
  pantalla ();
  Sobreboton = color(#5A5D58);
  
  //Texto
  textSize(30);
  fill(255);
  text("Osciloscopio", 360, 30);
  fill(255);
  text("Ts", 910, 615);
  textSize(20);
   fill(255);
  text("Escalas",1080,30);
  textSize(15);
  fill(255);
  text("CH1",135,675);
   fill(255);
  text("CH2",335,675);
   fill(255);
  text("CD1",535,675);
   fill(255);
  text("CD2",735,675);
  fill(255);
  text("CH1Div",995,115);
  fill(255);
  text("CH2Div",995,215);
  fill(255);
  text("CD1Div",995,315);
  fill(255);
  text("CD2Div",995,415);
  
  // leds
  fill(255);
  text("0.5",1065,405);
  fill(255);
  text("1",1095,405);
  fill(255);
  text("2",1125,405);
  fill(255);
  text("5",1155,405);
  
   fill(255);
  text("0.5",1065,305);
  fill(255);
  text("1",1095,305);
  fill(255);
  text("2",1125,305);
  fill(255);
  text("5",1155,305);
  
   fill(255);
  text("0.5",1065,205);
  fill(255);
  text("1",1095,205);
  fill(255);
  text("2",1125,205);
  fill(255);
  text("5",1155,205);
  
   fill(255);
  text("0.5",1065,105);
  fill(255);
  text("1",1095,105);
  fill(255);
  text("2",1125,105);
  fill(255);
  text("5",1155,105);
  
  // TS
   fill(255);
  text("50ms", 1020, 510);
   fill(255);
  text("10ms", 1020, 540);
   fill(255);
  text("5ms", 1020, 570);
   fill(255);
  text("1ms", 1020, 600);
   fill(255);
  text("500us", 1020, 630);
 //  fill(255);
  //text("100us", 1020, 660);
  // fill(255);
 // text("50us", 1020, 690);
  
  pantalla();
  screen = get(50,0,801,650);
  
  //leds
 ch1led1v =  ch1led5v = ch1led10v = ch2led1v =  ch2led5v = ch2led10v = d1led1v =  d1led5v = d1led10v = d2led1v =  d2led5v = d2led10v =  ms10 = ms5 = ms1 = us500 = color(0);
 
 ch1led2v = ch2led2v = d1led2v = d2led2v = ms50 = color(#5AFF03);
  // Rellenamos de informacion "0" para que no tengan basura
  
  leer =  new byte[5];  
  canal = new int [5];
  CH1 =   new int [800];
  CH2 =   new int [800];
  D1 =    new int [800];
  D2 =    new int [800];
  
  
  
String portName= Serial.list()[0];
 puerto = new Serial(this, portName, 115200);
 puerto.buffer(1000);
 image(screen,50,0);
}


void draw(){
  
  //Dibujo de los botones de las escalas y Ts
  
  
  //Dibujo de los botones de los canales
  Botones();
  
  //Dibujado de las graficas de cada canal
  if(j==1){
    
    image(screen,50,0); // limpia la pantalla
    
    // Graficas 
    if(CH1ON == true) 
    ch1();
    if(CH2ON == true) 
    ch2();
    if(CD1ON == true) 
    d1();
    if(CD2ON == true) 
    d2();
    
   i = 0;
   j = 0;
  }
} 
boolean sobreCirculo(int x, int y, int diametro){
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diametro/2 ) {
    return true;
  } else {
    return false;
  }
 
}

boolean sobreRect(int x, int y, int largo, int altura)  {
  if (mouseX >= x && mouseX <= x+largo && 
      mouseY >= y && mouseY <= y+altura) {
    return true;
  } else {
    return false;
  }
}

void update(int x, int y){  
  
 if ( sobreCirculo(CH1PosX, CH1PosY, circleSize) ) {
    CH1Sobre = true;
    CH2Sobre = false;
    CD1Sobre = false;
    CD2Sobre = false;
       
  } else if ( sobreCirculo(CH2PosX, CH2PosY, circleSize) ) {
    CH1Sobre = false;
    CH2Sobre = true;
    CD1Sobre = false;
    CD2Sobre = false;
       
  } else if ( sobreCirculo(CD1PosX, CD1PosY, circleSize) ) {
    CH1Sobre = false;
    CH2Sobre = false;
    CD1Sobre = true;
    CD2Sobre = false;
       
  } else if ( sobreCirculo(CD2PosX, CD2PosY, circleSize) ) {
    CH1Sobre = false;
    CH2Sobre = false;
    CD1Sobre = false;
    CD2Sobre = true;
    //CUADRADOS   
  } else if ( sobreRect(CH1divPosX, CH1divPosY, circleSize, circleSize) ) {
    CH1divSobre = true;
    CH2divSobre = false;
    CD1divSobre = false;
    CD2divSobre = false;
  } else if ( sobreRect(CH2divPosX, CH2divPosY, circleSize, circleSize) ) {
    CH1divSobre = false;
    CH2divSobre = true;
    CD1divSobre = false;
    CD2divSobre = false;
  }else if ( sobreRect(CD1divPosX, CD1divPosY, circleSize, circleSize) ) {
    CH1divSobre = false;
    CH2divSobre = false;
    CD1divSobre = true;
    CD2divSobre = false;
  } else if ( sobreRect(CD2divPosX, CD2divPosY, circleSize, circleSize) ) {
    CH1divSobre = false;
    CH2divSobre = false;
    CD1divSobre = false;
    CD2divSobre = true;
  } else if (sobreCirculo(TsPosX, TsPosY, 70)){ TSSobre = true;}
  else {
    CH1Sobre = CH2Sobre = CD1Sobre =CD2Sobre = CH1divSobre = CH2divSobre = CD1divSobre = CD2divSobre = TSSobre = false;
  }
 
 }


void Botones(){
  update(mouseX, mouseY);
   if (CH1Sobre) {
    fill(Sobreboton);
  } else {
    fill(CH1Color);
  }
   stroke(0);
  ellipse(CH1PosX,CH1PosY,circleSize, circleSize);
  
   if (CH2Sobre) {
    fill(Sobreboton);
  } else {
    fill(CH2Color);
  }
  stroke(0);
  ellipse(CH2PosX,CH2PosY,circleSize, circleSize);
  
   if (CD1Sobre) {
    fill(Sobreboton);
  } else {
    fill(CD1Color);
  }
  stroke(0);
  ellipse(CD1PosX,CD1PosY,circleSize, circleSize);
 
   if (CD2Sobre) {
    fill(Sobreboton);
  } else {
    fill(CD2Color);
  }
   stroke(0);
  ellipse(CD2PosX,CD2PosY,circleSize, circleSize);
  
   if (CH1divSobre) {
    fill(Sobreboton);
  } else {
    fill(CH1divColor);
  }
    stroke(0);
  rect(CH1divPosX,CH1divPosY, 40, 40);
  
  if (CH2divSobre) {
    fill(Sobreboton);
  } else {
    fill(CH2divColor);
  }
  stroke(0);
  rect(CH2divPosX,CH2divPosY, 40, 40);
  
  if (CD1divSobre) {
    fill(Sobreboton);
  } else {
    fill(CD1divColor);
  }
   stroke(0);
  rect(CD1divPosX,CD1divPosY, 40, 40);
  
  if (CD2divSobre) {
    fill(Sobreboton);
  } else {
    fill(CD2divColor);
  }
   stroke(0);
  rect(CD2divPosX,CD2divPosY, 40, 40);
  
   stroke(0);
  if(TSSobre)
    fill(Sobreboton);
   else  fill(TsColor);
  ellipse(TsPosX,TsPosY, 70, 70);
  
  //Leds
 
 
// Canal 1

  stroke(255);
  fill(ch1led1v);
  ellipse(CH1divPosX + 70,CH1divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(ch1led2v);
  ellipse(CH1divPosX + 100,CH1divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(ch1led5v);
  ellipse(CH1divPosX + 130,CH1divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(ch1led10v);
  ellipse(CH1divPosX + 160,CH1divPosY + 20,ledSize, ledSize);
  
  
 //Canal 2
 
  stroke(255);
  fill(ch2led1v);
  ellipse(CH2divPosX + 70,CH2divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(ch2led2v);
  ellipse(CH2divPosX + 100,CH2divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(ch2led5v);
  ellipse(CH2divPosX + 130,CH2divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(ch2led10v);
  ellipse(CH2divPosX + 160,CH2divPosY + 20,ledSize, ledSize);
  
  //Digital 1
  stroke(255);
  fill(d1led1v);
  ellipse(CD1divPosX + 70,CD1divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(d1led2v);
  ellipse(CD1divPosX + 100,CD1divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(d1led5v);
  ellipse(CD1divPosX + 130,CD1divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(d1led10v);
  ellipse(CD1divPosX + 160,CD1divPosY + 20,ledSize, ledSize);
 
  //Digital 2
  
  stroke(255);
  fill(d2led1v);
  ellipse(CD2divPosX + 70,CD2divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(d2led2v);
  ellipse(CD2divPosX + 100,CD2divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(d2led5v);
  ellipse(CD2divPosX + 130,CD2divPosY + 20,ledSize, ledSize);
  stroke(255);
  fill(d2led10v);
  ellipse(CD2divPosX + 160,CD2divPosY + 20,ledSize, ledSize);
  
  // TS
  stroke(255);
  fill(ms50);
  ellipse(990, 505, ledSize, ledSize);
   stroke(255);
  fill(ms10);
  ellipse(990, 535, ledSize, ledSize);
   stroke(255);
  fill(ms5);
  ellipse(990, 565, ledSize, ledSize);
   stroke(255);
  fill(ms1);
  ellipse(990, 595, ledSize, ledSize);
   stroke(255);
  fill(us500);
  ellipse(990, 625, ledSize, ledSize);
   stroke(255);

}

void mouseClicked(){
  if(CH1Sobre){
    CH1Color= Sobreboton;
    CH2Color= CD1Color = CD2Color= color(#BFBBBB);
    if(CH1ON == false) {      
      CH1ON = true;        
    } else {CH1ON = false;}
  }
  
 if(CH2Sobre){
    CH2Color= Sobreboton;
    CH1Color= CD1Color = CD2Color= color(#BFBBBB);
    if(CH2ON == false) {      
      CH2ON = true;        
    } else {CH2ON = false;}
  }
   if(CD1Sobre){
    CD1Color= Sobreboton;
    CH1Color= CH2Color = CD2Color= color(#BFBBBB);
    if(CD1ON == false) {      
      CD1ON = true;        
    } else {CD1ON = false;}
  }
   
   if(CD2Sobre){
    CD2Color= Sobreboton;
    CH1Color= CH2Color = CD1Color= color(#BFBBBB);
    if(CD2ON == false) {      
      CD2ON = true;        
    } else {CD2ON = false;}
  }
  
  // escalas
  if(CH1divSobre){
    if(ch1v == 0.5){
      ch1v=5;
      ch1led1v = color(#5AFF03);
      ch1led2v = ch1led5v = ch1led10v = color(0);
      
  } else if(ch1v ==5){
      ch1v=2;
      ch1led2v = color(#5AFF03);
      ch1led1v = ch1led5v = ch1led10v = color(0);
      
  } else if(ch1v ==2){
      ch1v=1;
      ch1led5v = color(#5AFF03);
      ch1led1v = ch1led2v = ch1led10v = color(0);
      
  } else if(ch1v ==1){
      ch1v=0.5;
      ch1led10v = color(#5AFF03);
      ch1led1v = ch1led2v = ch1led5v = color(0);
      
  } 
  
}
if(CH2divSobre){
    if(ch2v == 0.5){
      ch2v=5;
      ch2led1v = color(#5AFF03);
      ch2led2v = ch2led5v = ch2led10v = color(0);
      
  } else if(ch2v ==5 ){
      ch2v=2;
      ch2led2v = color(#5AFF03);
      ch2led1v = ch2led5v = ch2led10v = color(0);
      
  } else if(ch2v ==2){
      ch2v=1;
      ch2led5v = color(#5AFF03);
      ch2led1v = ch2led2v = ch2led10v = color(0);
      
  } else if(ch2v ==1){
      ch2v=0.5;
      ch2led10v = color(#5AFF03);
      ch2led1v = ch2led2v = ch2led5v = color(0);
      
  } 
  
}
if(CD1divSobre){
    if(d1v ==0.5){
      d1v=5;
      d1led1v = color(#5AFF03);
      d1led2v = d1led5v = d1led10v = color(0);
      
  } else if(d1v ==5){
      d1v=2;
      d1led2v = color(#5AFF03);
      d1led1v = d1led5v = d1led10v = color(0);
      
  } else if(d1v ==2){
      d1v=1;
      d1led5v = color(#5AFF03);
      d1led1v = d1led2v = d1led10v = color(0);
      
  } else if(d1v ==1){
      d1v=0.5;
      d1led10v = color(#5AFF03);
      d1led1v = d1led2v = d1led5v = color(0);
      
  } 
  
}
  if(CD2divSobre){
      if(d2v ==0.5){
        d2v=5;
        d2led1v = color(#5AFF03);
        d2led2v = d2led5v = d2led10v = color(0);
        
    } else if(d2v ==5){
        d2v=2;
        d2led2v = color(#5AFF03);
        d2led1v = d2led5v = d2led10v = color(0);
        
    } else if(d2v ==2){
        d2v=1;
        d2led5v = color(#5AFF03);
        d2led2v = d2led2v = d2led10v = color(0);
        
    } else if(d2v ==1){
        d2v=0.5;
        d2led10v = color(#5AFF03);
        d2led2v = d2led2v = d2led5v = color(0);
        
    } 
    
  }

   if(TSSobre){
     if(ts== 100){
       ts = 1;
       ms50 = color(#5AFF03);
       ms10= ms5= ms1= us500 = color(0);
     } else if(ts== 1){
       ts = 5;
       ms10 = color(#5AFF03);
       ms50= ms5= ms1= us500 = color(0);
     } else if(ts== 5){
       ts = 10;
       ms5 = color(#5AFF03);
       ms10= ms50= ms1= us500 = color(0);
     } else if(ts== 10){
       ts = 50;
       ms1 = color(#5AFF03);
       ms10= ms50= ms5= us500 = color(0);
     } else if(ts== 50){
       ts = 100;
       us500 = color(#5AFF03);
       ms10= ms5= ms1= ms50 = color(0);
     } 
}
}
void pantalla(){  //Funcion para definir la pantalla del osciloscopio
  stroke(255);
  fill(0);
  rect(50,50, 800, 600);
  
  for(int y=50; y<=650; y+=100){
    for (int x=50; x<=850; x+=20){
      stroke(255);
      line(x-1,y,x+1,y);
    }
  }
  for(int y=50; y<=650; y+=20){
    for (int x=50; x<=850; x+=100){
      stroke(255);
      line(x,y-1,x,y+1);
    }
  }
  for(int y=50; y<=650; y+=20){
    for (int x=50; x<=850; x+=20){
      stroke(255);
      line(445,y,455,y);
      line(x,345,x,355);
    }
  }
}

void serialEvent(Serial puerto)  {
  
 if ((puerto.available() > 0) && (j==0)) {
   do {
     leer[0] = byte(puerto.read());
   }  while(int(leer[0]) < 255);
 
   leer[1] = byte(puerto.read());
   leer[2] = byte(puerto.read());
   leer[3] = byte(puerto.read());
   leer[4] = byte(puerto.read());
    
 }

  if (j == 0){
    Desempaquetado();
    //print(" ( "+ int(leer[0]) + " "+ int(leer[1]) +" "+ int(leer[2]) +" "+ int(leer[3]) +" ) ");
 } 
}



void Desempaquetado(){
  int aux[]= new int[2];
  aux[0]  =  leer[1] & byte(15);
  aux[0]  = aux[0] << 8;
  aux[1] = leer[2] & 255;
  canal[0] = (aux[0] + aux[1])/13;  // Canal analogico 1 listo
  println("analogico = "+ canal[0]);
  aux[0]  =  leer[3] & byte(15);
  aux[0]  = aux[0] << 8;
  aux[1] = leer[4] & 255;
  canal[1] = (aux[0] + aux[1])/13;  // Canal analogico 2 listo, 
  
 
  aux[0] = leer[1]  & byte(16);
  canal[2] = aux[0] * 5;
  
  aux[1] = leer[3]  & byte(16);
  canal[3] = aux[1] *5;
  
  //Los canal[] se le multiplica una constate para que de la escala correcta en el osciloscopio
  
  // asignacion de los canales
  
  CH1[i] = canal[0];
  CH2[i] = canal[1];
  D1[i]  = canal[2];
  D2[i]  = canal[3];
  i= i+1;
  
  if(i >799){
    j=1;
  }
}
// graficas

void ch1(){
  for (int x = 50; x < 849; x += 1) {  
    stroke(color(255,0,0));
     if ((((x-50)*ts)+50) < 850 && (350 - CH1[(x+1)-50]*ch1v/2) > 51 && (350 - CH1[x-50]*ch1v/2) > 50){
      line ((((x-50)*ts)+50), 350 - CH1[x-50]*ch1v/2, (((x+1-50)*ts)+50), 350 - CH1[(x-50+1)]*ch1v/2);
     }
  }
}

void ch2(){
  for (int x = 50; x < 849; x += 1) {
    stroke(color(0,255,0));
     if ((((x-50)*ts)+50) < 850 && (350 - CH2[(x+1)-50]*ch2v/2) > 51 && (350 - CH2[x-50]*ch2v/2) > 50 )
       line ((((x-50)*ts)+50), 350 - CH2[x-50]*ch2v/2, (((x+1-50)*ts)+50), 350 - CH2[(x+1)-50]*ch2v/2);
  }
}

void d1(){
  for (int x = 50; x < 849; x += 1) {
    stroke(color(255,0,255));
     if ((((x-50)*ts)+50) < 850)
       line ((((x-50)*ts)+50), 350 - D1[x-50]*d1v, (((x+1-50)*ts)+50), 350 - D1[(x+1)-50]*d1v);
  }
}

void d2(){
  for (int x = 50; x < 849; x += 1) {
    stroke(color(0,255,255));
     if ((((x-50)*ts)+50) < 850)
       line ((((x-50)*ts)+50), 350 - D2[x-50]*d2v, (((x+1-50)*ts)+50), 350 - D2[(x+1)-50]*d2v);
  }
}
