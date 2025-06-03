import processing.sound.*;

SoundFile bounceSound;
SoundFile brickSound;
SoundFile gameOverSound;
SoundFile tickSound;

Ball ball;
Paddle paddle;
ArrayList<Brick> bricks;

int score = 0;
int lives = 3;

boolean gameOver = false;
boolean gameWon = false;
int buttonX = 240, buttonY = 230, buttonW = 120, buttonH = 40;

int countdown = 3;        // countdown set to 3 seconds
int countdownStartTime;   
boolean countingDown = true;

int lastSecondPlayed = -1;  // to track when tick sound played last

void setup() {
  size(600, 400);
  bounceSound = new SoundFile(this, "bounce.wav");
  brickSound = new SoundFile(this, "brick.wav");
  gameOverSound = new SoundFile(this, "gameover.wav");
  tickSound = new SoundFile(this, "tick.wav");   // Load tick sound

  ball = new Ball();
  paddle = new Paddle();
  createBricks();
  startCountdown();
}

void draw() {
  background(0);

  paddle.update();
  paddle.display();

  for (Brick b : bricks) {
    b.display();
  }

  fill(255);
  textSize(16);
  text("Score: " + score, 10, 20);
  text("Lives: " + lives, width - 80, 20);

  if (countingDown) {
    int elapsed = (millis() - countdownStartTime) / 1000;
    int timeLeft = max(0, countdown - elapsed);

    // Play tick sound once per second
    if (timeLeft != lastSecondPlayed) {
      if (timeLeft > 0) {
        tickSound.play();
      }
      lastSecondPlayed = timeLeft;
    }

    textSize(48);
    fill(255);
    text("Starting in " + timeLeft, width / 2 - 130, height / 2);

    if (timeLeft <= 0) {
      countingDown = false;
      lastSecondPlayed = -1;
    }

    ball.display();  // Show ball but no movement
  } else {
    ball.update();
    ball.checkEdges();
    ball.checkPaddle(paddle);
    ball.checkBricks(bricks);
    ball.display();

    if (ball.y > height) {
      lives--;
      if (lives > 0) {
        resetBall();
        startCountdown();
      } else {
        gameOver = true;
        gameOverSound.play();
      }
    }

    if (bricks.size() == 0) {
      gameWon = true;
    }
  }

  if (gameOver || gameWon) {
    textSize(32);
    fill(255);
    if (gameOver) text("Game Over", width / 2 - 80, height / 2 - 30);
    if (gameWon) text("You Win!", width / 2 - 60, height / 2 - 30);

    fill(180);
    rect(buttonX, buttonY, buttonW, buttonH);
    fill(0);
    textSize(20);
    text("Restart", buttonX + 20, buttonY + 27);

    noLoop();
  }
}

void keyPressed() {
  if (keyCode == LEFT) paddle.move(-1);
  else if (keyCode == RIGHT) paddle.move(1);
}

void keyReleased() {
  paddle.stop();
}

void mousePressed() {
  if ((gameOver || gameWon) &&
      mouseX > buttonX && mouseX < buttonX + buttonW &&
      mouseY > buttonY && mouseY < buttonY + buttonH) {
    score = 0;
    lives = 3;
    ball = new Ball();
    paddle = new Paddle();
    createBricks();
    gameOver = false;
    gameWon = false;
    loop();
    startCountdown();
  }
}

void startCountdown() {
  countdownStartTime = millis();
  countingDown = true;
  lastSecondPlayed = -1;
}

void resetBall() {
  ball = new Ball();
  paddle = new Paddle();
  countingDown = true;
  countdownStartTime = millis();
  lastSecondPlayed = -1;
}

void createBricks() {
  bricks = new ArrayList<Brick>();
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 8; j++) {
      bricks.add(new Brick(j * 75 + 10, i * 25 + 40));
    }
  }
}

class Ball {
  float x, y, dx, dy, radius = 10;

  Ball() {
    x = width / 2;
    y = height / 2;
    dx = random(-3, 3);
    dy = -4;
  }

  void update() {
    x += dx;
    y += dy;
    dy += 0.05;
  }

  void display() {
    fill(255);
    ellipse(x, y, radius * 2, radius * 2);
  }

  void checkEdges() {
    if (x < 0 || x > width) dx *= -1;
    if (y < 0) dy *= -1;
  }

  void checkPaddle(Paddle p) {
    if (x > p.x && x < p.x + p.w && y + radius > p.y && y + radius < p.y + p.h) {
      dy *= -1;
      dx *= 0.98;
      bounceSound.play();
    }
  }

  void checkBricks(ArrayList<Brick> bricks) {
    for (int i = bricks.size() - 1; i >= 0; i--) {
      Brick b = bricks.get(i);
      if (x > b.x && x < b.x + b.w && y - radius < b.y + b.h && y + radius > b.y) {
        dy *= -1;
        bricks.remove(i);
        score += 10;
        brickSound.play();
        break;
      }
    }
  }
}

class Paddle {
  float x, y, w = 80, h = 10;
  float speed = 5;
  int dir = 0;

  Paddle() {
    x = width / 2 - w / 2;
    y = height - 30;
  }

  void update() {
    x += dir * speed;
    x = constrain(x, 0, width - w);
  }

  void display() {
    fill(200);
    rect(x, y, w, h);
  }

  void move(int d) {
    dir = d;
  }

  void stop() {
    dir = 0;
  }
}

class Brick {
  float x, y, w = 70, h = 20;

  Brick(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    fill(255, 100, 100);
    rect(x, y, w, h);
  }
}
