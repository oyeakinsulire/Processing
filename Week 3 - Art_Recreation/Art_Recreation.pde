void setup() {
  size(600, 600); // Set the size of the display window
  background(220); // Set a light grey background
  noStroke();      // Disable drawing outlines for shapes
}

void draw() {
  background(220); // Clear the background with light grey each frame

  // Set the blending mode to MULTIPLY for overlapping transparent shapes
  // This mode darkens overlapping areas, simulating ink or film.
  blendMode(MULTIPLY);

  // --- Red Bands ---
  // Draw diagonal bands with red color and some transparency (alpha 200)
  // The coordinates define the top-left and bottom-right corners of the initial band.
  // The last two vertices extend the shape into a parallelogram.
  drawBand(color(255, 0, 0), -100, -10, 600, 460); // First red band
  drawBand(color(255, 0, 0), 600, -10, 130, 450);  // Second red band (note coordinates might make it overlap/extend strangely, depending on intent)

  // --- Black Bands ---
  // Draw diagonal bands with black color and some transparency
  drawBand(color(10, 10, 10), -100, 50, 800, 500);  // First black band
  drawBand(color(20, 20, 20), 400, -200, 200, 500); // Second black band

  // Restore the default blending mode
  blendMode(NORMAL);

  // --- Optional Large Circle (uncomment to include) ---
  //fill(240, 230, 210, 200); // Light beige with transparency
  //ellipse(300, 250, 250, 250); // Draw a large ellipse

  // If you were manipulating the pixels array directly, you would call updatePixels() here.
  // For vector drawing (like beginShape/vertex/endShape), updatePixels() isn't needed.
  // It won't hurt, but it's redundant.
  // updatePixels();
}

// Function to draw diagonal bands
// c: the color of the band
// x1, y1, x2, y2: coordinates defining the initial points of the band
void drawBand(color c, float x1, float y1, float x2, float y2) {
  fill(c, 200); // Set fill color with 200 alpha (transparency)
  beginShape(); // Start defining a custom shape
  vertex(x1, y1);             // Top-left vertex
  vertex(x2, y2);             // Top-right vertex
  vertex(x2 + 100, y2 + 200); // Bottom-right vertex (offset from x2, y2)
  vertex(x1 + 100, y1 + 200); // Bottom-left vertex (offset from x1, y1)
  endShape(CLOSE);            // Close the shape, creating a filled parallelogram
}

void keyPressed() {
  // Check if the pressed key is 's' or 'S'
  if (key == 's' || key == 'S') {
    saveFrame("simple_screenshot_####.png");
    println("Screenshot saved!");
  }
}
