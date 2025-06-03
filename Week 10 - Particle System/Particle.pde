class Particle {
  PVector loc, vel, acc; // Location, velocity, acceleration
  float lifespan;        // Fades out over time
  float rad;             // Size
  color c;               // Color

  Particle(PVector startLoc) {
    loc = startLoc.copy();
    vel = PVector.random2D().mult(random(0.5, 3)); // Random burst speed
    acc = new PVector(0, 0);
    lifespan = 255.0;
    rad = random(2, 8);
    c = color(random(100, 255), random(100, 255), random(100, 255), lifespan);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0); // Reset acceleration
    lifespan -= 2;
    c = color(red(c), green(c), blue(c), lifespan); // Fade color
  }

  void display() {
    fill(c);
    noStroke();
    ellipse(loc.x, loc.y, rad * 2, rad * 2);
  }

  boolean isDead() {
    return lifespan < 0.0;
  }
}
