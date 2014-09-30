void setup()
{
  Serial.begin(9600);
}

void loop()
{
  while(Serial.available())
  {
    volatile byte data = Serial.read()- '0';
    //Serial.println(data);
    delay(20);
    if(data >=100)
    {
      digitalWrite(13, HIGH);
    }
  }
  Serial.flush();
}
