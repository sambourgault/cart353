class Field {
  // Attributes
  PVector field[][][];
  float x0;
  float y0;
  float z0;
  float offset;
  int cellsize; // resolution
  int numberOfVector;

  //Methods
  // constructor
  Field() {
    cellsize = 50; 
    numberOfVector = width/cellsize;
    field = new PVector[numberOfVector][numberOfVector][numberOfVector];
    x0 = random(100);
    y0 = random(50);
    z0 = random(30);
    offset = 0.1;

    // create the vector field
    for (int i = 0; i < numberOfVector; i++) {
      for (int j = 0; j < numberOfVector; j++) {
        for (int k = 0; k < numberOfVector; k++) {
          field[i][j][k] = new PVector(map(noise(x0+i*offset), 0, 1, -1, 1), map(noise(y0+j*offset), 0, 1, -1, 1), map(noise(z0+k*offset), 0, 1, -1, 1));
          field[i][j][k].normalize();
        }
      }
    }
  }

  // source: chapter 6, daniel shiffman
  PVector lookup(PVector position) {
    int column = int(constrain(position.x/cellsize, 0, field.length-1));
    int row = int(constrain(position.y/cellsize, 0, field[0].length-1));
    int depth = int(constrain(position.z/cellsize, 0, field[1].length-1));
    return field[column][row][depth];
  }

  // modify the orientation of the vectors 
  void changeTheField() {
    x0 = random(100);
    y0 = random(100);
    z0 = random(100);

    for (int i = 0; i < numberOfVector; i++) {
      for (int j = 0; j < numberOfVector; j++) {
        for (int k = 0; k < numberOfVector; k++) {
          field[i][j][k] = new PVector(map(noise(x0+i*offset), 0, 1, -1, 1), map(noise(y0+j*offset), 0, 1, -1, 1), map(noise(z0+k*offset), 0, 1, -1, 1));
          field[i][j][k].normalize();
        }
      }
    }
  }
}