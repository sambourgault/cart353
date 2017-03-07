class Child {
  PVector position;
  DNA dna;
  int ID;
  float size;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  color colorC; // eventuellement vient du DNA!!!!!!!!

  // state attributes
  float lifePoints;
  boolean alive;
  boolean connected;

  // environment attributes
  Environment env;
  ArrayList<Connection> connections;
  ArrayList<Child> childConnectedTo;
  IntList connectedID;

  //METHODS
  // Constructor
  Child(DNA newDna, int newID, PVector newPosition, Environment newEnv) {
    // dna
    dna = newDna;
    size = dna.getSize();
    ID = newID; 

    // position, velocity and acceleration
    position = new PVector();
    position = newPosition;
    velocity= new PVector(0, 0);
    acceleration = new PVector(0, 0);
    maxforce = 0.5; 
    colorC = color(255);

    // state
    lifePoints = random(200, 300);
    alive = true;

    // connection
    connected = false;
    connections = new ArrayList<Connection>();
    childConnectedTo = new ArrayList<Child>();
    connectedID = new IntList();

    // environment
    env = new Environment();
    env = newEnv;
  }

  void display() {
    if (alive) {
      noStroke();
      fill(colorC);
      rect(position.x, position.y, size, size);

      // display all the connections
      for (int i = 0; i < connections.size(); i++) {
        connections.get(i).display();
      }

      // display shapes between connections, the verteses correspond to the connection points
      if (connections.size() > 1) {
        fill(255, 50);
        noStroke();
        // create the shape
        beginShape();
        vertex(position.x, position.y);
        for (int j = 0; j < connections.size(); j++) {
          if (connections.get(j).getConnectionPoints()[0].getID() == ID) {
            vertex(connections.get(j).getConnectionPoints()[1].getPosition().x, connections.get(j).getConnectionPoints()[1].getPosition().y);
          } else {
            vertex(connections.get(j).getConnectionPoints()[0].getPosition().x, connections.get(j).getConnectionPoints()[0].getPosition().y);
          }
        }
        endShape(CLOSE);
      }
    }
  }

  // apply a force on the Child
  void applyForce(PVector force) {
    PVector f = PVector.div(force, size);
    acceleration.add(f);
  }

  // separate the individuals one from each other
  // source: from chap 6 The nature of code 
  PVector separate(ArrayList<Child> orgs) {
    int count = 0;
    PVector totalDesired = new PVector();
    for (Child org : orgs) {
      PVector dist = PVector.sub(org.getPosition(), position);
      if (dist.mag() < dna.getMaxProximity() && dist.mag() > 0) {
        // desired direction is the opposite of the other organism closeby
        PVector desired = dist;
        desired.mult(-1);
        desired.normalize();

        totalDesired.add(desired);
        count++;
      }

      // look for connection between close individuals
      if (dist.mag() > 0) {
        connect(org, dist);
      }
    }

    // steering force, based on Reynolds 
    if (count > 0) {
      totalDesired.div(count);
      totalDesired.setMag(dna.getMaxVelocity());
      // steering force is equal to the substraction between the desired direction and the current velocity
      PVector steer = PVector.sub(totalDesired, velocity); 
      steer.limit(maxforce);
      return steer;
    }
    return new PVector(0, 0);
  }

  // connect to organism close to each other
  void connect(Child org, PVector distance) {

    boolean alreadyConnected = false;
    int connectionNumber = -1;
    // verified if the organisms are already connected
    if (connections.size() > 0) {
      for (int i = 0; i < connections.size(); i++) {
        // look into the arraylist connectedID
        if (org.getID() == connectedID.get(i)) {
          // if connected set alreadyConnected to TRUE
          alreadyConnected = true;
          // remember the position of the connectedID in the arraylist
          connectionNumber = i;
        }
      }
    }
    // connect the organisms with each other if they are close and if they were not already connected
    if (distance.mag() < dna.getMaxProximity() && !alreadyConnected) {
      connections.add(new Connection(org, this));
      childConnectedTo.add(org);
      connectedID.append(org.getID());
    } 
    // disconnect them if they become farther appart and they were already connected
    else if (distance.mag() >= dna.getMaxProximity() && alreadyConnected) {
      connections.remove(connectionNumber);
      childConnectedTo.remove(org);
      connectedID.remove(connectionNumber);
    }
  }

  // compute the force of the vectorial field from the environment
  // source chap 6 The Nature of code, based on Reynolds
  PVector flow() {
    // compute the desired direction
    PVector desired = env.getVector(position.x, position.y);
    desired.setMag(dna.getMaxVelocity());

    // steering is desired direction minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    return steer;
  }

  // apply all the force on the organism
  void applyBehaviors(ArrayList<Child> orgs) {
    // separate the organism from the other individuals
    PVector separate = separate(orgs);
    // allow the organism to follow the vectorial field
    PVector flow = flow();

    // give an amplitude to each force
    separate.mult(1);
    flow.mult(1.3);

    // apply the forces
    applyForce(separate);
    applyForce(flow);
  }

  // set the movement of the organism
  void move() {
    // compute the lifePoints
    // loose one everyframe if alone (not connected)
    if (connections.size() == 0) {
      lifePoints--;
    } 
    // gain points when connected following a quadratic function
    else {
      lifePoints += sq(connections.size());
    }
    
    // if no more lifePoints set to dead
    if (lifePoints <= 0) {
      alive = false;
    }
    
    // constrain the acceleration
    acceleration.x = constrain(acceleration.x, -1, 1);
    acceleration.y = constrain(acceleration.y, -1, 1);
    // compute and constrain the velocity
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, -dna.getMaxVelocity(), dna.getMaxVelocity());
    velocity.y = constrain(velocity.y, -dna.getMaxVelocity(), dna.getMaxVelocity());
    // compute and constrain the posisition
    position.add(velocity);

    if (position.x - size/2 > width || position.x + size/2 < 0) {
      velocity.x = -velocity.x;
    }

    if (position.y - size/2 > height || position.y + size/2 < 0) {
      velocity.y = -velocity.y;
    }
    
    // reinitialize the acceleration
    acceleration.mult(0);
  }
  
  // reproduction of a new Child
  Child replicate() {
    // an organism can reproduce only if fully connected
    if (connections.size() == dna.getNumberOfConnections() && frameCount % 50 == 0) {
      // create a DNA based on parental heritage 
      DNA childDNA = new DNA();
      childDNA.crossover(childConnectedTo);
      // create the new Child
      globalID++;
      Child newChild = new Child(childDNA, globalID, new PVector(position.x+random(-2,2), position.y+random(-2,2)), env);
      // set a new color to make it obvious
      newChild.setColor(color(255, 0, 0));
      return newChild;
    }
    return null;
  }

  // GETTERS AND SETTERS
  PVector getPosition() {
    return position;
  }

  int getID() {
    return ID;
  }

  DNA getDNA() {
    return dna;
  }
  
  boolean getAliveStatus(){
    return alive;
  } 

  void setColor(color newColor) {
    colorC = newColor;
  }
}