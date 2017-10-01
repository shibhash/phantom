import processing.sound.*;

Car myCar1;
Car myCar2; 
Car myCar3;
Car myCar4;

HCar myHCar1;
HCar myHCar2; 
HCar myHCar3;
HCar myHCar4;


AudioIn input;
Amplitude analyzer;

void setup() {
  size(800, 600);
  
  myCar1 = new Car(color(255), int(random(width/2 - width/6+50, width/2 + width/6-50)), height/2, random(0, .2), 1); 
  myCar2 = new Car(color(255), int(random(width/2 - width/6+30, width/2 + width/6-30)), height/2, random(0, .2), -1);
  myCar3 = new Car(color(255), int(random(width/2 - width/6+20, width/2 + width/6-120)), height/2, random(0, .2), 1);
  myCar4 = new Car(color(255), int(random(width/2 - width/6+80, width/2 + width/6-50)), height/2, random(0, .2), -1);
  
  myHCar1 = new HCar(color(255), width/2, int(random(height/2 - height/6+30, height/2 + height/6-30)), random(0, .2), 1); 
  myHCar2 = new HCar(color(255), width/2, int(random(height/2 - height/6+120, height/2 + height/6-80)), random(0, .2), -1);
  myHCar3 = new HCar(color(255), width/2, int(random(height/2 - height/6+60, height/2 + height/6-50)), random(0, .2), 1);
  myHCar4 = new HCar(color(255), width/2, int(random(height/2 - height/6+50, height/2 + height/6-40)), random(0, .2), -1);

  frameRate(30);
  smooth(5);

  input = new AudioIn(this, 0);
  input.start();
  analyzer = new Amplitude(this);
  analyzer.input(input);
}

void draw() {

  background(0);

  float vol = analyzer.analyze();   // Get the overall volume (between 0 and 1.0)
  println("volume:",vol);

 
  knob(width/2, height/2+ height/3, 20+vol*300,4);   // Knob size based on volume
   
  

  myCar1.move();  
  myCar2.move();
  myCar3.move();
  myCar4.move();
  
  myHCar1.move();  
  myHCar2.move();
  myHCar3.move();
  myHCar4.move();



  //canvas creation
  
  int opacity = 255;
  
  if(vol>.5){
  opacity = 155; 
  }
  stroke(255);
  fill(200, opacity);
  rectMode(CENTER);
  rect(width/2, height/2, width/3, height/3, 20);
}

class Car { 
  color c;
  float xpos;
  float ypos;
  float speed;
  int p;

  Car(color tempC, float tempXpos, float tempYpos, float tempspeed, int dir) { 
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    speed = tempspeed;
    p = dir;
  }

  void move() {
    
    
    float vol = analyzer.analyze();

    //draw car body 
    noStroke();
    fill(255);
    rectMode(CENTER);
    float carlength = random(height/4, height/4+.8);
    float carwidth = random(20, 21.8);

    int w = 6; //eyesize
    int top, bot; // top and bottom radius

    if (p>0) { 
      top = 20;
      bot=2;
    } else {
      bot= 20;
      top=2;
    }

    rect(xpos, ypos, carwidth, carlength, top, top, bot, bot);
    
    //eye
    fill(0);
    ellipse(xpos-.9*w, ypos +p*(- carlength/2 + 2*w), w, w);
    ellipse(xpos+.9*w, ypos +p*(- carlength/2 + 2*w), w, w);
    //ellipse(xpos, ypos - carlength/2 + 5*w,1.1*w,1.5*w); //draw mouth


    //start moving
    ypos = ypos - p* speed;
    


    //sound condition
    if (vol>random(0.09,0.29)) {
      println("Boooooooooooooow");
      //speed = speed*p*-5;
      //ypos = ypos - p* speed;
      ypos = height/2;
      xpos= random(width/2 - width/6+random(10,80), width/2 + width/6- random(10,80));
      speed = random(0, .3);  
      
    }
  }
}

class HCar { 
  color c;
  float xpos;
  float ypos;
  float speed;
  int p;

  HCar(color tempC, float tempXpos, float tempYpos, float tempspeed, int dir) { 
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    speed = tempspeed;
    p = dir;
  }

  void move() {
    
    
    float vol = analyzer.analyze();

    //draw HCar body 
    noStroke();
    fill(255);
    rectMode(CENTER);
    float HCarlength = random(width/4, width/4+.8);
    float HCarwidth = random(20, 21.8);
 
    int w = 6; //eyesize
    int top, bot; // top and bottom radius

    if (p>0) { 
      top = 20;
      bot=2;
    } else {
      bot= 20;
      top=2;
    }
    
    

    rect(xpos, ypos, HCarlength, HCarwidth, top,bot, bot, top);
    
    //eye
    fill(0);
    ellipse(xpos-p*( HCarlength/2 - 2*w), ypos+.9*w , w, w);
    ellipse(xpos-p*( HCarlength/2 - 2*w), ypos-.9*w, w, w);
    //ellipse(xpos, ypos - HCarlength/2 + 5*w,1.1*w,1.5*w); //draw mouth


    //start moving
    xpos = xpos - p* speed;
    //println(speed);


    //sound condition
    if (vol>random(0.09,0.29)) {
      println(vol,"Boooooooooooooow");
      //speed = speed*p*-5;
      //ypos = ypos - p* speed;
      xpos = width/2;
      HCarwidth= HCarwidth + random(-10,30);
      ypos=int(random(height/2 - height/6+10, height/2 + height/6-10));
      speed = random(0, .3);
  
    }
  }
}

void knob(float x, float y , float size, float n){
  float steps = size/n;

  
  int r= int(random(0, 255));
  int g=int(random(0, 255));
  int b=int(random(0, 255));
  int a=int(random(0, 255));
  
  float r1 = r/n;
  float b1 = b/n;

  //fill(r, 0, b, a-180);
  stroke(r, g, b, a);
  
  for (int i=1; i<n; i++){
    rectMode(CENTER);
    fill(i*r1,0,i*b1, a-150);
    ellipse(x,y,size- i*steps,size- i*steps);
  }
}