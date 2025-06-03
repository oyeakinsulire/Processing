void setup() {
  size(640, 360);
}

void draw() {
  background(0);

  fill(255, 96, 96);
  rect(width/2, height/2, 100, 100);

  fill(96, 255, 96);
  circle(width/2, height/2, 100);

  fill(96, 96, 255);
  triangle(width/2, height/2, 
    width/2-100, height/2, 
    width/2-50, height/2-100);
}
