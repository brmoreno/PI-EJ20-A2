/*
oscP5sendyreceive 
Basado en los ejemplos y la librería oscP5 de Andreas Schlegel
Benjamín R. Moreno O.
UGTO
*/

//importo la librería
import oscP5.*;
import netP5.*;

//este es el objeto que recibe
OscP5 oscP5;

//esta será la dirección donde voy a enviar mis mensajes
NetAddress direccionRemota;

int x, y;
int t = 10;

void setup() {
  size(400, 400);
  //inicializo el objeto oscPs, el parámetro es el puerto donde va a escuchar los mensajes entrantes
  oscP5 = new OscP5(this, 12000);

  // inicializo el objeto NetAddress pasando la dirección IP y el puerto de los mensajes salientes
  // 127.0.0.1 es mi localhost
  direccionRemota = new NetAddress("127.0.0.1", 12001);

  x = width/2;
  y = height/2;
  background(0);
}

void draw() {
    
  fill(255);
  noStroke();
  ellipse(x, y, t, t);
}

//envío un mensajes OSC al presionar el boton del mouse
void mousePressed() {
  //genero un nuevo mensaje
  OscMessage mensaje = new OscMessage("/mouseX");

  //le agrego los datos, en este caso la posición en X del mouse
  mensaje.add(mouseX); 

  //envío el mensaje 
  oscP5.send(mensaje, direccionRemota);
}

//cada vez que se recibe un mensaje de osc en el puerto asignado, se llama esta función
void oscEvent(OscMessage theOscMessage) {  
  //si el mensaje está etiquetado como "/x"
  if (theOscMessage.checkAddrPattern("/x") == true) {
    //asigna el valor entero a la variable x
    x = theOscMessage.get(0).intValue();
  }

  //si el mensaje está etiquetado como "/y"
  if (theOscMessage.checkAddrPattern("/y") == true) {
    //asigna el valor entero a la variable y
    y = theOscMessage.get(0).intValue();
  }
  
   //si el mensaje está etiquetado como "/t"
  if (theOscMessage.checkAddrPattern("/t") == true) {
    //asigna el valor entero a la variable t
    t = theOscMessage.get(0).intValue();
  }
}
