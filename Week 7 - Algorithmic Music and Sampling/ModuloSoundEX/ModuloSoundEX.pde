import processing.sound.*;

SoundFile[] samples = new SoundFile[4]; // kick, snare, hihat, clap
String[] names = { "kick.wav", "snare.wav", "hihat.wav", "clap.wav" };

SinOsc drone;

int[][] pattern = {
  {1, 0, 0, 0, 1, 0, 0, 0}, // Kick
  {0, 0, 1, 0, 0, 0, 1, 0}, // Snare
  {1, 1, 1, 1, 1, 1, 1, 1}, // Hihat
  {0, 0, 0, 0, 1, 0, 0, 0}  // Clap
};

int step = 0;
int bpm = 110;
int framesPerStep = int(60.0 / bpm * 60);
color[] colors = {#FF5522, #00AAFF, #FFFF00, #FF66CC};

boolean[] playingNow = new boolean[4]; // track which samples play at current step

void setup() {
  size(800, 400);
  frameRate(60);

  // Load samples from data folder (make sure these exist!)
  for (int i = 0; i < 4; i++) {
    samples[i] = new SoundFile(this, names[i]);
  }

  // Synth drone for sci-fi atmosphere
  drone = new SinOsc(this);
  drone.freq(45);
  drone.amp(0.2);
  drone.play();

  println("▶ Drum machine ready! Watch the beat change every 8 steps.");
}

void draw() {
  background(0);

  if (frameCount % framesPerStep == 0) {
    playStep(step);
    step = (step + 1) % 8;

    // Randomly vary the hihat and clap every loop
    if (step == 0) {
      for (int i = 0; i < 8; i++) {
        pattern[2][i] = (random(1) > 0.2) ? 1 : 0; // Hihat: mostly on
        pattern[3][i] = (millis() / 8000) % 2 == 1 && i == 4 ? 1 : 0; // Clap on 5th step in 2nd half
      }
    }
  }

  drawVisualizer();
}

void playStep(int s) {
  for (int i = 0; i < 4; i++) {
    playingNow[i] = pattern[i][s] == 1;
    if (playingNow[i]) {
      samples[i].play();
    }
  }
}

void drawVisualizer() {
  float baseSize = 40;
  float hitSize = 120;

  for (int i = 0; i < 4; i++) {
    float size = playingNow[i] ? hitSize : baseSize;
    fill(colors[i], 180);
    noStroke();
    ellipse(width / 5 * (i + 1), height / 2, size, size);
  }

  fill(255);
  textAlign(CENTER);
  text("Step " + (step + 1), width / 2, height - 20);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("drum_machine_screenshot_####.png");
    println("Screenshot saved!");
  }
}
