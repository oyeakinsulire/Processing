PImage sample;

void setup() {
  size(517, 606);
  sample = loadImage("Sinmidele.jpg");
}

void draw() {
  image(sample, 0, 0);

  loadPixels();

  for (int i = 0; i < pixels.length; i++) {
    // convert pixel to greyscale
    float greyValue = red(pixels[i]);

    // threshold pixel to either black or white.
    float newPixelValue = 0;

    if (greyValue > 127) {
      newPixelValue = 255;
    }

    float error = greyValue - newPixelValue;

    pixels[i] = color(newPixelValue);

    // diffuse error onwards
    //diffuseError(i,error);
    //atkinsonDither(i,error);
    fsDither(i, error);

  }

  updatePixels();
}

void diffuseError(int i, float error) {
  if (i < pixels.length-1) {
    float nextGreyValue = red(pixels[i+1]);
    pixels[i+1] = color(nextGreyValue + error);
  }
}

void fsDither(int i, float error) {
  // Floyd-Steinberg Dithering
  //
  // x is the current pixel:
  //
  //  .  x  7
  //  3  5  1
  //  (all /16)

  int[] offsets = {
    1, width-1, width, width+1
  };

  float[] ditherRatios = {
    7/16.0, 3/16.0, 5/16.0, 1/16.0
  };

  for (int j = 0; j < offsets.length; j++) {
    int neighbourIndex = i + offsets[j];
    if (neighbourIndex < pixels.length) {
      float neighbourGrey = red(pixels[neighbourIndex]);
      pixels[neighbourIndex] = color(neighbourGrey + (error*ditherRatios[j]));
    }
  }
}

void atkinsonDither(int i, float error) {
  // Atkinson Dithering
  //
  // x is the current pixel:
  //
  //  .  x  1  1
  //  1  1  1  .
  //  .  1  .  .
  //  (all / 8)


  int[] offsets = {
    1, 2, width-1, width, width+1, width*2
  };

  for (int j = 0; j < offsets.length; j++) {
    int neighbourIndex = i + offsets[j];
    if (neighbourIndex < pixels.length) {
      float neighbourGrey = red(pixels[neighbourIndex]);
      pixels[neighbourIndex] = color(neighbourGrey + (error/8.0));
    }
  }
}
