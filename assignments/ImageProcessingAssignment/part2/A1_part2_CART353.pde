//**** 
// Title: A1 part2 - CART353
// Name: Samuelle Bourgault
// Date: January 24, 2017
// Description: Press space bar to change the state of the image and press "s" to save the image.
//****

PImage img;
//Gaussian blur
// source: https://en.wikipedia.org/wiki/Kernel_(image_processing)
float[][]  matrix = {{-1, -1, -1}, 
  {-1, 8, -1}, 
  {-1, -1, -1}};

// Sharp edge matrix
// source: https://en.wikipedia.org/wiki/Kernel_(image_processing)
float[][] matrix2 = {{1, 4, 6, 4, 1}, 
  {4, 16, 24, 16, 4}, 
  {6, 24, 36, 24, 6}, 
  {4, 16, 24, 16, 4}, 
  {1, 4, 6, 4, 1}};

// Create the coefficient variables
float coef;
float coef2;
// Create the number of time one hits space bar
int numberOfKeyPressed;

void setup() {

  size(678, 524);
  img = loadImage("becket.png");
  // Define the coefficients for the matrices
  coef = 1.0;
  coef2 = 1.0/256.0;
  // Begin with the original image corresponding to case 3
  numberOfKeyPressed = 3;
}

void draw() {
  image(img, 0, 0);

  // Count the number of time one hits the space bar
  if (keyPressed) {
    keyPressed = !keyPressed;
    if (key == ' ') {
      numberOfKeyPressed++;
      // Set the numberOfKeyPressed back to zero after a whole cycle
      if (numberOfKeyPressed > 3) {
        numberOfKeyPressed = 0;
      }
    }
  }

  loadPixels();
  img.loadPixels();
  // Change the image between four possible choices.
  switch(numberOfKeyPressed) {
  case 0:
    // Edge detection
    edgyImage();    
    break;
  case 1: 
    // Blur the image
    bluryImage();
    break;
  case 2:
    // Set to greyscale
    greyImage();
    break;
  case 3:
    // Go to normal (RGB image)
    break;
  }
  updatePixels();
}

// Save the image when 's' is released
void keyReleased() {
  if (key == 's') {
    save("newSamuelBeckett.png");
  }
}

// Convolution function
// source: Chap. 15: Images (p.323) in ** from Daniel Shifman
color convolution(int x, int y, float[][] matrix, float coef, int matrixsize, PImage img) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  // Loop through convolution matrix
  for (int i = 0; i < matrixsize; i++) {
    for (int j = 0; j < matrixsize; j++) {
      // What pixel is being examined
      int xloc = x + i - offset;
      int yloc = y + j - offset;
      int loc = xloc + img.width * yloc;

      loc = constrain(loc, 0, img.pixels.length-1);

      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * coef * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * coef *matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * coef * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}

// Modify one RGB pixel to greyscale
color toGreyscale(color pixel) {
  float r = red(pixel);
  float g = green(pixel);
  float b = blue(pixel);
  // Take the average of each color and turn it in grey
  color grey = color(r*1.0/3.0 + g*1.0/3.0 + b*1.0/3.0);
  return grey;
}

// Bring RGB image to greyscale
void greyImage() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++ ) {
      int loc = x + y * img.width;
      color c;
      c = img.pixels[loc];
      color cGrey = toGreyscale(c);
      pixels[loc] = cGrey;
    }
  }
}

// Blur the image
void bluryImage() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++ ) {
      // Convoluate the image with a blur matrix
      color c = convolution(x, y, matrix2, coef2, 5, img);
      int loc = x + y * img.width;
      pixels[loc] = c;
    }
  }
}

// Reveal the edge of the image
void edgyImage() {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++ ) {
      // Convoluate the image with a edge detection matrix
      color c = convolution(x, y, matrix, coef, 3, img);
      int loc = x + y * img.width;
      pixels[loc] = c;
    }
  }
}