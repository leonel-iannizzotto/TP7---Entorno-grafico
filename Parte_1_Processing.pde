import processing.serial.*; // libreria para comunicacion por el puerto serie

Serial puerto; // variable tipo 'Serial' para la comunicacion
int ancho = 90;
int[] salidas = {0,0}; // forma de declarar los arreglos en java
int[] entradas = {0,0}; // sin nada en [] y con las llaves

// -----------------------------------------------------------------------------------------

void setup()
{
  size(910,600); // tamaño
  frameRate(60); // velocidad de refresco
  
  printArray(Serial.list()); // muestra los puertos seriales disponibles en la consola para ver cual usar
  puerto = new Serial(this, Serial.list()[1], 9600); // CAMBIAR EL [1] DONDE ESTÉ EL ARDUINO - velocidad de 9600 baudios
  puerto.bufferUntil('\n'); // que lea hasta el salto de línea
}

// -----------------------------------------------------------------------------------------

void draw()
{
  int i; 
  // FONDO
  background(0,0,50);
  
  // TEXTOS
  textSize(60); // tamaño de texto
  fill(255); // color del relleno
  text ("ENTRADAS", 90, 200);
  text ("SALIDAS", 90, 400);
  
  // DIBUJAR ENTRADAS Y SALIDAS
  for (i=0; i<=1; i++)
  {
  // ENTRADAS (verde=HIGH - rojo=LOW)
    if (entradas[i] == 1)
    {
      fill(0,255,0);  
    }
    else 
    {
      fill(255,0,0);
    }
    
    stroke(255); // contorno blanco
    rect(505+(i * 220), 140, ancho, ancho);
    
    fill(0);
    textSize(24); 
    text("E" + (i + 1), 539 + (i * 220), 193); // escribe E1 y E2
    
    // SALIDAS ( amarillo=HIGH - gris=LOW)
    if (salidas[i] == 1)
    {
      fill(255,255,0);
    }
    else
    {
      fill(100,100,100);
    }
    stroke(255);
    ellipse(550 + (i * 220), 375, ancho, ancho);
    
    fill(0);
    textSize(24);
    text("L" + (i + 1), 539 + (i * 220), 383);
  }
}

// -----------------------------------------------------------------------------------------

void mousePressed() // la funcion actua cuando detecta un click en la pantalla
{
int i;
float distancia, centroX, centroY=375; // puntos donde está el centro de cada salida
  for (i=0;i<=1;i++) 
  {
    centroX = 550 + (i * 220);
    
    distancia = dist(mouseX, mouseY, centroX, centroY); // ve si el click fue en alguna de las salidas
    if (distancia < ancho / 2) 
    {
      salidas[i] = 1 - salidas[i]; // invierte el estado
      puerto.write("L" + (i + 1) + ":" + salidas[i] + "\n"); // manda el comando por el puerto serie en formato "L1:1" o "L2:0"
    }
  }
}

// -----------------------------------------------------------------------------------------

void serialEvent(Serial puerto) // recibe los datos del arduino
{
String mensaje;  
int indice, estado;

mensaje = puerto.readStringUntil('\n'); // lee todo el texto acumulado en el buffer hasta el salto de línea
  
  if (mensaje != null) 
  {
    mensaje = trim(mensaje); // limpiar espacios o saltos de línea
      
    if (mensaje.startsWith("E")) // busca que empiece con E
    {
      indice = int(mensaje.substring(1, 2)) - 1; // obtiene indice i (mira la posicion 1 de E1:1)
      estado = int(mensaje.substring(3, 4));  // obtiene el valor (0 o 1)
          
      if (indice>=0 && indice<2) 
      {
        entradas[indice] = estado;
      }
    }
  }
}
