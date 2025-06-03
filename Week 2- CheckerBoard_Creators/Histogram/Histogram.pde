PImage euphorium;

void setup() {
  size(600, 900);
  euphorium = loadImage("Euphorium.JPG");
  euphorium.loadPixels();
}

void draw() {
  loadPixels();
  
  int[] histogram = new int[256];
  
  
  for (int i = 0; i < euphorium.pixels.length; i++) {
  
    int pixelShade = int(red(euphorium.pixels[i]));
    euphorium.pixels[i] = color(pixelShade);
    
    histogram[pixelShade]++;
  }
  image(euphorium, 0, 0);
  updatePixels();
  
  for (int i = 0; i < histogram.length; i++) {
    stroke(255, 0, 0);
    float startHeight = map(histogram[i], 0, max(histogram), height, height-(height/3));
    line(i, startHeight, i, height);
}
}
