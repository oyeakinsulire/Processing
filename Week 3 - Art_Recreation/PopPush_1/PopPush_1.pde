float angleOne = 0;
float angleTwo = 0;
float angleThree = 0;
float angleFour = 0;
float angleFive = 0;

float xpos = 80;
float xstep = 60;  // space between the squares

void setup() {
  size(400, 400);
  rectMode(CENTER);
}

void draw() {
  
  background(0);
  
  pushMatrix();
  fill(30, 150, 200);
  translate(xpos + (xstep*0), height / 2);
  rotate(radians(angleOne));
  rect(0, 0, 50, 50);
  angleOne = angleOne + 2;
  popMatrix();
 
  pushMatrix();
  fill(30, 150, 200);
  translate(xpos + (xstep*1), height / 2);  // Changed xstep*0 to xstep*1
  rotate(radians(angleTwo));
  rect(0, 0, 50, 50);
  angleTwo = angleTwo + 4;
  popMatrix();
 
  pushMatrix();
  fill(30, 150, 200);
  translate(xpos + (xstep*2), height / 2);  // Changed xstep*0 to xstep*2
  rotate(radians(angleThree));
  rect(0, 0, 50, 50);
  angleThree = angleThree + 6;
  popMatrix();
 
  pushMatrix();
  fill(30, 150, 200);
  translate(xpos + (xstep*3), height / 2);  // Changed xstep*0 to xstep*3
  rotate(radians(angleFour));
  rect(0, 0, 50, 50);
  angleFour = angleFour + 8;
  popMatrix();
 
  pushMatrix();
  fill(30, 150, 200);
  translate(xpos + (xstep*4), height / 2);  // Changed xstep*0 to xstep*4
  rotate(radians(angleFive));
  rect(0, 0, 50, 50);
  angleFive = angleFive + 10;
  popMatrix();
}


void keyPressed() {
  // Check if the 's' or 'S' key was pressed
  if (key == 's' || key == 'S') {
    // Save a screenshot of the current display window
    // "video_frame_####.png" creates sequential filenames (e.g., video_frame_0000.png, video_frame_0001.png)
    saveFrame("video_frame_####.png");
    println("Frame saved!"); // Print a message to the console
  }
}
