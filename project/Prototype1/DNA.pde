class DNA {  
  // physical attributes
  float size;
  float maxVelocity;
  color colorShell;

  // internal attributes
  float lifeExpectancy;
  float maxLoneliness;
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
    size = random(2, 5);
    // set the maxVelocity according to the size. smaller = faster
    maxVelocity = 0.5/size;
    // set a grey color
    colorShell = color(random(220, 255));
    // set a maximum proximity
    maxProximity = random(15, 30);
    // set number of connections
    numberOfConnections = 3;
  }


  // crossover: get DNA info from all the connected parents
  DNA crossover(ArrayList<Child> childAL) {
    // create a new DNA
    DNA tempDNA = new DNA();
    // define four components that will be transfered
    float tempSize = 0;
    float tempMaxProx = 0;
    float tempMaxVelo = 0;
    int tempNumberOfConnections = 0;
    // get the components from all the parents
    for (int i = 0; i < childAL.size(); i++) {
      tempSize += childAL.get(i).getDNA().getSize();
      tempMaxProx += childAL.get(i).getDNA().getMaxProximity();
      tempMaxVelo += childAL.get(i).getDNA().getMaxVelocity();
      tempNumberOfConnections += childAL.get(i).getDNA().getNumberOfConnections();
    }

    // compute the average of the components
    tempSize /= childAL.size();
    tempMaxProx /= childAL.size();
    tempMaxVelo /= childAL.size();
    tempNumberOfConnections = (int) tempNumberOfConnections/childAL.size();

    // set these averages to the new DNA
    tempDNA.setSize(tempSize);
    tempDNA.setMaxProximity(tempMaxProx);
    tempDNA.setMaxVelocity(tempMaxVelo);
    tempDNA.setNumberOfConnections(tempNumberOfConnections);

    return tempDNA;
  }

  // NOT WORKING NOW
  //Mutation of the gene
  void mutate() {
  }

  // GETTERS
  float getSize() {
    return size;
  }

  float getMaxVelocity() {
    return maxVelocity;
  }

  float getMaxProximity() {
    return maxProximity;
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
}