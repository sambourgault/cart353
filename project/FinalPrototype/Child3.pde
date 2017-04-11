// this class adds the notion of proximity

class Child3 extends Child2 {

  //constructor
  Child3(DNA newDna, int newID, PVector newPosition, Environment2 newEnv) {
    super(newDna, newID, newPosition, newEnv);
  }

  // methods
  // apply all the force on the organism
  void applyBehaviors(ParticleSystem orgs) {
    super.applyBehaviors(orgs);
    // separate the organism from the other individuals
    PVector separate = separate(orgs);
    separate.mult(2);

    // apply the forces
    if (currentLevel != 5) {
      applyForce(separate);
    }
  }

  // separate the individuals one from each other
  // source: from chap 6 The nature of code 
  PVector separate(ParticleSystem orgs) {
    int count = 0;
    PVector totalDesired = new PVector();
    // clear the connected child array every iteration
    this.childConnectedTo.clear();
    this.numberOfConnections = 0;

    Iterator<Child1> it = orgs.getParticles().iterator();
    while (it.hasNext()) {
      Child1 p = it.next();

      // compute the distance between each pair of organisms
      PVector dist = PVector.sub(p.getPosition(), position);
      if (dist.mag() < dna.getConnectionDistance() && dist.mag() > 0) {
        // desired direction is the opposite of the other organism closeby
        PVector desired = dist;
        totalDesired.add(desired);
        count++;
      }

      // detect a potential connection, to be implemented in Child4
      if (dist.mag() < dna.getConnectionDistance() && dist.mag() > 0) {
        connect(p);
      }
    }

    // steering force, based on Reynolds 
    if (count > 0) {
      //totalDesired.div(count);
      totalDesired.setMag(-dna.getMaxVelocity());
      // steering force is equal to the substraction between the desired direction and the current velocity
      PVector steer = PVector.sub(totalDesired, velocity); 
      //steer.limit(maxforce);
      return steer;
    }
    return new PVector(0, 0, 0);
  }

  // connect with child, to be implemented in Child3
  void connect(Child1 child) {
  }

  // display the child
  void display() {
    super.display();
  }
}