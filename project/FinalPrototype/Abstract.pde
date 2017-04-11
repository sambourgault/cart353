// this class is abstract

abstract class Abstract {
  // attributes
  PVector position;
  DNA dna;
  int ID;
  float size;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float dyingCol;

  // state attributes
  float lifePoints;
  boolean alive;

  // attributes for the cluster (level 5 to 7)
  boolean visited;
  int inCluster;

  // environment attributes
  Environment2 env;

  // connection attribute
  boolean connected;
  ArrayList<Child1> childConnectedTo;
  IntList connectedID;
  int numberOfConnections;

  //METHODS
  // Constructor
  Abstract(DNA newDna, int newID, PVector newPosition, Environment2 newEnv) {
    // dna
    dna = newDna;
    size = dna.getSize();
    ID = newID; 

    // position, velocity and acceleration
    position = new PVector();
    position = newPosition;
    velocity= new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    maxforce = 30; 
    //colorC = color(255);

    // state
    lifePoints = random(400, 700);
    alive = true;
    visited = false;
    inCluster = -1;

    // connection
    childConnectedTo = new ArrayList<Child1>();
    connectedID = new IntList();
    numberOfConnections = 0;

    // environment
    env = new Environment2();
    env = newEnv;
  }

  // apply all the force on the organism
  void applyBehaviors() {
    // lose point if not connected
    if (numberOfConnections == 0) {
      lifePoints--;
    } 
    // gain points when connected
    else {
      lifePoints += numberOfConnections;
    }

    // decrease the color of the dying child
    float colGray = (red(dna.getColor())+green(dna.getColor())+blue(dna.getColor()))/3;
    if (lifePoints < colGray) {
      dna.setColor(color(colGray-1));

      // if no more lifePoints set to dead
      if (lifePoints <= 0) {
        alive = false;
        dna.setColor(color(dna.getInitialColor()));
        totalDeath++;
      }
    }
  }

  // display the organism
  void display() {
  }

  // move the organism
  void move() {
  }

  // apply a force on the Child
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  // check if the organism is dead or not
  boolean isDead() {
    return !alive;
  }

  // GETTERS AND SETTERS
  PVector getPosition() {
    return position;
  }

  PVector getVelocity() {
    return velocity;
  }

  int getID() {
    return ID;
  }

  DNA getDNA() {
    return dna;
  }

  boolean getVisited() {
    return visited;
  }

  boolean getAliveStatus() {
    return alive;
  } 

  void setVisited(boolean vis) {
    visited = vis;
  }

  void setInCluster(int C) {
    inCluster = C;
  }


  int getInCluster() {
    return inCluster;
  }
}