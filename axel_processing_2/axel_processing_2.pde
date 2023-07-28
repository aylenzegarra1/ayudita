//VERSIÓN DE CHATGPT

import processing.serial.*;
import processing.sound.*;

Serial puertoSerie;
SoundFile[] soundFiles; // Arreglo para almacenar los SoundFile de cada estado
int estado = 1; // Variable para almacenar el estado actual

void setup() {
  size(400, 300);
  
  // Obtener la lista de puertos serie disponibles
  String[] puertosDisponibles = Serial.list();
  
  if (puertosDisponibles.length == 0) {
    println("No se encontraron puertos serie disponibles.");
    exit();
  }
  
  // Establecer la comunicación serial en el primer puerto disponible
  String primerPuerto = Serial.list()[0]; // Cambia el índice [0] por el índice del puerto que desees utilizar
  puertoSerie = new Serial(this, primerPuerto, 9600);


  // Carga los SoundFile de cada estado
  soundFiles = new SoundFile[3]; // Ajusta el tamaño del arreglo según la cantidad de estados que necesites
  soundFiles[0] = new SoundFile(this, "estado1.mp3");
  soundFiles[1] = new SoundFile(this, "estado2.mp3");
  soundFiles[2] = new SoundFile(this, "estado3.mp3");
}

void draw() {
  // Lectura de datos del puerto serie
  while (puertoSerie.available() > 0) {
    String mensaje = puertoSerie.readStringUntil('\n');
    if (mensaje != null) {
      mensaje = trim(mensaje); // Elimina espacios y caracteres especiales
      int nuevoEstado = int(mensaje); // Convierte el mensaje en un entero
      if (nuevoEstado > 0 && nuevoEstado <= soundFiles.length) {
        estado = nuevoEstado; // Actualiza el estado actual
      }
    }
  }
  
  // Reproduce el sonido correspondiente al estado actual
  if (estado > 0 && estado <= soundFiles.length) {
    for (int i = 1; i < soundFiles.length; i++) {
      if (i == estado) {
        if (!soundFiles[i].isPlaying()) {
          soundFiles[i].play();
          // Detiene los demás sonidos que estén reproduciéndose
          for (int j = 1; j < soundFiles.length; j++) {
            if (j != estado && soundFiles[j].isPlaying()) {
              soundFiles[j].stop();
            }
          }
        }
      }
    }
  }
}
