/**
 author: Samuelle Bourgault
 date: March 21, 2017
 description: A cave at night or during the day. Press SPACE to change its state.
 **/

import java.util.Iterator;

//ParticleSystem ps;
// 1. Systems of Geyser
ArrayList<ParticleSystem> systemsGeyser;
// 2. System of Bats
ParticleSystem systemBat;
// 3. System of Butterfly
ParticleSystem systemBut;
// 4. Systems of Clouds
ArrayList<ParticleSystem> systemsCloud;

//forces implied
PVector gravity;
PVector antiGravity;
PVector wind;
float offsetWind;

// day/night state
boolean day;
boolean dayJustChanged;
String instruction;

void setup() {
  size(700, 700, P3D);
  // 1. geysers systems
  systemsGeyser = new ArrayList<ParticleSystem>();
  // 2. bat system
  systemBat = new ParticleSystem(new PVector(width/2, height/2, -100), 2);
  // 3. butterfly system
  systemBut = new ParticleSystem(new PVector(width/2, height/2, 0), 3);
  // 4. clouds systems
  systemsCloud = new ArrayList<ParticleSystem>();
  for (int i = 0; i < 21; i++) {
    systemsCloud.add(new ParticleSystem(new PVector(random(0, width), random(0, height), random(-2000, -100)), 4));
  }

  // forces implied
  gravity = new PVector(0, 0.1, 0);
  antiGravity = new PVector(0, -0.01, 0);
  offsetWind = 0.1;
  wind = new PVector(noise(offsetWind), 0, 0);

  // state of the day
  day = false;
  dayJustChanged = false;
  instruction = "press space to play god.";
}

void draw() {
  // the background
  if (day) {
    background(230);
  } else {
    background(0);
  }
  fill(255);
  text(instruction, width/2-textWidth(instruction)/2, height-100);
  // the cave, a series of three boxes
  noFill();
  stroke(255);
  strokeWeight(1);
  pushMatrix();
  translate(width/2, height/2, -600);
  box(800);
  translate(0, 0, -800);
  box(800);
  translate(0, 0, -800);
  box(800);
  popMatrix();

  // get mouse position
  PVector mouse = new PVector(mouseX, mouseY);
  if (day) {
    // butterflies outside the cave
    systemBut.setLocation(mouse);
    PVector dir = PVector.sub(mouse, systemBut.getLocation());
    dir.normalize();
    dir.mult(0.05);
    systemBut.applyForce(dir);
    systemBut.run();
    systemBut.addParticle();

    // clouds seen through the cave
    if (dayJustChanged) {
      // add 21 clouds randomly located to the day scene
      for (int i = 0; i < 21; i++) {
        systemsCloud.add(new ParticleSystem(new PVector(random(0, width), random(0, height), random(-1000, -100)), 4));
      }
      dayJustChanged = false;
    }

    // apply the wind on the clouds
    for (ParticleSystem ps : systemsCloud) {
      ps.applyForce(wind);
      ps.run();
      ps.addParticle();
    }
  } else {
    // remove the clouds from the previous scene
    for (int i = 0; i < systemsCloud.size(); i++) {
        systemsCloud.remove(i);
      }
    
    // geysers in the cave, create a new one when the modulo is equal to one
    if (frameCount % 80 == 0) {
      systemsGeyser.add(new ParticleSystem(new PVector(random(0, width), height, random(-1000, -100)), 1));
    }

    // apply the antigravity and the wind force on the geysers
    for (ParticleSystem ps : systemsGeyser) {
      ps.applyForce(antiGravity);
      ps.applyForce(PVector.mult(wind, 0.1));
      ps.run();
      ps.addParticle();
    }

    // add a maximum of 30 geysers
    if (systemsGeyser.size() > 30) {
      systemsGeyser.remove(0);
    }

    // bats in the cave
    PVector dir = PVector.sub(systemBat.getLocation(), mouse);
    dir.z = 1;
    dir.normalize();
    dir.mult(0.1);

    //apply a force in the opposite direction from the mouse
    systemBat.applyForce(dir);
    systemBat.run();
    systemBat.addParticle();
  }

  // update the wind
  offsetWind += 0.01;
  wind.x = map(noise(offsetWind), 0, 1, -1, 1);
  wind.mult(0.01);
}

//void mousePressed() {
//systemsGeyser.add(new ParticleSystem(new PVector(mouseX, mouseY, -200), 1));
//}

// when the space bar is pressed, change the day/night state
void keyPressed() {
  if (key == ' ') {
    day = !day;

    if (day) {
      dayJustChanged = true;
    }
  }
}