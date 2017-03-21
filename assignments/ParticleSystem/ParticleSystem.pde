class ParticleSystem {
  ArrayList<Particle> particles;
  PVector location;
  // type of particles
  int typeOfParticle;


  // constructor
  ParticleSystem(PVector loc, int type) {
    particles = new ArrayList<Particle>();
    location = new PVector(loc.x, loc.y, loc.z);
    typeOfParticle = type;
  }

  // add particles according to its type
  void addParticle() {
    if (typeOfParticle == 1) {
      particles.add(new Geyser(location));
    } else if (typeOfParticle == 2) {
      particles.add(new Bat(location));
    } else if (typeOfParticle == 3) {
      particles.add(new Butterfly(location));
    } else if (typeOfParticle == 4) {
      particles.add(new Cloud(location));
    }
  }

  // apply a force on all particles of the systen
  void applyForce(PVector f) {
    for (Particle p : particles) {
      p.applyForce(f);
    }
  }

  // go over the particle system through iterators to determine if a particle is dead
  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        // remove the particle from the array if it's dead
        it.remove();
      }
    }
  }

  // get the location
  PVector getLocation() {
    return location;
  }

  // set the location
  void setLocation(PVector loc) {
    location = loc;
  }
}