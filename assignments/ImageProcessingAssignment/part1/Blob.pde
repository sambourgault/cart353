class Blob {
  // Center position
  float cx;
  float cy;
  // List of float containing pixels of the blob
  FloatList xs; 
  FloatList ys;

  // Constructor
  Blob(float newX, float newY) {
    cx = newX;
    cy = newY;

    // Create the floatlists
    xs = new FloatList();
    xs.append(newX);

    ys = new FloatList();
    ys.append(newY);
  }

  // Add a new pixel to the blob
  void add(float newX, float newY) {
    xs.append(newX);
    ys.append(newY);

    // Recompute center as the average between all the pixels
    cx = 0;
    cy = 0;
    for (int i = 0; i < xs.size(); i++) {
      cx += xs.get(i);
      cy += ys.get(i);
    }
    cx /= xs.size();
    cy /= ys.size();
  }

  // Get the x coordinate of the center of the blob
  float getCx() {
    return cx;
  }

  // Get the y coordinate of the center of the blob
  float getCy() {
    return cy;
  }
}