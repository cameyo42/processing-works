class Vpoint
{      
  int x, y;
  color c;
  int t;

  Vpoint (int _x, int _y, color _c, int _t)
  {
    x = _x;   // x coord
    y = _y;   // y coord
    c = _c;   // point color
    t = _t;   // player point (1 or 2)
  }
}

//class VpointOTHER
//{      
//  int x, y;
//  int r;
//  color sc;
//  color fc;
//  color c;
//  int t;
//
//  Vpoint (int _x, int _y, int _r, color _sc, color _fc, color _c, int _t)
//  {
//    x = _x;   // x coord
//    y = _y;   // y coord
//    r =_r;    // radius of influence
//    sc = _sc; // stroke color area
//    fc = _fc; // fill color area
//    c = _c;   // point color
//    t = _t;   // type of point (0 or 1)
//  }
//  
//  void display()
//  {
//    pushStyle();
//    // draw influence area (circle)
//    stroke(sc);
//    fill(fc);
//    ellipse(x, y, r, r);
//    // draw point 
//    stroke(c);
//    point(x, y);
//    popStyle();
//  }
//}
