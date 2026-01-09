#include "../../firmware.h"

/**
 * @brief Initialzie the PWM registers and connect them to their respective output pins
 */
void initLights(){
// Setup pins
  pinMode(IR_PIN, OUTPUT);
  pinMode(RED_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);
  pinMode(WHITE_PIN, OUTPUT);

  //ledcAttach(RED_PIN, PWM_FREQ, PWM_RESOLUTION); 
  //ledcAttach(GREEN_PIN, PWM_FREQ, PWM_RESOLUTION); 
  //ledcAttach(WHITE_PIN, PWM_FREQ, PWM_RESOLUTION);

  sleep(1);
  digitalWrite(RED_PIN, LOW);
  digitalWrite(GREEN_PIN, LOW);
  digitalWrite(WHITE_PIN, LOW);
  digitalWrite(IR_PIN, LOW);
}