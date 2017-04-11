// this class adds the notion of display

class Child1 extends Abstract {

  //constructor
  Child1(DNA newDna, int newID, PVector newPosition, Environment2 newEnv) {
    super(newDna, newID, newPosition, newEnv);
  }

  // methods
  // apply all the force on the organism
  void applyBehaviors(ParticleSystem orgs) {
    super.applyBehaviors();
  }


  void display() {
    if (alive) {
      // display as a sphere
      pushMatrix();
      translate(position.x, position.y, position.z);
      noFill();
      stroke(dna.getColor());
      sphereDetail(4);
      sphere(size);
      popMatrix();

      // display shapes between connections, the verteses correspond to the connection points
      if (childConnectedTo.size() > 1) {
        // create the shape between connections
        beginShape();
        fill(255, 50);
        noStroke();
        vertex(position.x, position.y, position.z);
        for (int j = 0; j < childConnectedTo.size(); j++) {
          vertex(childConnectedTo.get(j).getPosition().x, childConnectedTo.get(j).getPosition().y, childConnectedTo.get(j).getPosition().z);
        }
        endShape(CLOSE);
      }

      // remove the connection every iteration
      for (int i = 0; i < childConnectedTo.size(); i++) {
        childConnectedTo.remove(i);
        numberOfConnections--;
      }
    }
  }
}