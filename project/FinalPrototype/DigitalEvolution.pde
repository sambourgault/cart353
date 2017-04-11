// new classOrganism - Final Prototype
// Final Project CART353
// Author: Samuelle Bourgault
// Date: April 10, 2017


// libraries
import java.util.Iterator;
import java.util.Map;

// Initialize environment, dnas and particles systems
Environment2 env;
int depth;
// dnas
int numberOfIndividuals;
ArrayList<DNA> dnas;
// particles systems
ArrayList<ParticleSystem> partSyst;

// cluster for level 5
ArrayList<Cluster3> clusters3;
// cluster for level 6
ArrayList<Cluster4> clusters4;
// cluster for level 7
ArrayList<Cluster5> clusters5;
boolean clustering;
boolean clustering2;
boolean clustering3;

// Initialize the global ID
int globalID;

// Runtime of each state
float runtime;
float currentFrame;
int currentLevel;
int lastLevel;
int totalDeath;
boolean [] allDead;
boolean levelJustChanged;


// text
String textLev1 = "abstract class cannot be instantiated." ;
String textLev1_2 = "experiment ";
String[] textLev2 = {"abstraction", "display", "flow in the field", "separation", "connection", "clustering", "cluster motion", "reproduction"};
String allD = "done";


void setup() {
  //size(500, 500, P3D);
  fullScreen(P3D);
  depth = 200;
  // create the environment, the children and the dnas
  env = new Environment2();

  // dnas arraylist
  numberOfIndividuals = 300;
  dnas = new ArrayList<DNA>();
  // filling up the dnas arraylist
  for (int i = 0; i < numberOfIndividuals; i++) {
    dnas.add(new DNA());
  }

  // particles systems arraylist
  partSyst = new ArrayList<ParticleSystem>();
  // filling up the particles systems
  for (int i = 0; i < 8; i++) {
    partSyst.add(new ParticleSystem(i));
    partSyst.get(i).addParticle();
  }

  // create clusters
  clusters3 = new ArrayList<Cluster3>();
  clusters4 = new ArrayList<Cluster4>();
  clusters5 = new ArrayList<Cluster5>();

  // clustering state
  clustering = true;
  clustering2 = true;
  clustering3 = true;


  // each levels lasts 1500 frames
  runtime = 300;
  currentFrame = 0;
  currentLevel = 0;
  totalDeath = 0;
  lastLevel = 7;
  allDead = new boolean[lastLevel+1];
  for (int i = 0; i < allDead.length; i++) {
    allDead[i] = false;
  }
  levelJustChanged = false;
}

void draw() {
  // display the environment
  env.display();
  // display the count down
  textSize(10);
  fill(255);
  // display the text
  text(int(currentFrame), 10, 20);
  text(textLev1_2 + currentLevel + ": " + textLev2[currentLevel], 10, height - 20 );
  // display all Dead text if all the organisms of the experiment are dead
  if (allDead[currentLevel] && currentLevel != 0) {
    text(allD, width/2 - textWidth(allD)/2, height/2);
  }

  // verify the death status
  if (levelJustChanged && !allDead[currentLevel]) {
    levelJustChanged = false;
    totalDeath = 0;
  }

  // runnning the right particleSystem to the right level
  switch(currentLevel) {
  case 0:
    textSize(10);
    fill(255);
    break;
  case 1:
    partSyst.get(currentLevel).run();
    break;
  case 2:
    partSyst.get(currentLevel).run();
    break;
  case 3:
    partSyst.get(currentLevel).run();
    break;
  case 4:
    partSyst.get(currentLevel).run();
    break;
  case 5:
    partSyst.get(currentLevel).run();
    // apply the clustering once
    if (clustering) {
      DBSCAN(partSyst.get(currentLevel), 75, 3);
      clustering = false;
    }
    // apply the cluster behavior and display
    for (Cluster3 c : clusters3 ) {
      //cluster exists only if it contains three or more individuals
      if (c.getHM().size() >= 3) {
        c.applyBehaviors();
        c.display();
      }
    }
    break;

  case 6:
    partSyst.get(currentLevel).run();
    // apply the clustering once
    if (clustering2) {
      DBSCAN(partSyst.get(currentLevel), 75, 3);
      clustering2 = false;
    }
    // apply the cluster behavior and display
    for (Cluster4 c : clusters4 ) {
      //cluster exists only if it contains three or more individuals
      if (c.getHM().size() >= 3) {
        c.applyBehaviors();
        c.display();
      }
    }
    break;

  case 7:
    partSyst.get(currentLevel).run();
    // apply the clustering once
    if (clustering3) {
      DBSCAN(partSyst.get(currentLevel), 75, 3);
      clustering3 = false;
    }
    // apply the cluster behavior and display
    for (Cluster5 c : clusters5 ) {
      //cluster exists only if it contains three or more individuals
      if (c.getHM().size() >= 3) {
        c.applyBehaviors();
        c.display();
      }
    }
    break;
  }

  // UPDATE the level if totalDeath == numberOfOrganism
  if (totalDeath == numberOfIndividuals || (currentLevel == 0 && currentFrame == runtime) || (allDead[currentLevel] && currentFrame == runtime)) {
    levelJustChanged = true;
    currentFrame = 0;
    allDead[currentLevel] = true;
    if (currentLevel == lastLevel) {
      currentLevel = 0;
    } else {
      currentLevel++;
    }
  } else {
    currentFrame++;
  }
}

