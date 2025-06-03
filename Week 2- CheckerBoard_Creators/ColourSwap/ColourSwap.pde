PImage img;

void setup() {
  size(600, 900);
  img = loadImage("Euphorium.JPG");
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    //Colour Channels Swap (RGB > BGR)
    img.pixels[i] = color(r, g, b);
  }
  img.updatePixels();
  
  img.resize(600, 900);

  image(img, 0, 0);
  
}
