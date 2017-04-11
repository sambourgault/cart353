// add reproduction to the cluster

class Cluster5 extends Cluster4 {

  // methods
  // constructor
  Cluster5(int id) {
    super(id);
  }


  // apply the behaviors of the cluster
  void applyBehaviors() {
    super.applyBehaviors(); 

    //add replication 
    replicate();
  }


  // reproduction of a new Child
  void replicate() {
    // an organism can reproduce only if in a cluster
    if (millis() % 70 == 0) {
      // create a DNA based on parental heritage 
      DNA childDNA = new DNA().crossover(orgs);
      // create the new Child
      Child4 newChild = new Child4(childDNA, globalID, new PVector(position.x+random(-10, 10), position.y+random(-10, 10), position.z+random(-10, 10)), env);
      orgs.put(globalID, newChild);
      partSyst.get(7).addOneParticle(newChild);
      globalID++;
    }
  }
}