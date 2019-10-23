// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A random walker object!

class Walker 
{
  int x,y;
  color c;
  boolean a;

  Walker(int xi, int yi, color ci, boolean ai) 
  {
    //x = (int) random(0,width);
    //y = (int) random(0,height);
    //c = (color) random(#000000);
    //c = base[int(random(0,8))];
    //a = true;
    x = xi; // x position
    y = yi; // y position
    c = ci; // color
    a = ai; // active?
  }

  void show() 
  {
    if (a)
    {
      stroke(c,20);
      //ellipse(x,y,4,4);
      point(x,y);
    }
  }

  // Randomly move up, down, left, right, or stay in one place
  void move() 
  {
    int choice = int(random(4));
 
    if (choice == 0) {
      x++;
    } else if (choice == 1) {
      x--;
    } else if (choice == 2) {
      y++;
    } else {
      y--;
    }
    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
  }
  
  // Move toward a point (cxA,cyA)
  void moveA() 
  {
    dX = abs(x - cxA);
    dY = abs(y - cyA);
    if (dX > dY)
    {
      if (x > cxA) { x--; }
      else         { x++; }
    }
    else
    {
      if (y > cyA) { y--; }
      else         { y++; }
    }    

    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
  }
  
  // Move toward a point (cxB,cyB)
  void moveB() 
  {
    dX = abs(x - cxB);
    dY = abs(y - cyB);
    if (dX > dY)
    {
      if (x > cxB) { x--; }
      else         { x++; }
    }
    else
    {
      if (y > cyB) { y--; }
      else         { y++; }
    }    

    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
  }    
}