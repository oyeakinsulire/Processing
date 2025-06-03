PImage picture;

void setup() {
  size(500, 760);
  background(0);
  picture = loadImage("Euphorium.JPG");
  picture.resize(width, height); // Ensure it fits the canvas
  noLoop();
}

void draw() {
  ditherImage();
}

void ditherImage() {
  picture.loadPixels();
  
  for (int i = 0; i < picture.pixels.length; i++) {
    float greyValue = red(picture.pixels[i]); // Convert to grayscale (using red channel)
    
    float newPixelValue = 0;
    if (greyValue > 128) {  // Threshold for dithering
      newPixelValue = 255;
    }
    
    float error = greyValue - newPixelValue;
    picture.pixels[i] = color(newPixelValue); // Set the new pixel value
    
    // Apply Floyd-Steinberg dithering
    applyDithering(i, error);
  }
  
  picture.updatePixels();
  image(picture, 0, 0);
}

void applyDithering(int i, float error) {
  // Floyd-Steinberg dithering matrix:
  // 
  //       X    7/16
  //  3/16  5/16  1/16
  // 
  int[] offsets = { 1, width - 1, width, width + 1 };
  float[] ditherRatios = { 7 / 16.0, 3 / 16.0, 5 / 16.0, 1 / 16.0 };
  
  for (int j = 0; j < offsets.length; j++) {
    int neighborIndex = i + offsets[j];
    if (neighborIndex < picture.pixels.length && neighborIndex >= 0) { // Ensure it's within bounds
      float neighborGrey = red(picture.pixels[neighborIndex]);
      picture.pixels[neighborIndex] = color(neighborGrey + (error * ditherRatios[j]));
    }
  }
}

void atkinsonDiher(int i, float error) {
  // Atkinspn Diherering
  //
  // .  x  1  1
  // 1  1  1  .
  // .  1  .  .
  // 
  // (all / 8)
  
  int[] offsets = {1, 2, width - 1, width, width + 1, 2 * width};
  
  for (int j = 0; j < offsets.length; j++) {
    int neighborIndex = i + offsets[j];
    if (neighborIndex < picture.pixels.length && neighborIndex >= 0) {
      float neighborGrey = red(picture.pixels[neighborIndex]);
      picture.pixels[neighborIndex] = color(neighborGrey + error/8.0);
      
    }
  }
}
