class Environment2 {
  // ATTRIBUTES
  Field fieldflow;
  float depth;
  float cellsize;
  float cellsizeH;
  float lenghtLines;

  // METHODS
  // constructor
  Environment2() {
    // assign values to parameters
    fieldflow = new Field();
    depth = 200;
    cellsizeH = 100;
    cellsize = width/10;
    lenghtLines = 5;
  }

  // display the environment
  void display() {
    background(0);

    // add a white box to limit the space
    noFill();
    stroke(75);
    strokeWeight(1);

    // two squares
    pushMatrix();
    translate(0, 0, -20);
    rect(0, 0, width, height);
    translate(0, 0, -depth);
    rect(0, 0, width, height);
    popMatrix();

    // white lines
    beginShape(LINES);
    vertex(0, 0, -20);
    vertex(0, 0, -depth-20);
    endShape();

    beginShape(LINES);
    vertex(width, 0, -20);
    vertex(width, 0, -depth-20);
    endShape();

    beginShape(LINES);
    vertex(width, height, -20);
    vertex(width, height, -depth-20);
    endShape();

    beginShape(LINES);
    vertex(0, height, -20);
    vertex(0, height, -depth-20);
    endShape();

    // create measurement lines
    strokeWeight(2);
    for (int i = 0; i < width/cellsize+1; i++) {
      for (int j = 0; j < width/cellsize+1; j++) {
        for (int k = 0; k < depth/cellsize+1; k++) {
          // add line in xy planes
          pushMatrix();
          translate(0, 0, -k*cellsizeH-20);
          line(i*cellsize-lenghtLines, j*cellsize, i*cellsize+lenghtLines, j*cellsize);
          line(i*cellsize, j*cellsize-lenghtLines, i*cellsize, j*cellsize+lenghtLines);
          popMatrix();
        }
      }
    }

    // change the field once in a while :)
    if (frameCount % 500 == 0) {
      fieldflow.changeTheField();
    }
  }

  // GETTERS
  PVector lookup(PVector pos) {
    return fieldflow.lookup(pos);
  }
}