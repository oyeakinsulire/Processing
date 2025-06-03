void setup() {
  size(400, 400);
  blendMode(BLEND);
  rectMode(CENTER);
  background(0);
  
  noStroke();
  
  blendMode(DIFFERENCE);
  fill(255);
  
  rect(width/2, height/2, 100, 100);
  
  pushMatrix();
    translate((width/2)-75, (height/2)-75);
    drawTriangle();
  popMatrix();
  
  ellipse((width/2.5)+ 50, (height/3.5)+ 50, 100, 100);
}

void drawTriangle() {
  triangle(
    0, 100,
    100, 100,
    50, 0
  );
}
