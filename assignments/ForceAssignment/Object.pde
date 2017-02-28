class Object {
  /** parameters **/
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float size;
  // to check if it should be displayed on the screen or not
  boolean enabled;

  /** methods **/
  // constructor
  Object() {
    // And for now, we’ll just set the mass equal to 1 for simplicity.
    position = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = 1+random(10);
    size = map(mass, 1, 11, 2, 5);
    enabled = true;
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    //compute the effect of the force on the object according of its mass
    PVector f = PVector.div(force, mass);
    // change the acceleration
    acceleration.add(f);
  }

  // update the position of the noise object
  void update() {
    //from chapter 1 of Nature of code
    // constrain acceleration
    acceleration.x = constrain(acceleration.x, -0.5, 0.5);
    acceleration.y = constrain(acceleration.y, -0.5, 0.5);
    // change velocity and constrain it
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, -10, 10);
    velocity.y = constrain(velocity.y, -10, 10);
    // change position
    position.add(velocity);

    // refreshing the acceleration
    acceleration.mult(0);
  }

  // display the noise object with changing color
  void display() {
    if (enabled) {
      noStroke();
      fill(random(255), random(255), random(255));
      rect(position.x, position.y, size, size);
    }
  }

  // check the edges from chapter 1 of Nature of code
  void checkEdges() {
    if (position.x > width) {
      position.x = width;
      velocity.x *= -1;
    } else if (position.x < 0) {
      velocity.x *= -1;
      position.x = 0;
    }

    if (position.y > height) {
      velocity.y *= -1;
      position.y = height;
    } else if (position.y < 0) {
      velocity.y *= -1;
      position.y = 0;
    }
  }

  // getter and setters
  PVector getPosition() {
    return position;
  }

  void setPosition(float x, float y) {
    position.x = x;
    position.y = y;
  }

  float getMass() {
    return mass;
  }

  boolean getEnabled() {
    return enabled;
  }

  void setEnabledFalse() {
    enabled = false;
  }
}