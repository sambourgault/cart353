class Roller {

  /* parameters */
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  // visual comes from: https://thenounproject.com/natolirojo/collection/people/?oq=people&cidx=2
  PImage visual;
  // distance from the borders of the screen
  float offset;
  // see if the roller is in an Anti Ice spot
  boolean IsInAntiIce;
  // get the friction coefficient of the spot
  float frictionCoef;
  // array of gathered noise 
  Object [] objects;
  // count of the gathered noise objects
  int countObject;
  // winner statement
  String winner; 

  /** methods **/
  // constructor
  Roller() {
    position = new PVector(width/2, height/2);
    velocity =  new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = 30;
    visual = loadImage("rollerW.png");
    visual.resize(35, 0);
    offset = 20;
    frictionCoef = 0;
    objects = new Object[100];
    countObject = 0;
    winner = "you won. yeah that's it.";
  }

  // apply a force by changing the acceleration of the roller
  void applyForces(PVector force) {
    PVector f = PVector.div(force, 1);
    acceleration.add(f);
  }

  // accelerate the roller (used when an arrow key is pressed)
  void accelerate(PVector newAcceleration) {
    acceleration.add(newAcceleration);
  }

  // attract the noise Objects
  PVector attract(Object object) {
    // check the distance between the object and the roller
    PVector force = PVector.sub(position, object.getPosition());
    float distance = force.mag();
    // if the noise object is close add it to the array of the roller and disabled it from the screen
    if (distance < 10 && object.getEnabled()) {
      object.setEnabledFalse();
      objects[countObject] = new Object();
      objects[countObject].setPosition(position.x+random(0, visual.width), position.y+random(0, visual.height));
      countObject++;
    } 
    // if the noise object is still far from the roller but in the short range, attract it towards the roller
    else if (distance < 100) {
      distance = constrain(distance, 5.0, 25.0);
      force.normalize();
      float strength = (0.4 * mass * object.getMass()) / (distance * distance);
      force.mult(strength);
      return force;
    } 
    return new PVector(0, 0);
  }

  // update the velocity and the position of the roller
  void update() {
    // verify if the roller is on an Anti-Ice spot
    if (IsInAntiIce) {
      PVector friction = new PVector(velocity.x, velocity.y);
      friction.normalize();
      friction.mult(-frictionCoef);
      applyForces(friction);
    }

    // constrain the acceleration
    acceleration.x = constrain(acceleration.x, -1, 1);
    acceleration.y = constrain(acceleration.y, -1, 1);
    // change the velocity and constrain it
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, -10, 10);
    velocity.y = constrain(velocity.y, -10, 10);
    // change the position and constrain it
    position.add(velocity);
    position.x = constrain(position.x, 0 + offset, width - 3*offset);
    position.y = constrain(position.y, 0 + offset, height - 4*offset);

    // refresh the acceleration
    acceleration.mult(0);
  }

  // display the roller
  void display() {
    // display the main character
    image(visual, position.x, position.y);

    // display the gathered noise object
    for (int i = 0; i < countObject; i++) {
      objects[i].setPosition(position.x+random(0, visual.width), position.y+random(0, visual.height));
      objects[i].display();
    }

    // if all the noise objects have been collected, display the "winner statement"
    if (countObject == 100) {
      textSize(50);
      fill(random(255), random(255), random(255));
      text(winner, width/2-textWidth(type)/2, height/2);
    }
  }

  // check if the roller in on a Anti-Ice spot
  boolean IsInside(AntiIce[] ices) {
    for (int i = 0; i < ices.length; i++) {
      if (position.x > ices[i].getX() && position.x < ices[i].getX()+ices[i].getSizeX() && position.y > ices[i].getY() && position.y < ices[i].getY()+ices[i].getSizeY()) {
        // if the roller is on an Anti-Ice spot, change its status to true
        IsInAntiIce = true;
        frictionCoef = ices[i].getCoef();
        return IsInAntiIce;
      }
    }
    // if the roller is not on an Anti-Ice spot, chnage its status to false
    IsInAntiIce = false;
    return IsInAntiIce;
  }

  // getters and setters
  PVector getPosition() {
    return position;
  }

  float getMass() {
    return mass;
  }
}