// Name: FORCES, assignment 3, CART353
// Author: Samuelle Bourgault
// Date: February 28, 2017
// Description: Character amass noise on the screen
//
// SOURCES
// 1. Chapter 1 & 2 from Nature of Code
// 2. Visual character: https://thenounproject.com/natolirojo/collection/people/?oq=people&cidx=2


/** INSTANTIATION **/
// instantiate the main character
Roller roller;

// instantiate the Anti-Ice spots on the screen
AntiIce [] ices;

// instantiate the noise object
Object [] objects;

// instantiate the boolean detecting when a key is released
boolean keyReleased;

// instantiate each increase of acceleration
float accValue;

// instantiate titles
String brand;
String instruction;
String type;

void setup() {
  size(800, 500);
  background(255);
  // create 5 Anti-Ice spots
  ices = new AntiIce[5];
  for (int i = 0; i < ices.length; i++) {
    ices[i] = new AntiIce();
  }

  // create 100 noise objects
  objects = new Object[100];
  for (int i = 0; i < objects.length; i++) {
    objects[i] = new Object();
  }

  // create the main character
  roller = new Roller();

  // set keyReleased detection to TRUE
  keyReleased = true;

  // set the increase of acceleration to 0.1
  accValue = 0.1;

  // titles
  brand = "glitch please.";
  instruction = "grab some noise.";
  type = "salt&pepper&confetti.";
}


void draw() {
  // set background to black
  background(0);

  // add white stripes to the background
  stroke(255);
  // add glitching effect to the stripes as well
  if (millis() % 35 != 0) {
    for (int i = 0; i < 10; i++) {
      line(i*width/10, 0, i*width/10, height);
      for (int j = 0; j < 10; j++) {
        line(0, j*height/10, width, j*height/10);
      }
    }
  }

  // display Anti-Ice spots with the glitching effect
  if (millis() % 21 != 0) {
    for (int i = 0; i < ices.length; i++) {
      ices[i].display();
    }
  }

  // create a glitching effect for the titles.
  if (millis() % 13 != 0) {
    fill(50);
    textSize(32);
    text(brand, width/2-textWidth(brand)/2, height/2-16);
    text(instruction, width/2-textWidth(instruction)/2, height/2+16);
    text(type, width/2-textWidth(type)/2, height/2+48);
  }

  // change acceleration of the main character according to the key that is pressed
  if (keyPressed) {
    if (keyCode == UP) {
      PVector newAcceleration = new PVector(0, -accValue);
      roller.accelerate(newAcceleration);
    }

    if (keyCode == DOWN) {
      PVector newAcceleration = new PVector(0, accValue);
      roller.accelerate(newAcceleration);
    }

    if (keyCode == LEFT) {
      PVector newAcceleration = new PVector(-accValue, 0);
      roller.accelerate(newAcceleration);
    }

    if (keyCode == RIGHT) {
      PVector newAcceleration = new PVector(accValue, 0);
      roller.accelerate(newAcceleration);
    }
  }

  // update noise objects
  for (int i = 0; i < objects.length; i++) {
    PVector force = roller.attract(objects[i]);
    objects[i].applyForce(force);
    objects[i].update();
    objects[i].checkEdges();
  }

  // update and display the main character 
  roller.IsInside(ices);
  roller.update();
  roller.display();

  // display the noise objects
  for (int i = 0; i < objects.length; i++) {
    objects[i].display();
  }
}