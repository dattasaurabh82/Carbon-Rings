#include <Servo.h>

Servo myservo;
int x = 0;

void setup()
{
  Serial.begin(9600);
  myservo.attach(9); 
}

void loop()
{
  
  while(Serial.available())
  {
    x = Serial.read()-'0';
    Serial.flush();
  }
  myservo.write(x);
  delay(5);
  
 }
