
#include <LiquidCrystal.h>

int sensorValue;

LiquidCrystal lcd(12, 11, 5, 4, 3, 2); 

void setup() 
{
  Serial.begin(9600);
  lcd.begin(16, 2);  
}

void loop()
{
sensorPrintFunction();
}

void sensorPrintFunction() 
{
  sensorValue = analogRead(0);       // read analog input pin 0
  Serial.println(sensorValue, DEC);  // prints the value read
  delay(100);                        // wait 100ms for next reading
  
  lcd.clear(); // Clear the display
  lcd.print("CO level:"); // Print some text
  lcd.setCursor(0,1);
  lcd.print(sensorValue);
  delay(200);
}


