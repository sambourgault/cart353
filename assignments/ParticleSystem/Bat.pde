class Bat extends Particle {
  // color
  color colorBat;

  // constructor
  Bat(PVector location) {
    super(location);

    // set a random grey color
    colorBat = color(random(60, 90));
  }


  // display the bat as two lines
  void display() {
    stroke(colorBat);
    strokeWeight(2);
    pushMatrix();
    translate(super.location.x, super.location.y, super.location.z);
    line(0, 0, -8, -8);
    line(0, 0, 8, -8);
    popMatrix();
  }
}