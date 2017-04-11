class ParticleSystem {
  // ATTRIBUTES
  ArrayList<Child1> particles;
  int typeOfParticle;

  // METHODS
  // constructor
  ParticleSystem(int type) {
    particles = new ArrayList<Child1>();
    typeOfParticle = type;
  }

  // add particles according to its type
  void addParticle() {
    if (typeOfParticle == 0) {
      //particles.add(new Geyser(location));
    } else if (typeOfParticle == 1) {
      globalID = 0;
      for (int i = 0; i < dnas.size(); i++) {
        float radius = getRadius();
        float angleP = random(2*PI);
        particles.add(new Child1(dnas.get(i), i, new PVector(width/2 + radius*cos(angleP), height/2 + radius*sin(angleP), -depth/2 + random(-75, 75)), env));
        globalID++;
      }
    } else if (typeOfParticle == 2) {
      globalID = 0;
      for (int i = 0; i < dnas.size(); i++) {
        float radius = getRadius();
        float angleP = random(2*PI);
        particles.add(new Child2(dnas.get(i), i, new PVector(width/2 + radius*cos(angleP), height/2 + radius*sin(angleP), -depth/2 + random(-75, 75)), env));
        globalID++;
      }
    } else if (typeOfParticle == 3) {
      globalID = 0;
      for (int i = 0; i < dnas.size(); i++) {
        float radius = getRadius();
        float angleP = random(2*PI);
        particles.add(new Child3(dnas.get(i), i, new PVector(width/2 + radius*cos(angleP), height/2 + radius*sin(angleP), -depth/2 + random(-75, 75)), env));
        globalID++;
      }
    } else if (typeOfParticle == 4) {
      globalID = 0;
      for (int i = 0; i < dnas.size(); i++) {
        float radius = getRadius();
        float angleP = random(2*PI);
        particles.add(new Child4(dnas.get(i), i, new PVector(width/2 + radius*cos(angleP), height/2 + radius*sin(angleP), -depth/2 + random(-75, 75)), env));
        globalID++;
      }
    } else if (typeOfParticle == 5) {
      globalID = 0;
      for (int i = 0; i < dnas.size(); i++) {
        float radius = getRadius();
        float angleP = random(2*PI);
        particles.add(new Child4(dnas.get(i), i, new PVector(width/2 + radius*cos(angleP), height/2 + radius*sin(angleP), -depth/2 + random(-75, 75)), env));
        globalID++;
      }
    } else if (typeOfParticle == 6) {
      globalID = 0;
      for (int i = 0; i < dnas.size(); i++) {
        float radius = getRadius();
        float angleP = random(2*PI);
        particles.add(new Child4(dnas.get(i), i, new PVector(width/2 + radius*cos(angleP), height/2 + radius*sin(angleP), -depth/2 + random(-75, 75)), env));
        globalID++;
      }
    } else if (typeOfParticle == 7) {
      globalID = 0;
      for (int i = 0; i < dnas.size(); i++) {
        float radius = getRadius();
        float angleP = random(2*PI);
        particles.add(new Child4(dnas.get(i), i, new PVector(width/2 + radius*cos(angleP), height/2 + radius*sin(angleP), -depth/2 + random(-75, 75)), env));
        globalID++;
      }
    }
  }

  // add particles to the particleSystem
  void addOneParticle(Child1 p) {
    particles.add(p);
  }

  // apply a force on all particles of the systen
  void applyForce(PVector f) {
    for (Child1 p : particles) {
      p.applyBehaviors();
    }
  }

  // go over the particle system through iterators to determine if a particle is dead
  void run() {
    Iterator<Child1> it = particles.iterator();
    while (it.hasNext()) {
      Child1 p = it.next();
      p.applyBehaviors(this);
      p.move();
      p.display();

      // remove the particle from the array if it's dead
      if (p.isDead()) {
        it.remove();
      }
    }
  }

  // Getter
  ArrayList<Child1> getParticles() {
    return particles;
  }

  // get a probabilistic distribution of radius
  float getRadius() {
    float r = random(10);
    float radius = 0;
    if (r < 7) {
      radius = random(180);
    } else {
      radius = random(180, 270);
    }
    return radius;
  }
}