class Particle {
  //location, velocity, and acceleration.
  PVector location;
  PVector velocity;
  PVector acceleration;
  // life duration
  float lifespan;
  // mass
  float mass;

  // constructor
  Particle(PVector l) {
    location = new PVector(l.x, l.y, l.z);
    acceleration = new PVector(0, 0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));

    lifespan = 255;
    mass = 1;
  }

  // update and display the particle
  void run() {
    update();
    display();
  }

  // update the location of the particle through velocity and acceleration
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= random(2.0);
  }

  // apply a force on the particle
  void applyForce(PVector force) {
    PVector f = force;
    f.div(mass);
    acceleration.add(f);
  }

  // display the particle as an ellipse
  void display() {
    stroke(0, lifespan);
    fill(175, lifespan);

    popMatrix();
    translate(0, 0, location.z);
    ellipse(location.x, location.y, 8, 8);
    pushMatrix();
  }

  // determine if the particle is dead or not
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }

  // set the location of the particle 
  void setLocation(PVector loc) {
    location = loc;
  }
}