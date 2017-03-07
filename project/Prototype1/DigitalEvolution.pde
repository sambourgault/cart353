// Digital Evolution - Prototype1
// Final Project CART353
// Author: Samuelle Bourgault
// Date: March 7, 2017

// Initialize environment, children and dnas
Environment env;
DNA dna1;
ArrayList<Child> globalOrgs;
ArrayList<Child> tempChild;
ArrayList<DNA> dnas;
// Initialize the global ID
int globalID;


void setup() {
  size(500, 500);
  // Create the environment, the children and the dnas
  env = new Environment();
  globalOrgs = new ArrayList<Child>();
  //tempChild = new ArrayList<Child>();
  dnas = new ArrayList<DNA>();
  globalID = -1;
  for (int i = 0; i < 70; i++) {
    dnas.add(new DNA());
    // increment the global ID 
    globalID++;
    globalOrgs.add(new Child(dnas.get(i), globalID, new PVector(width/2 + random(-100, 100), height/2 + random(-100, 100)), env));
  }
}


void draw() {
  // display the environment
  env.display();

  // create a new temporary arraylist of child to store the new child
  tempChild = new ArrayList<Child>();

  // apply the behaviors, the movement and the display of the Child
  for (Child org : globalOrgs) {
    org.applyBehaviors(globalOrgs);
    org.move();
    org.display();
    tempChild.add(org.replicate());
  }
  
  // add new child to main globalOrgs arraylist
  for (Child org2 : tempChild) {
    if (org2 != null) {
      globalOrgs.add(org2);
    }
  }
}