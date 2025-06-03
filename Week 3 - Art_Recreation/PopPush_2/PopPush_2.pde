float[] angles = {0, 0, 0, 0, 0};
float[] speeds = {2, 8, 16, 8, 2};

float xpos = 80;
float xstep = 60;

void setup() {
  size(400, 400);
  rectMode(CENTER);
}

void draw() {
  background(0);
  
  for (int i = 0; i < angles.length; i++) {
    pushMatrix();
    
     switch (i) {
      case 0:
        fill(300, 0, 0);  // Red
        break;
      case 1:
        fill(0, 100, 0);  // Green
        break;
      case 2:
        fill(0, 0, 255);  // Blue
        break;
      case 3:
        fill(255, 255, 0);  // Yellow
        break;
      case 4:
        fill(255, 165, 0);  // Orange
        break;
      default:
        fill(255);  // White (Fallback)
        
     }

      translate(xpos + (xstep * i), height / 2);
      rotate(radians(angles[i]));
      rect(0, 0, 50, 50);
      angles[i] = angles[i] + speeds[i];
    popMatrix();
  }
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
