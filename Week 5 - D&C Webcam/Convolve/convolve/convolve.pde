PImage input;
PImage output;

float[][] identity = {
  { 0, 0, 0 }, 
  { 0, 1, 0 }, 
  { 0, 0, 0 }
};

float[][] smooth = {
  { 1/9.0, 1/9.0, 1/9.0}, 
  { 1/9.0, 1/9.0, 1/9.0}, 
  { 1/9.0, 1/9.0, 1/9.0}
};

float[][] blur = {
  { 0.0625, 0.125, 0.0625 }, 
  { 0.125, 0.25, 0.125 }, 
  { 0.0625, 0.125, 0.0625 }
};

float[][] sharpen = {
  {  0, -1, 0 }, 
  { -1,  5, -1 }, 
  {  0, -1, 0 }
};

float[][] edge = {
  { -1, -1, -1 }, 
  { -1,  8, -1 }, 
  { -1, -1, -1 }
};

void setup() {
  size(517, 606);
  input = loadImage("Sinmidele.jpg");
}

void draw() {
  image(convolve(input, smooth), 0, 0);
}

PImage convolve(PImage input, float[][] kernel) {
  output = createImage(input.width, input.height, RGB);

  input.loadPixels();
  output.loadPixels();

  // start one pixel in from the edge, stop one pixel from the edge
  // on both width and height - so we don't try to grab non-existant
  // pixels
  for (int y = 1; y < input.height-1; y++) {
    for (int x = 1; x < input.width-1; x++) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;

      // iterate over the 3x3 square around (x,y)
      // we'll do this by calculating the offset in pixels
      // for each item in the square from x,y, then working out
      // which index in the pixels array we should get
      for (int offsetY = -1; offsetY <= 1; offsetY++) {
        for (int offsetX= -1; offsetX <= 1; offsetX++) {
          int neighbourIndex = (y+offsetY)*input.width + (x + offsetX);

          float r = red(input.pixels[neighbourIndex]);
          float g = green(input.pixels[neighbourIndex]);
          float b = blue(input.pixels[neighbourIndex]);

          // now apply the kernel: multiply each channel by the
          // appropriate amount for this square in the kernel, and
          // add to our running total
          sumR += r * kernel[offsetY+1][offsetX+1];
          sumG += g * kernel[offsetY+1][offsetX+1];
          sumB += b * kernel[offsetY+1][offsetX+1];
        }
      }

      // we've now got our new RGB values. let's clamp them to
      // 0-255 to ensure there's no funkiness.
      sumR = constrain(sumR, 0, 255);
      sumG = constrain(sumG, 0, 255);
      sumB = constrain(sumB, 0, 255);

      // finally, update the output pixel
      int index = y*input.width + x;
      output.pixels[index] = color(sumR, sumG, sumB);
    }
  }

  return output;
}
