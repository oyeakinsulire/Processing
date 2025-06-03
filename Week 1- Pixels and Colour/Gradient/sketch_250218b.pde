void setup() {
  size(400, 400); // Set the size of the display window
}

void draw() {
  loadPixels(); // Load the current pixel data into the pixels array

  // Loop through every pixel in the window
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      // Normalize the X coordinate to a value between 0 and 1
      float normalizedX = map(x, 0, width, 0, 1);

      // Calculate the red component: increases from left (0) to right (255)
      int red = int(255 * normalizedX);
      // Green component is always 0
      int green = 0;
      // Blue component: decreases from left (255) to right (0)
      int blue = int(255 * (1 - normalizedX));

      // Create a color using the calculated RGB values
      color c = color(red, green, blue);

      // Assign the color to the correct pixel in the pixels array
      pixels[x + y * width] = c;
    }
  }
  updatePixels(); // 


void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("simple_screenshot_####.png");
    println("Screenshot saved!");
  }
}
