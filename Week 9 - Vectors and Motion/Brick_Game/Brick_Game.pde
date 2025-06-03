Ball ball;
Paddle paddle;
ArrayList<Brick> bricks;
int score = 0;

void setup() {
  size(600, 400);
  ball = new Ball();
  paddle = new Paddle();
  bricks = new ArrayList<Brick>();
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 8; j++) {
      bricks.add(new Brick(j * 75 + 10, i * 25 + 40));
    }
  }
}

void draw() {
  background(0);
  ball.update();
  ball.checkEdges();
  ball.checkPaddle(paddle);
  ball.checkBricks(bricks);
  ball.display();

  paddle.update();
  paddle.display();

  for (Brick b : bricks) {
    b.display();
  }

  fill(255);
  text("Score: " + score, 10, 20);
  
  if (ball.y > height) {
    textSize(32);
    text("Game Over", width/2 - 80, height/2);
    noLoop();
  }
  if (bricks.size() == 0) {
    textSize(32);
    text("You Win!", width/2 - 60, height/2);
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
    dy += 0.05; // Gravity
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
    if (x > p.x && x < p.x + p.w && y + radius > p.y && y + radius < p.y + 10) {
      dy *= -1;
      dx *= 0.98; // Friction
    }
  }

  void checkBricks(ArrayList<Brick> bricks) {
    for (int i = bricks.size() - 1; i >= 0; i--) {
      Brick b = bricks.get(i);
      if (x > b.x && x < b.x + b.w && y - radius < b.y + b.h && y + radius > b.y) {
        dy *= -1;
        bricks.remove(i);
        score += 10;
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
