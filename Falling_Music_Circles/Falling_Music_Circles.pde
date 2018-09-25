import processing.sound.*; //<>//
SoundFile file;
String audioName = "I Got One AllttA instru.mp3";
String path;
musicCircle [] movingCircles = new musicCircle [8];
targetCircle [] staticCircles = new targetCircle [8];
int scene = 1;
PImage ok = null;
PImage perfect = null;
int whcf = 10; // width / height change factor
int inSize = 100; //Initial circle size
int space = 120; // Distance from side of screen to centre of first circle (x pos)
int score = 0;
int menuTime = 0;
int stoppedTime =0;

void setup ()
{
  size(1200, 800, P2D);
  //initializing the first 4 pairs of circles so they decrease in size but the distance between them stays the same
  for (int i = 0; i < 4; i++)
  {
    movingCircles [i] = new musicCircle (space + i*(space - (whcf/2)*i), inSize-(i*whcf), inSize-(i*whcf));
    staticCircles [i] = new targetCircle (space + i*(space - (whcf/2)*i), inSize-(i*whcf), inSize-(i*whcf));
  }
  //initializing the other 4 pairs of circles so they increase in size but the distance between them stays the same
  for (int i = 7; i > 3; i--)
  {
    movingCircles [i] = new musicCircle (width - (space +((i*-1)+7)*(space - (whcf/2)*((i*-1)+7))), inSize-(((i*-1)+7)*whcf), inSize-(((i*-1)+7)*whcf));
    staticCircles [i] = new targetCircle (width - (space +((i*-1)+7)*(space - (whcf/2)*((i*-1)+7))), inSize-(((i*-1)+7)*whcf), inSize-(((i*-1)+7)*whcf));
  }
  //setting the value of letter to what I want displayed
  staticCircles[0].setDisplay ('q');
  staticCircles[1].setDisplay ('w');
  staticCircles[2].setDisplay ('e');
  staticCircles[3].setDisplay ('r');
  staticCircles[4].setDisplay ('u');
  staticCircles[5].setDisplay ('i');
  staticCircles[6].setDisplay ('o');
  staticCircles[7].setDisplay ('p');

  ok = loadImage ("OKImage.png");
  perfect = loadImage ("perfectImage.png");

  ok.resize (120, 100);
  perfect.resize (120, 100);
}

void draw ()
{
  if (scene == 1)
  {
    SceneOne();
  }
  if (scene == 2)
  {
    SceneTwo();
  }
  if (scene == 3)
  {
    SceneThree();
  }
}

void SceneOne()
{
  background (0);
  fill (255);
  textSize(22);
  textAlign(CENTER);
  text ("Instructions:", 400, 200, 400, 50);
  text ("Press the key on your keyboard corresponding to the static circle that is coming in contact with a moving circle to score points and keep the song playing. Press the key when both circles are very close together to score more points. (It's basically guitar hero)", 400, 250, 400, 300);
  text ("Press 'S' to start", 400, 700, 400, 100); 
  //starts the game is 's' is pressed
  if (keyPressed)
  {
    if ( key == 's' || key == 'S')
    {
      background(0);
      scene = 2; 
      path = sketchPath(audioName);
      file = new SoundFile(this, path);
      file.play();
      menuTime = millis();
    }
  }
}

void SceneTwo()
{
  fill(0, 10);
  rect(0, 0, width, height);

  volumeUp();

  //calling all the functions from the classes
  for (int i =0; i<8; i++)
  {
    staticCircles[i].Render();
    movingCircles[i].Render();
    movingCircles[i].Move();
  }
  textAlign(CENTER);
  text ("Score:", 550, 100, 100, 100); 
  text (""+score, 400, 140, 400, 100);
  //timer
  int timeLeft = 184-((millis()/1000)-(menuTime/1000));
  text ("Time left (in seconds):", 500, 300, 200, 100);
  text (""+timeLeft, 400, 380, 400, 100);
  //ends game if time left is zero
  if (timeLeft < 1)
  {
    scene = 3;
  }
  //collisions 
  for (int i = 0; i < 8; i++)
  {
    staticCircles[i].buffer--;
    if (keyPressed)
    {
      if (key ==(staticCircles[i].letter) && dist(movingCircles[i].x, movingCircles[i].y, staticCircles[i].x, staticCircles[i].y)>(movingCircles[i].h) && staticCircles[i].buffer<0)
      {
        score -= 50;
        textAlign (CENTER);
        text ("Release key", 500, 500, 200, 100);
        staticCircles[i].buffer=50;
      }
    }
    if (dist(movingCircles[i].x, movingCircles[i].y, staticCircles[i].x, staticCircles[i].y)<(movingCircles[i].h/4))
    {
      if (keyPressed)
      {
        if (key == (staticCircles[i].letter))
        {
          image (perfect, 540, 475);
          score+=100;
          movingCircles[i].y = -100;
          stoppedTime = millis();
          staticCircles[i].buffer=50;
        }
      }
    } else if (dist(movingCircles[i].x, movingCircles[i].y, staticCircles[i].x, staticCircles[i].y)<(movingCircles[i].h))
    {
      if (keyPressed)
      {
        if (key == (staticCircles[i].letter))
        {
          image (ok, 540, 475);
          score+=50;
          movingCircles[i].y = -100;
          stoppedTime = millis();
          staticCircles[i].buffer=50;
        }
      }
    }
  }
}
//score screen
void SceneThree()
{
  background(0);
  fill(255);
  textSize(22);
  text ("Your score is:", 550, 300, 100, 100);
  text (""+score, 400, 400, 400, 400);
  text ("Game by a Dev", 550, 500, 100, 200);
}

void volumeUp()
{
  if ((millis()-stoppedTime)>5000)
  {
    file.amp(0);
  } else
  {
    file.amp(1);
  }
}
