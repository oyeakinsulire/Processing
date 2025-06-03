// load movie library
import processing.video.*;

String conversionMethod = "red";
float brightnessScale;
Movie colourMovie;

void setup() {
  size(880, 720);
  
  // create movie object
  colourMovie = new Movie(this, "WG- The Stillness Within.mov");
  colourMovie.play();
  colourMovie.volume(0);
}

void draw() {
  // update movie frame
  if(colourMovie.available()) {
    colourMovie.read();
  }

  image(colourMovie,0,0);

  int[] histogram = new int[256]; // Create histogram data structure

  loadPixels();

  if (mousePressed) {
    brightnessScale = map(mouseX- width/2, 0, width/2, 0, 0.5);
  } else {
    brightnessScale = 0;
  }


  for (int i = 0; i < pixels.length; i++) {
    
    float newRed = red(pixels[i]) * brightnessScale;
    float newBlue = blue(pixels[i]) * brightnessScale;
    float newGreen = green(pixels[i]) * brightnessScale;

    color newColor = color(newRed, newBlue, newGreen);
    pixels[i] = newColor;

    int index = int(red(newColor));
    histogram[index]++;
  }  

  updatePixels();

  for (int i = 0; i < histogram.length; i++) {
    stroke(255, 0, 0);

    // scale all the histogram results to go from 0 to height/2

    float scaledHeight = map(histogram[i], 0, max(histogram), 0, height/2);

    int startHeight = height - round(scaledHeight);

    line(i, startHeight, i, height);
  }

}
