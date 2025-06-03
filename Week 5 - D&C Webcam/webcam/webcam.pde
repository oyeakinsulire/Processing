import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("No cameras available.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    cam = new Capture(this, 640, 480, cameras[1], 30);
    cam.start();
  }
}

void draw() {
  if (cam.available()) {
    cam.read();
  }

  cam.loadPixels();
  loadPixels();

  // Create a temporary array to store manipulated pixels
  color[] tempPixels = new color[cam.pixels.length];

  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {
      int index = x + y * cam.width;
      color c = cam.pixels[index];

      // Convert to grayscale
      float avg = (red(c) + green(c) + blue(c)) / 4;

      // Apply dithering (threshold effect)
      if (avg > 128) {
        avg = 255;
      } else {
        avg = 0;
      }

      // Rotate image 180° (flip both horizontally & vertically)
      int rotatedIndex = (cam.width - x - 1) + (cam.height - y - 1) * cam.width;
      tempPixels[rotatedIndex] = color(avg);
    }
  }

  // Copy processed pixels back to the canvas
  arrayCopy(tempPixels, pixels);
  updatePixels();
}

void keyPressed() {
  println("Key pressed! Key is: " + key); // Add this line
  if (key == 's' || key == 'S') {
    saveFrame("frame-######.jpg");
    println("Saving frame!"); // Add this line
  }
}
