// this class adds the notion of movement

class Child2 extends Child1 {

  //constructor
  Child2(DNA newDna, int newID, PVector newPosition, Environment2 newEnv) {
    super(newDna, newID, newPosition, newEnv);
  }

  // methods
  // apply all the force on the organism
  void applyBehaviors(ParticleSystem orgs) {
    super.applyBehaviors(orgs);

    // allow the organism to follow the vectorial field
    PVector flow = flow();

    // give an amplitude to each force
    flow.mult(1);

    // apply the forces
    applyForce(flow);
  }

  // set the movement of the organism
  void move() {
    // constrain the acceleration
    acceleration.x = constrain(acceleration.x, -5, 5);
    acceleration.y = constrain(acceleration.y, -5, 5);
    acceleration.z = constrain(acceleration.z, -5, 5);
    // compute and constrain the velocity
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, -dna.getMaxVelocity(), dna.getMaxVelocity());
    velocity.y = constrain(velocity.y, -dna.getMaxVelocity(), dna.getMaxVelocity());
    velocity.z = constrain(velocity.z, -dna.getMaxVelocity(), dna.getMaxVelocity());
    // compute and constrain the posisition
    position.add(velocity);

    // keep the organism inside the boundaries of the screen
    if (position.x - size/2 > width || position.x + size/2 < 0) {
      velocity.x = -velocity.x;
    }
    if (position.y - size/2 > height || position.y + size/2 < 0) {
      velocity.y = -velocity.y;
    }
    if (position.z - size/2 > 0 || position.z + size/2 < -depth) {
      velocity.z = -velocity.z;
    }

    // reinitialize the acceleration
    acceleration.mult(0);
  }

  // compute the force of the vectorial field from the environment
  // source chap 6 The Nature of code, based on Reynolds
  PVector flow() {
    // compute the desired direction
    PVector desired = env.lookup(this.position);
    desired.setMag(dna.getMaxVelocity());

    // steering is desired direction minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  void display() {
    super.display();
  }
}