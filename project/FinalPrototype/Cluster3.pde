// add the breathing to the cluster

class Cluster3 extends Cluster2 {
  // attributes
  int breathLength;

  // methods
  // constructor
  Cluster3(int id) {
    super(id);
    breathLength = 600; //(int) random(550, 600);
  }

  // apply behavior of the cluster
  void applyBehaviors() {
    // apply attraction & repulsion to every element of the cluster
    Iterator<Map.Entry<Integer, Child1>> iter = orgs.entrySet().iterator();
    while (iter.hasNext()) {
      Map.Entry<Integer, Child1> entry = iter.next();
      PVector attraction = attraction(orgs.get(entry.getKey()));

      //breathing phenomenon
      if (frameCount % breathLength < (int) breathLength/2) {
        // breath in
        attraction.mult(0.8);
      } else {
        // breath out
        attraction.mult(-0.5);
      }
      // apply the forces
      orgs.get(entry.getKey()).applyForce(attraction);
    }
  }

  // compute the attraction of each organism toward the center of the cluster
  PVector attraction(Child1 org) {
    // compute the desired direction
    //PVector desired = new PVector(0, 0, 0);
    PVector desired = PVector.sub(position, org.getPosition());
    desired.setMag(org.getDNA().getMaxVelocity());
    // steering is desired direction minus velocity
    PVector steer = PVector.sub(desired, org.getVelocity());
    return steer;
  }
}