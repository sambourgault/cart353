// this class adds the notion of connections

class Child4 extends Child3 {

  //constructor
  Child4(DNA newDna, int newID, PVector newPosition, Environment2 newEnv) {
    super(newDna, newID, newPosition, newEnv);
    connected = false;
    childConnectedTo = new ArrayList<Child1>();
  }

  // methods
  // apply all the force on the organism
  void applyBehaviors(ParticleSystem orgs) {
    super.applyBehaviors(orgs);
  }

  // connect to organism close to each other
  void connect(Child1 child) {
    stroke(255);
    childConnectedTo.add(child);
    numberOfConnections++;
    strokeWeight(1);
    beginShape(LINES);
    vertex(child.getPosition().x, child.getPosition().y, child.getPosition().z);
    vertex(this.getPosition().x, this.getPosition().y, this.getPosition().z);
    endShape();
  }

  void display() {
    super.display();
  }

  //Setters and getters
  int getNumberOfConnections() {
    return numberOfConnections;
  }

  void setNumberOfConnections(int noc) {
    numberOfConnections = noc;
  }
}