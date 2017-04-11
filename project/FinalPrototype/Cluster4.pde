// add movement of the cluster

class Cluster4 extends Cluster3 {
  // attributes
  PVector acceleration;
  PVector velocity;

  // methods
  // constructor
  Cluster4(int id) {
    super(id);

    acceleration = new PVector(0, 0, 0);
    velocity = new PVector(random(0.5), random(0.5), random(0.5));
    velocity.setMag(1);
  }

  // apply the behaviors of the cluster
  void applyBehaviors() {
    super.applyBehaviors(); 

    // apply an extra flow to move the cluster
    Iterator<Map.Entry<Integer, Child1>> iter = orgs.entrySet().iterator();
    while (iter.hasNext()) {
      Map.Entry<Integer, Child1> entry = iter.next();
      PVector flow = flow();
      flow.mult(1);
      // apply the forces
      orgs.get(entry.getKey()).applyForce(flow);
    }
  }

  // move the cluster
  void move() {
    // constrain the acceleration
    acceleration.x = constrain(acceleration.x, -5, 5);
    acceleration.y = constrain(acceleration.y, -5, 5);
    acceleration.z = constrain(acceleration.z, -5, 5);
    // compute and constrain the velocity
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, -1, 1);
    velocity.y = constrain(velocity.y, -1, 1);
    velocity.z = constrain(velocity.z, -1, 1);
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

  // make the cluster following the flow (perlin noise vectorial field)
  PVector flow() {
    // compute the desired direction
    PVector desired = env.lookup(this.position);
    desired.setMag(1);

    // steering is desired direction minus velocity
    PVector steer = PVector.sub(desired, velocity);
    return steer;
  }
}