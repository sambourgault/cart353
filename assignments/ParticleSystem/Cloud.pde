class Cloud extends Particle {
  // constructor
  Cloud(PVector location) {
    super(location);
    super.velocity = new PVector(random(-0.1, 0.1), random(-0.1, 0.1), random(-0.1, 0.1));
  }

  // display the cloud as a bunch of ellipses
  void display() {
    noStroke();
    fill(0, 0, 255, 100);
    pushMatrix();
    translate(0, 0, location.z);
    ellipse(super.location.x, super.location.y, 20, 20);
    popMatrix();
  }
}