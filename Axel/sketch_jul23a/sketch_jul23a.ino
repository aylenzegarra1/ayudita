#define TRIGGER_PIN 3
#define ECHO_PIN 2
#define LED_PIN 9

void setup() {
  Serial.begin(9600);
  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode (LED_PIN, OUTPUT);
}

void loop() {
  // Envía un mensaje por el puerto serie
  Serial.println("Hola Aylen!");
  delay(100); // Espera 1 segundo antes de enviar el siguiente mensaje

  long duracion, distancia;

  // Envía un pulso de 10μs al sensor de ultrasonido
  digitalWrite(TRIGGER_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIGGER_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIGGER_PIN, LOW);

  // Lee el tiempo que tarda el eco en regresar
  duracion = pulseIn(ECHO_PIN, HIGH);

  // Calcula la distancia en centímetros
  distancia = duracion * 0.034 / 2;

  // Establece el brillo del LED
  analogWrite(LED_PIN, 255);

  Serial.println(distancia);
  delay(100); // Pequeño retraso para estabilizar las lecturas del sensor
}



