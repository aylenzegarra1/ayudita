//VERSIÓN DE CHATGPT

import processing.serial.*;
import processing.sound.*;

Serial puertoSerie;
SoundFile[] soundFiles; // Arreglo para almacenar los SoundFile de cada estado
int estado = 1; // Variable para almacenar el estado actual

void setup() {
  size(400, 300);
  // Asegúrate de que el nombre del puerto serie coincida con el que está usando Arduino
  puertoSerie = new Serial(this, "COM3", 9600);

  // Carga los SoundFile de cada estado
  soundFiles = new SoundFile[3]; // Ajusta el tamaño del arreglo según la cantidad de estados que necesites
  soundFiles[1] = new SoundFile(this, "loop1.mp3");
  soundFiles[2] = new SoundFile(this, "loop2.mp3");
  soundFiles[3] = new SoundFile(this, "loop3.mp3");
  // Agrega más líneas para cargar más archivos de sonido según la cantidad de estados
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
