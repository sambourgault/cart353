class DNA {  
  // physical attributes
  float size;
  float maxVelocity;
  color colorShell;
  color initialCol;

  // internal attributes
  float lifeExpectancy;
  float connectionDistance;
  float maxProximity;

  // connection attributes
  float habilityToConnect;
  int numberOfConnections;

  // replication attributes
  float replicationRate;

  // fitness
  float fitness;

  // METHODS
  // Constructor
  DNA() {
    // set a random size
    size = random(5, 8);
    // set the maxVelocity according to the size. smaller = faster
    maxVelocity = 0.5/size;
    // set a grey color
    colorShell = color(random(190, 230));
    initialCol = colorShell;
    // set a maximum proximity
    maxProximity = random(5, 10);
    // set a maximum distance 
    connectionDistance = random(30, 50);
    // set number of connections
    numberOfConnections = 3;
  }


  // crossover: get DNA info from all the connected parents
  DNA crossover(HashMap<Integer, Child1> hm) {
    // create a new DNA
    DNA tempDNA = new DNA();
    // define four components that will be transfered
    float tempSize = 0;
    float tempMaxProx = 0;
    float tempMaxVelo = 0;
    int tempNumberOfConnections = 0;
    // get the components from all the parents
    Iterator<Map.Entry<Integer, Child1>> iter = hm.entrySet().iterator();
    while (iter.hasNext()) {
      Map.Entry<Integer, Child1> entry = iter.next();
      tempSize += hm.get(entry.getKey()).getDNA().getSize();
      tempMaxProx += hm.get(entry.getKey()).getDNA().getMaxProximity();
      tempMaxVelo += hm.get(entry.getKey()).getDNA().getMaxVelocity();
      tempNumberOfConnections += hm.get(entry.getKey()).getDNA().getNumberOfConnections();
    }

    // compute the average of the components
    tempSize /= hm.size();
    tempMaxProx /= hm.size();
    tempMaxVelo /= hm.size();
    tempNumberOfConnections = (int) tempNumberOfConnections/hm.size();

    // set these averages to the new DNA
    tempDNA.setSize(tempSize);
    tempDNA.setMaxProximity(tempMaxProx);
    tempDNA.setMaxVelocity(tempMaxVelo);
    tempDNA.setNumberOfConnections(tempNumberOfConnections);
    tempDNA.setColor(color(255, 0, 0));

    return tempDNA;
  }

  // GETTERS
  float getSize() {
    return size;
  }

  color getColor() {
    return colorShell;
  }

  color getInitialColor() {
    return initialCol;
  }

  float getMaxVelocity() {
    return maxVelocity;
  }

  float getMaxProximity() {
    return maxProximity;
  }

  float getConnectionDistance() {
    return connectionDistance;
  }

  int getNumberOfConnections() {
    return numberOfConnections;
  }

  // SETTERS
  void setSize(float newSize) {
    size = newSize;
  }

  void setMaxVelocity(float newVelocity) {
    maxVelocity = newVelocity;
  }

  void setMaxProximity(float newMaxProximity) {
    maxProximity = newMaxProximity;
  }

  void setNumberOfConnections(int newNumber) {
    numberOfConnections = newNumber;
  }

  void setColor(color newCol) {
    colorShell = newCol;
  }
}