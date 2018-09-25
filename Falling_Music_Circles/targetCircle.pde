class targetCircle
{
  float x;
  float y;
  float h;
  float w;
  int buffer=0;
  char letter;

  targetCircle ()
  {
    x = 120;
    y = 700;
    h = 100;
    w = 100;
    letter = 'q';
  }

  void setDisplay (char _d)
  {
    letter = _d;
  }
  //Overloaded constructor
  targetCircle (float _x, float _w, float _h)
  {
    x = _x;
    y = 700;
    h = _h;
    w = _w;
  }

  void Render ()
  {
    noStroke();
    fill (255);
    ellipse (x, y, w, h);
    fill (0);
    textSize(22);
    text (letter, x, y);
  }
}
