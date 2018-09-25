class musicCircle
{
  float x;
  float y;
  float h;
  float w;
  float ySpeed;

  musicCircle ()
  {
    x = 120;
    y = 400;
    h = 100;
    w = 100;
    ySpeed = 2.25;
  }
  //overloaded constructor
  musicCircle (float _x, float _w, float _h)
  {
    x = _x;
    y = 400;
    h = _h;
    w = _w;
    ySpeed = random (1, 3.25);
  }

  void Render()
  {
    noStroke();
    fill (130, 160, 70);
    ellipse (x, y, w, h);
  }

  void Move()
  {
    //sends the circle back up if it goes off the screen
    y += ySpeed; 
    if (y > 900)
    {
      y = -100;
    }
    // makes the ySpeed random if the circle gets sent to the top of the screen
    if (y < 95)
    {
      ySpeed = random (1, 3.25);
    }
  }
}
