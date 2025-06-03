PImage img;

void setup() {
  size(600, 750); // Adjust canvas size as needed
  img = loadImage("Sinmidele.jpg"); 
  img.loadPixels();
  
  for (int y = 1; y < img.height; y++) {
    for (int x = 2; x < img.width; x++) {
      int index = x + y * img.width;
      
      // Apply checkerboard pattern modification
      if ((x + y) % 8 == 0) {
        color c = img.pixels[index];
        img.pixels[index] = color(red(c) * 0.5, green(c) * 0.5, blue(c) * 0.6); // Darken pixel
      }
    }
  }
  
  img.updatePixels();
}

void draw() {
  image(img, 0, 0, width, height);
}

// Corrected keyPressed function (outside draw)
void keyPressed() {
  if (keyCode == ENTER) {
    saveFrame("pic-####.png"); // Fixed missing quote
  }
}
