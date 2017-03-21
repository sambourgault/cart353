class Geyser extends Particle {
  // constructor
  Geyser(PVector location) {
    super(location);
    super.velocity = new PVector(random(-0.1, 0.1), random(0, -0.5), random(-0.1, 0.1));
  }

  // display the geyser as small water drops
  void display() {
    noStroke();
    fill(255);
    pushMatrix();
    translate(0, 0, location.z);
    ellipse(super.location.x, super.location.y, 1, 1);
    popMatrix();
  }
}