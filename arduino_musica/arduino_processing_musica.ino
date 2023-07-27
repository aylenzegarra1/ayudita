//VERSION DE CHATGPT

#include <NewPing.h>

#define TRIGGER_PIN 7
#define ECHO_PIN 6

#define MAX_DISTANCE 200 // Ajusta este valor según tus necesidades (en centímetros)
#define MOVEMENT_THRESHOLD 30 // Ajusta este valor para determinar el umbral de movimiento

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

int estado = 1; // Variable para llevar el control de los estados

void setup() {
  Serial.begin(9600);
}

void loop() {
  delay(50); // Pequeña pausa para mejorar la precisión de la medición

  unsigned int distancia = sonar.ping_cm();
  Serial.println(distancia); // Envía la distancia por el puerto serie

  if (distancia <= MOVEMENT_THRESHOLD) {
    // Incrementa el estado cada vez que se detecta movimiento
    estado++;
    Serial.print("ESTADO: ");
    Serial.println(estado);
  }

  delay(500); // Ajusta este valor según la frecuencia de detección de movimiento
}




