int estadoAnteriorPulsador1 = HIGH;
int estadoAnteriorPulsador2 = HIGH;

void setup() 
{
  Serial.begin(9600); // iniciar comunicación serial a 9600 baudios (igual que en processing)

  // pines de salida
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);

  // pines de entrada
  pinMode(4, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP);
}

void loop() {
int estadoPulsador1, estadoPulsador2;

estadoPulsador1 = digitalRead(4);
estadoPulsador2 = digitalRead(5);

// --------- MANDA A PROCESSING -----------

  if (estadoPulsador1 != estadoAnteriorPulsador1) 
  {
    estadoAnteriorPulsador1 = estadoPulsador1;
   
    if (estadoPulsador1 == LOW) 
    {
      Serial.println("E1:1"); // manda "E1:1" si se presiona (LOW)
    } 
    else 
    {
      Serial.println("E1:0"); // manda "E1:0" si se suelta (HIGH)
    }
    delay(50);
  }

  if (estadoPulsador2 != estadoAnteriorPulsador2) 
  {
    estadoAnteriorPulsador2 = estadoPulsador2;
    if (estadoPulsador2 == LOW) 
    {
      Serial.println("E2:1");
    } 
    else 
    {
      Serial.println("E2:0");
    }
    delay(50);
  }

// --------- LEE DE PROCESSING -----------
  
  if (Serial.available() > 0) // ve si hay datos para leer
  {
    String comando;
    int valor;
    
    comando = Serial.readStringUntil('\n'); // lee hasta \n
    comando.trim(); // limpia espacios o saltos de línea extra

    if (comando.startsWith("L1:")) 
    {
      valor = comando.substring(3).toInt(); // extrae datos a partir del caracter 3 (el estado)
      digitalWrite(2, valor);
    } 
    else
    {
      if (comando.startsWith("L2:")) 
      {
        valor = comando.substring(3).toInt();
        digitalWrite(3, valor);
      }
    }
  }
}