// Used in order to change from one experiment to the other
void keyPressed() {
  if (key == ' ') {
    if (currentLevel == lastLevel) {
      currentLevel = 0;
    } else {
      levelJustChanged = true;
      currentLevel++;
    }
    currentFrame = 0;
  }
}

//******************//
//*** CLUSTERING ***//
//******************//

// based on pseudocode from wikipedia
// source: https://en.wikipedia.org/wiki/DBSCAN
void DBSCAN(ParticleSystem D, float eps, int MinPts) {
  int C = 0;
  for (Child1 c : D.getParticles()) {
    if (c.getVisited()) {
      //continue next point
    } else {
      // set the organism as visited
      c.setVisited(true);
      HashMap<Integer, Child1> NeighborPts = regionQuery(D, c, eps);
      if (NeighborPts.size() < MinPts) {
        //mark c as NOISE, so do nothing
      } else {    
        // add the right cluster to the right level
        if (currentLevel == 5) {
          Cluster3 cluster = new Cluster3(C);
          clusters3.add(cluster);
          expandCluster(D, c, NeighborPts, cluster, eps, MinPts);
        } else if (currentLevel == 6) {
          Cluster4 cluster = new Cluster4(C);
          clusters4.add(cluster);
          expandCluster(D, c, NeighborPts, cluster, eps, MinPts);
        } else if (currentLevel == 7) {
          Cluster5 cluster = new Cluster5(C);
          clusters5.add(cluster);
          expandCluster(D, c, NeighborPts, cluster, eps, MinPts);
        }
        C++;
      }
    }
  }
}

// check if the neighbors of the child can be added to the cluster
void expandCluster(ParticleSystem D, Child1 c, HashMap<Integer, Child1> NeighborPts, Cluster2 C, float eps, int MinPts) {
  // add c to cluster C
  C.addParticle(c);
  c.setInCluster(C.getID());

  // create temporary hashmap
  HashMap<Integer, Child1> tempHM = new HashMap<Integer, Child1>();

  for (Map.Entry me : tempHM.entrySet()) {
    NeighborPts.put(tempHM.get(me.getKey()).getID(), tempHM.get(me.getKey()));
  }

  // check if the neighbors of the child can be added to the cluster
  for (Map.Entry c2 : NeighborPts.entrySet()) { 
    if (!NeighborPts.get(c2.getKey()).getVisited()) {
      NeighborPts.get(c2.getKey()).setVisited(true);
      // query the region to verify the density around teach neighbor
      HashMap<Integer, Child1> NeighborPts2 = regionQuery(D, NeighborPts.get(c2.getKey()), eps);

      // find elements that are different from the ones that are already in the neighborhood
      if (NeighborPts2.size() >= MinPts) {
        tempHM.clear();

        // compare the new organisms found with the ones already part of the main hashmap NeighborPts
        for (Map.Entry me : NeighborPts.entrySet()) {
          for (Map.Entry me2 : NeighborPts2.entrySet()) {
            // add only the element if it's not already there
            if (me.getKey() != me2.getKey()) {
              tempHM.put(NeighborPts2.get(me2.getKey()).getID(), NeighborPts2.get(me2.getKey()));
            }
          }
        }
      }
    }
    // if it's not in a cluster add it to the main cluster
    if (NeighborPts.get(c2.getKey()).getInCluster() == -1) {
      C.addParticle(NeighborPts.get(c2.getKey()));
      NeighborPts.get(c2.getKey()).setInCluster(C.getID());
    }
  }
}

// check the region for close neighbors
HashMap<Integer, Child1> regionQuery(ParticleSystem D, Child1 c, float eps) {
  HashMap<Integer, Child1> hm = new HashMap<Integer, Child1>();
  // check the distance between the child and its neighbors
  for (Child1 c2 : D.getParticles()) {
    PVector distance = PVector.sub(c2.getPosition(), c.getPosition());
    float d = distance.mag();
    // add the neighbor to the hashmap if it's closer than eps
    if (d < eps) {
      hm.put(c2.getID(), c2);
    }
  }
  // add the original child to the cluster
  hm.put(c.getID(), c);
  return hm;
}