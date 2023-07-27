import processing.sound.*;
import processing.serial.*;

Serial puerto; // Declaro el objeto de la clase Serial

// --- Sonidos
SoundFile loop1, loop2, loop3;


void setup() {
  size(400, 300);
  
  String nombrePuerto = Serial.list()[0]; // Guardo en una variable el puerto disponible
  puerto = new Serial(this, nombrePuerto, 9600); // Abro el puerto especificado arriba
  
  
  loop1 = new SoundFile (this, "loop1.mp3");
  loop2 = new SoundFile (this, "loop2.mp3");
  loop3 = new SoundFile (this, "loop3.mp3");
  
  //iniciarSonidos();
}

void draw() {
  // Lectura de datos del puerto serie
  while (puerto.available() > 0) {
    String mensaje = puerto.readStringUntil('\n');
    if (mensaje != null) {
      mensaje = trim(mensaje); // Elimina espacios y caracteres especiales
      if (mensaje.equals("MOVIMIENTO")) {
        loop1.play(); // Reproduce el archivo de sonido cuando se detecta movimiento
      }
    }
  }
}

/*void iniciarSonidos() {
  
  loop1.loop();
  loop1.play();

  loop2.loop();
  loop2.play();

  loop3.loop();
  loop3.play();

}*/
