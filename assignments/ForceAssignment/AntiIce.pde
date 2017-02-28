class AntiIce {
  /** parameters **/
  PVector position;
  PVector size;
  float frictionCoef;

  /** methods **/
  // constructor
  AntiIce() {
    position = new PVector((int)random(10)*(width/10), (int)random(10)*(height/10));
    size = new PVector(width/10, height/10);
    frictionCoef = 0.1;
  }

  // display the Anti-Ice spot
  void display() {
    fill(255);
    noStroke();
    rect(position.x, position.y, size.x, size.y);
  }

  // getters & setters
  float getX() {
    return position.x;
  }

  float getY() {
    return position.y;
  }

  float getSizeX() {
    return size.x;
  }

  float getSizeY() {
    return size.y;
  }

  float getCoef() {
    return frictionCoef;
  }
}