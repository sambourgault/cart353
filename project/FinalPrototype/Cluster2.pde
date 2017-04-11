class Cluster2 {
  // attributes
  HashMap<Integer, Child1> orgs; 
  int ID;
  PVector position;
  PVector tempPos;
  float size;

  // methods
  // constructor
  Cluster2(int id) {
    orgs = new HashMap<Integer, Child1>();
    ID = id;
    position = new PVector(0, 0, 0);
    size = 70;
  }

  // add a particle to the cluster
  void addParticle(Child1 c) {
    orgs.put(c.getID(), c);

    if (orgs.size() == 1) {
      position = c.position;
    } else {
      position = PVector.add(position.mult(orgs.size()-1), (c.position)).div(orgs.size());
    }
  }

  // display the cluster
  void display() {
    // compute the new position
    tempPos = new PVector(0, 0, 0);

    // recompute the position each iteration according to its children
    Iterator<Map.Entry<Integer, Child1>> iter = orgs.entrySet().iterator();
    while (iter.hasNext()) {
      Map.Entry<Integer, Child1> entry = iter.next();
      // if the child is dead or to far, remove it from the cluster
      if (!orgs.get(entry.getKey()).getAliveStatus() || PVector.sub(position, orgs.get(entry.getKey()).getPosition()).mag() > size) {
        iter.remove();
      } else {
        tempPos = tempPos.add(orgs.get(entry.getKey()).position);
      }
    }
    // reset the position
    position = tempPos.div(orgs.size());

    // display as a green box
    pushMatrix();
    translate(position.x, position.y, position.z);
    stroke(0, 255, 0);
    noFill();
    box(10);
    popMatrix();
  }

  // Getters & Setters
  int getID() {
    return ID;
  }

  HashMap<Integer, Child1> getHM() {
    return orgs;
  }
}