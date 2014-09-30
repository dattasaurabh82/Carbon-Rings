import processing.serial.*;
import fullscreen.*;
import processing.opengl.*;
import beads.*;

FullScreen fs;
Serial myPort;
AudioContext ac;
Glide carrierFreq, modFreqRatio;

PFont font;
PFont fontB;

int data = 0;

float centX = 700;
float centY = 400;

void setup()
{
  size(1400, 800, OPENGL);
  background(255);
  
  fs = new FullScreen(this);
  fs.enter();
  
  myPort = new Serial(this, "COM7", 9600);
  myPort.bufferUntil('\n');
  
  ac = new AudioContext();
  
  carrierFreq = new Glide(ac, 500);
  modFreqRatio = new Glide(ac, 1);
  Function modFreq = new Function(carrierFreq, modFreqRatio) 
  {
    public float calculate()
   
    {
      return x[0] * x[1];
    }
  };
  
  WavePlayer freqModulator = new WavePlayer(ac, modFreq, Buffer.SINE);
  
  Function carrierMod = new Function(freqModulator, carrierFreq) 
  {
    public float calculate()
    {
      return x[0] * 400.0 + x[1];    
    }
  };
  
  WavePlayer wp = new WavePlayer(ac, carrierMod, Buffer.SINE);
  Gain g = new Gain(ac, 1, 0.1);
  g.addInput(wp);
  ac.out.addInput(g);
  ac.start();

  smooth();
  
  frameRate(30);
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
  font = loadFont("SansSerif.plain-78.vlw");
  textFont(font, 78);
  
  noStroke();
  fill(255, 255, 255);
  rect((width/2)-120, (height/2)-100, 200, 200);
  
  fill(117, 117, 117);
  text(data, (width/2)-50, height/2);
  
  /*fontB = loadFont("SansSerif.plain-28.vlw");
  textFont(font, 28);
  
  smooth();
  fill(80, 80, 80, 30);
  text("Carbon Rings", 40, 50);
  //text("Rings", 50, 50);*/
  
  println(data);
  
  translate(width/4, height/4, 30);
  //rotateY(frameCount*0.03);
  rotateX(frameCount*0.01);
  //rotateZ(frameCount*0.2);
  
  stroke(random(50,200), 50);
  strokeWeight(1);
  //fill(data+108, data+98, data+ 60, 2 );
  noFill();
 ellipse(centX + random(5,15), centY + random(15,20), data*4 + random(10,40), data*4 + random(80));
 
 carrierFreq.setValue((float)data*random(4) / width * 1050 + 50);
  modFreqRatio.setValue((1 - (float)data*random(4) / height) * 10 + 0.1);
}
