color[] colours = {
  color(0, 0, 0), // black
  color(255, 255, 255), // white
  color(255, 0, 0), // red
  color(0, 0, 255) // blue
};
int coloursCount = colours.length;

void setup() {
  size(400, 400);
  
  println(coloursCount);
  
  background(220);
  
  for( int i=0; i<10; i++ ) {
    color fillColour = colours[i % coloursCount];
    fill(fillColour);
    
     circle(20 + (i*30), 100, 30);
  }
}
