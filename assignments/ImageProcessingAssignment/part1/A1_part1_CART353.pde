//**** 
// Title: A1 part1 - CART353
// Name: Samuelle Bourgault
// Date: January 24, 2017
// Description: Click on the mouse and detect the red spots and press "s" to save the image
//****

// Instantiate the image
PImage img;
// Instantiate the array of blobs
Blob blobs[];
int blobsLength;

// Instantiate the tracked color and the thresholds for position 
// (when to create a new blob) and color (what colors can be detected)
color trackcolor;
float thresholdPosition;
float thresholdColor;

int numberOfMousePressed;

void setup() {
  size(632, 632);

  // Create the array of blobs
  blobsLength = 0;
  blobs = new Blob[1000];

  // Set the tracked color to a certain red and the thresholds for position and color
  //trackcolor = color(175, 75, 75);
  trackcolor = color(199, 67, 65);
  thresholdPosition = 25;
  thresholdColor = 15;

  // Set the number of mouse pressed to 0
  numberOfMousePressed = 0;

  // Load image and pixels
  img = loadImage("sam.png");

  img.resize(632, 632);
  println(img.width);
  println(img.height);
  loadPixels();
  img.loadPixels();

  // Go through the pixel
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y * width;
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);

      float distColor = dist3(red(trackcolor), green(trackcolor), blue(trackcolor), r, g, b);
      if (distColor < thresholdColor) {
        //println(distColor);
        if (blobsLength != 0) {
          float nearestDist = width;
          int closestBlob = -1;

          // Detect closest blob
          for (int j = 0; j < blobsLength; j++) {
            float distPosition = dist2(blobs[j].getCx(), blobs[j].getCy(), x, y);
            float minDist = min(nearestDist, distPosition);
            if (minDist < nearestDist) {
              nearestDist = minDist;
              closestBlob = j;
            }
          }

          // Check if the detected pixel can merge to a existing blob or create a new one
          if (nearestDist < thresholdPosition) {
            // Add the pixel to a closest blob
            blobs[closestBlob].add(x, y);
          } else {
            // Create a new blob
            blobs[blobsLength] = new Blob(x, y);
            blobsLength++;
          }
        } else {
          // Create a new blob the first time a red pixel is detected
          blobs[blobsLength] = new Blob(x, y);
          blobsLength++;
        }
      }
    }
  }
}

void draw() {

  image(img, 0, 0);

  // Count the number of mousePressed, if over 2, restart to 0
  if (mousePressed) {
    mousePressed = !mousePressed;
    numberOfMousePressed++;
    if (numberOfMousePressed > 2) {
      numberOfMousePressed = 0;
    }
  }

  // According to the number of time the mouse has been pressed, change the state of the image
  switch(numberOfMousePressed) {
    // Set to the original image
  case 0:
    break;
    // Draw a white ellipse on blobs
  case 1:
    for (int i = 0; i < blobsLength; i++) {
      fill(255);
      noStroke();
      ellipse(blobs[i].getCx(), blobs[i].getCy(), thresholdPosition, thresholdPosition);
    }
    break;
    // Draw lines in random directions each frame
  case 2:
    for (int i = 0; i < blobsLength; i++) {
      fill(255);
      noStroke();
      ellipse(blobs[i].getCx(), blobs[i].getCy(), thresholdPosition, thresholdPosition);
      strokeWeight(3);
      stroke(255);
      line(blobs[i].getCx(), blobs[i].getCy(), random(width), random(height));
    }
  }

  // Save the image when press 's'
  if (keyPressed) {
    keyPressed = !keyPressed;
    if (key == 's') {
      save("newSamsArm.png");
    }
  }
}

// Compute 2D distance
float dist2(float x, float y, float newX, float newY) {
  float d = sqrt(sq(newX-x)+sq(newY-y));
  return d;
}

// Compute 3D distance
float dist3(float x, float y, float z, float newX, float newY, float newZ) {
  float d = sqrt(sq(newX-x)+sq(newY-y)+sq(newZ-z));
  return d;
}