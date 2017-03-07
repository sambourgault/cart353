class Environment {
  // ATTRIBUTES
  float x0;
  float y0;
  // value for the color
  float [][] gridValues;
  // value for the vectorial field
  PVector [][] gridVectors;
  // offset for perlin noise
  float offset;

  // METHODS
  // constructor
  Environment() {
    // assign values to parameters
    x0 = random(100);
    y0 = random(100);
    offset = 0.01;

    gridValues = new float[width][height];
    gridVectors = new PVector[width][height];

    // compute the gridValue according to 2D perlin noise
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < width; j++) {
        gridValues[i][j] = noise(x0 + i * offset, y0 + j * offset);
      }
    }

    // create vectors 
    for (int i = 1; i < width-1; i++) {
      for (int j = 1; j < height-1; j++) {
        gridVectors[i][j] = new PVector();
        gridVectors[i][j] = computeVector(i, j);
      }
    }
  }

  // compute a vector between two different 
  PVector computeVector(int i, int j) {
    PVector derivative = new PVector();
    PVector origine = new PVector(i, j);

    // create the arraylist of PVector
    ArrayList<PVector> nextStep = new ArrayList<PVector>();
    nextStep.add(new PVector(i, j, 0));

    // for each grid point, compute the orientation according to the value of surrounding pixels
    for (int x = i - 1; x < i + 2; x++) {
      for (int y = j - 1; y < j + 2; y++) {
        // if the position is not itself
        if (x != i || y != j) {
          // check which surrounding pixels as the greater value
          if (gridValues[x][y] == nextStep.get(0).z) {
            nextStep.add(new PVector(x, y, gridValues[x][y]/255));
          } else if ( gridValues[x][y] > nextStep.get(0).z) {
            for (int k = 0; k < nextStep.size(); k++) {
              nextStep.remove(k);
            }
            // set nextStep to the greater value
            nextStep.add(new PVector(x, y, gridValues[x][y]));
          }
        }
      }
    }

    // determine the derivative from nextStep
    // if more than one element in nextStep take one randomly
    if (nextStep.size() > 0) {
      int randomPick = (int) random(nextStep.size());
      derivative.x = nextStep.get(randomPick).x;
      derivative.y = nextStep.get(randomPick).y;
    } 
    // if there is only one element take it
    else {
      derivative.x = nextStep.get(0).x;
      derivative.y = nextStep.get(0).y;
    }
    // compute the derivative vector from origine
    derivative.sub(origine);
    return derivative;
  }

  // display the vectorial field in grey scale
  void display() {
    loadPixels();
    for (int i = 1; i < width-1; i++) {
      for (int j = 1; j < height-1; j++) {
        float colorPixel = map(gridValues[i][j], 0, 1, 0, 100);
        pixels[i+j*width] = color(colorPixel);
        strokeWeight(1);
        strokeCap(SQUARE);
        stroke(255, 0, 0);
      }
    }
    updatePixels();
  }

  // GETTERS
  PVector getVector(float x, float y) {
    PVector vector = new PVector();
    vector.x = gridVectors[(int) x][(int) y].x;
    vector.y = gridVectors[(int) x][(int) y].y;

    return vector;
  }
}