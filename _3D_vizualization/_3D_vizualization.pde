import processing.opengl.*;
import processing.serial.*;

PFont font;

Serial myPort;

int radius = 100;
int data = 0;

void setup()
{
  size(1200, 600, OPENGL);
  background(255);
  stroke(127, 127, 127);
  smooth();
  
  myPort = new Serial(this, "COM7", 9600);
  myPort.bufferUntil('\n');
 
 smooth();
 
 frameRate(10);
 }

void serialEvent(Serial myPort)
{
  String inString = myPort.readStringUntil('\n');
  if (inString != null)
 {
  //conversion of the string into integer
  inString = trim(inString);
  data = int(inString);
 }
}

void draw()
{
 // background(255);
  
  translate(width/2, height/2, 0);
  rotateY(frameCount*0.03);
  rotateX(frameCount*0.04);
  
  //rotateY(3);
  //rotateX(4);
  
  float s = 0;
  float t = 0;
  float lastx = 0;
  float lasty = 0;
  float lastz = 0;
  
  while(t<180)
  {
    s += 18;
    t +=1;
    float radianV = radians(s);
    float radianT = radians(t);
    
    float thisx = 0 + ((data+radius)*cos(radianV)*sin(radianT));
    float thisy = 0 + ((data+radius)*sin(radianV)*sin(radianT));
    float thisz = 0 + ((data+radius)*cos(radianT));
    
    if(lastx != 0)
    {
      line(thisx, thisy, thisz, lastx, lasty, lastz);
    }
    lastx = thisx;
    lasty = thisy;
    lastz = thisz;
    
  }
  
  println(data);
}
