void setup() {
  size(400, 400); // Set the size of the display window to 400x400 pixels
  // background(255, 0, 0); // This line is commented out, so it won't run

  loadPixels(); // Load the current pixel data into the pixels array
  // Loop through every pixel in the window
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = color(0, 255, 0); // Set each pixel to green (RGB: 0, 255, 0)
  }

  // Set a specific pixel at (200, 200) to red (RGB: 255, 0, 0)
  set(200, 200, color(255, 0, 0));

  // Get the color of the pixel at (0, 0) and store it in variable 'c'
  // (Note: 'c' isn't used after this, but the operation is valid)
  color c = get(0, 0);

  updatePixels(); 
}

void draw() {
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("simple_screenshot_####.png");
    println("Screenshot saved!");
  }
}
