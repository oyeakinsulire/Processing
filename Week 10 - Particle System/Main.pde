import java.util.ArrayList; // Needed for ArrayList

ArrayList<Particle> particles;
float windStr = 0.05; // Wind strength
float windFreq = 0.05; // Wind change speed

void setup() {
  size(800, 600);
  background(0);
  particles = new ArrayList<Particle>();
  frameRate(60); // Smoother animation
}

void draw() {
  fill(0, 50); // Fading background
  rect(0, 0, width, height);

  // Apply random "cosmic wind"
  applyCosmicWind();

  // Update and display particles, remove dead ones
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();

    if (p.isDead()) {
      particles.remove(i);
    }
  }

  fill(255);
  textSize(16);
  text("Particles: " + particles.size(), 10, 20);
}

// Mouse click creates a burst of particles
void mousePressed() {
  int numParticles = (int)random(10, 30);
  for (int i = 0; i < numParticles; i++) {
    particles.add(new Particle(new PVector(mouseX, mouseY)));
  }
}

// Generates and applies a random wind force
void applyCosmicWind() {
  float windX = map(noise(frameCount * windFreq), 0, 1, -windStr, windStr);
  float windY = map(noise(frameCount * windFreq + 1000), 0, 1, -windStr, windStr);
  PVector wind = new PVector(windX, windY);

  for (Particle p : particles) {
    p.applyForce(wind);
  }
}
