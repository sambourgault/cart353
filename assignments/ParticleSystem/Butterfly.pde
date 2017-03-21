class Butterfly extends Particle {
  // color
  color colorBut;

  // constructor
  Butterfly(PVector location) {
    super(location);

    // set a random orange color
    colorBut = color(random(240, 255), random(50, 80), 0);
  }

  // overwrite the update function to decrease life expectancy
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= random(4.0);
  }

  // display the butterfly as two triangles
  void display() {
    float angle = velocity.heading();

    noStroke();
    fill(colorBut);
    pushMatrix();
    translate(super.location.x, super.location.y);
    rotate(angle + PI/2);
    triangle(0, 0, -7, -7, -7, 7); 
    triangle(0, 0, 7, -7, 7, 7); 
    popMatrix();
  }
}