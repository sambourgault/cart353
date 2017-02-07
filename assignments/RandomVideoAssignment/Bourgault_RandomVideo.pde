/* 
 / Name: A2 - RandomVideo
 / Author: Samuelle Bourgault
 / Date: February 7th, 2017
 / Description: Display a live video on a terrain evolving with perlin noise. 
 / The average color of 40 x 40 pixels is rendered on a QUAD of the same size.
 / To keep the color closer to medium grey, the color is multiply by a Gaussian coefficient.
 */

import processing.video.*;

Capture video;
// Starting position for the 2D noise
float xoff;
float yoff;
// Offset for 2D noise
float offset;
// Size of the grid unit
int squareSize;
// Matrix of heights for the terrain
float heights[][];

// Create a matrix containing the average color of the grid unit
float [][] averageColorValue;
// Temporary value for the average color
color averageTempColor;
// Temporary value for the average grey
float averageTempGrey;



void setup() {
  size(640, 640, P3D);
  // Starting position for the 2D noise
  xoff = 0.0;
  yoff = 10.0;
  // Offset for 2D noise
  offset = 0.01;
  // Size of the grid unit
  squareSize = 40;
  // Matrix of heights for the terrain
  heights = new float[width/squareSize + 1][height/squareSize + 1];

  // Create a matrix containing the average color of the grid unit
  averageColorValue = new float[width/squareSize][height/squareSize];
  // Temporary value for the average grey
  averageTempGrey = 0;

  // Create a new instance of Capture
  video = new Capture(this, 640, 640);
  // Start the capture
  video.start();
}

// An event for when a new frame is available
void captureEvent(Capture video) {
  // Read the image from the camera.
  video.read();
}

// Function that computes new heights for the terrain
void calculateHeights() {
  for (int i = 0; i < width/squareSize + 1; i++) {
    for (int j = 0; j < height/squareSize + 1; j++) {
      float z = noise(xoff, yoff);
      heights[i][j] = map(z, 0, 1, -50, 50);
      // Add an offset to the xoff and the yoff
      xoff += offset;
      yoff += offset;
    }
  }
}

void draw() {
  background(255);
  // Recompute the heights only when the modulo of frameCount by 10 is 0
  if (frameCount % 10 == 0 || frameCount == 0) {    
    calculateHeights();
  }
  
  // Load the video pixels
  video.loadPixels();

// Loop through the grid unit
  for (int l = 0; l < width/squareSize; l ++) {
    for (int m = 0; m < height/squareSize; m ++) { 
      averageTempGrey = 0;
      // Loop through the 40 x 40 pixels in each grid unit
      for (int i = 0; i < squareSize; i++) {
        for (int j = 0; j < squareSize; j++) {
          // Get the color
          averageTempColor =  video.pixels[((l*squareSize)+i) + (j+(m*squareSize)) * video.width];
          // Add the grey scale value to a temporary variable
          averageTempGrey += (red(averageTempColor) + blue(averageTempColor) + green(averageTempColor))/3;
        }
      }
      
      // Set a gauss coefficient to get a color closer to the middle grey than the white or the black
      float gaussCoeff = randomGaussian();
      float coeff = map(gaussCoeff, -1000, 1000, 0, 1);
      // Add the average value to the matrix averageColorValue
      averageColorValue[l][m] = constrain(coeff*averageTempGrey/(squareSize*squareSize), 0, 255);

      // Draw the quad as a terrain with various heights
      fill(averageColorValue[l][m]);
      noStroke();
      pushMatrix();
      // Set the right position to the right grid unit
      translate(l*squareSize, m*squareSize, 0);
      beginShape(QUADS);
      vertex(0, 0, heights[l][m]);
      vertex(squareSize, 0, heights[l+1][m]);
      vertex(squareSize, squareSize, heights[l+1][m+1]);
      vertex(0, squareSize, heights[l][m+1]);
      endShape();
      popMatrix();
    }
  }
}