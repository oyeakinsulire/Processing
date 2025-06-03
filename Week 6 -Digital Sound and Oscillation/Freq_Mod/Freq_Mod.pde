import processing.sound.*;

SinOsc drone;
TriOsc shimmer;
SqrOsc heartbeat;

void setup() {
  size(600, 400);
  background(0);

  // Create and play sounds
  drone = new SinOsc(this);
  shimmer = new TriOsc(this);
  heartbeat = new SqrOsc(this);

  drone.play(); drone.freq(50); drone.amp(0.4);         // Low ambient hum
  shimmer.play(); shimmer.freq(2000); shimmer.amp(0.2); // Bright shimmer
  heartbeat.play(); heartbeat.freq(250); heartbeat.amp(0.1); // Soft pulse
}

void draw() {
  background(0);

  // Simulate heartbeat with sine wave and mouseX
  float speed = map(mouseX, 0, width, 1, 10);
  float pulse = sin(radians(frameCount * speed));
  float volume = map(pulse, -1, 1, 0.05, 0.2);
  heartbeat.amp(volume);

  // Shimmer slowly shifts pitch for reverb-like effect
  shimmer.freq(2000 + sin(frameCount * 0.01) * 100);

  // Stars
  stroke(255, 50);
  for (int i = 0; i < 100; i++) {
    point(random(width), random(height));
  }

  // Glowing center pulse
  noStroke();
  fill(255, 100, 0, volume * 1000);
  ellipse(width/2, height/2, 100 + volume * 100, 100 + volume * 100);

  // Orbiting rings
  stroke(255, 100);
  noFill();
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(frameCount * 0.5));
  ellipse(0, 0, 150, 150);
  rotate(radians(frameCount));
  ellipse(0, 0, 200, 200);
  popMatrix();
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("sci_fi_arrival_####.png");
    println("Screenshot saved.");
  }
}
