void setup() {
  size(1600, 1000);  // Huge canvas for clarity
  noSmooth();
  noLoop();
}

void draw() {
  background(255);
  textSize(64);  // Extra large text for readability
  
  // Without anti-aliasing
  //
  fill(0);
  ellipse(500, 600, 500, 500);  // Super large circle
  
  // With anti-aliasing
  ellipse(1200, 600, 500, 500);  // Super large circle
}
