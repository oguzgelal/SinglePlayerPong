int screenWidth = 1200;
int screenHeight = 700;
float playerwidth = 10;
float playerheight = 80;
float maxPlayerHeight = 400;
float playerheightincrease = 1.07;
int playerY = screenHeight/2;
float barspeed = 10;
float barspeedincrease = 1.04;
float ballspeedincrease = 1.1;
boolean goup = false;
boolean godown = false;
int playergap = 10;
int currentscore = 0;
int highscore = 0;
float ball_x = screenWidth/2;
float ball_y = screenHeight/2;
float ball_r = 10;
float ball_r_half = ball_r/2;
float ball_speed_x;
float ball_speed_y;
boolean gamestart = false;

void setup() {
  size(screenWidth, screenHeight, P3D);
}

void draw() {
  background(0);
  // draw texts
  textSize(15);
  text("Current", screenWidth/4, 80);
  textSize(35);
  text(currentscore, screenWidth/4, 120);
  textSize(15);
  text("Highscore", 3*(screenWidth/4), 80);
  textSize(35);
  text(highscore, 3*(screenWidth/4), 120);
  if (!gamestart) {
    textAlign(CENTER);
    textSize(40);
    text("SINGLE PLAYER", screenWidth/2, 100);
    textSize(80);
    text("PONG", screenWidth/2, 170);
    textSize(20);
    text("Click/Enter To Start", screenWidth/2, screenHeight/2-30);
    textSize(25);
    text("Controls:", screenWidth/2, screenHeight-50);
    textSize(20);
    text("Mouse or UP/DOWN Keys", screenWidth/2, screenHeight-30);
  }
  // draw middle line
  stroke(255);
  for (int i = 0; i < screenHeight; i+= 20) {
    line(screenWidth/2, i, screenWidth/2, i+10);
  }
  // change playerY
  if (goup) { 
    playerY+=barspeed;
  }
  if (godown) { 
    playerY-=barspeed;
  }
  // draw players
  int player1_x = playergap;
  int player1_y = playerY;
  float player2_x = screenWidth-playergap-playerwidth;
  float player2_y = screenHeight-playerY;
  fill(255);
  rectMode(CORNER);
  rect(player1_x, player1_y, playerwidth, playerheight);
  rect(player2_x, player2_y, playerwidth, playerheight);
  // draw ball
  rectMode(CENTER);
  rect(ball_x, ball_y, ball_r, ball_r);
  // gameplay
  if (gamestart) {
    // move ball
    ball_x += ball_speed_x;
    ball_y += ball_speed_y;
    // check ball_y coordinates
    if ( ball_y+ball_r_half >= screenHeight ) { 
      ball_speed_y *= -1;
      ball_y = screenHeight-ball_r;
    }
    else if ( ball_y-ball_r_half <= 0 ) { 
      ball_speed_y *= -1;
      ball_y = ball_r;
    }
    // player 1 collision
    if (ball_x-ball_r_half <= player1_x+playerwidth) {
      if ((ball_y+ball_r_half >= player1_y) && (ball_y-ball_r_half <= (player1_y+playerheight))) {
        ball_speed_x *= -1 * ballspeedincrease;
        barspeed *= barspeedincrease;
        ball_x = player1_x+playerwidth+ball_r;
        currentscore++;
        if (currentscore > highscore) {
          highscore = currentscore;
        }
        if (playerheight < maxPlayerHeight) {
          playerheight *= playerheightincrease;
        }
      }
      else {
        //death
        gamestart = false;
        if (currentscore > highscore) {
          highscore = currentscore;
        }
        currentscore = 0;
        ball_x = screenWidth/2;
        ball_y = screenHeight/2;
      }
    }
    // player 2 collision
    else if (ball_x+ball_r_half >= player2_x) {
      if ((ball_y >= player2_y) && (ball_y <= (player2_y+playerheight))) {
        ball_speed_x *= -1 * ballspeedincrease;
        barspeed *= barspeedincrease;
        ball_x = player2_x-ball_r;
        currentscore++;
        if (currentscore > highscore) {
          highscore = currentscore;
        }
        if (playerheight < maxPlayerHeight) {
          playerheight *= playerheightincrease;
        }
      }
      else {
        //death
        gamestart = false;
        if (currentscore > highscore) {
          highscore = currentscore;
        }
        currentscore = 0;
        ball_x = screenWidth/2;
        ball_y = screenHeight/2;
        playerheight = 80;
      }
    }
  }
}

void mousePressed() {
  startGame();
}
void mouseMoved() {
  playerY = mouseY;
}

void keyPressed() {
  if (keyCode == UP) {
    godown = true;
  }
  if (keyCode == DOWN) {
    goup = true;
  }
}
void keyReleased() {
  if (keyCode == UP) {
    godown = false;
  }
  if (keyCode == DOWN) {
    goup = false;
  }
  if (keyCode == ENTER) {
    startGame();
  }
}

void startGame() {
  if (!gamestart) {
    int rand1 = int(random(0, 1));
    if (rand1 == 0) { 
      ball_speed_x = -5;
    }
    else {
      ball_speed_x = 5;
    }
    int rand2 = int(random(0, 1));
    if (rand2 == 0) {
      ball_speed_y = -3;
    }
    else {
      ball_speed_y = 3;
    }
    barspeed = 10;
    gamestart = true;
  }
}

