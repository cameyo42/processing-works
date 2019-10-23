// Voronoi Game
// cameyo 2017

ArrayList<Vpoint> voroPoint = new ArrayList<Vpoint>();

PGraphics vpPG;

int player;
int scoreP1, scoreP2;
color p1AreaCol, p2AreaCol;
color p1FillCol, p2FillCol;
color p1StrokeCol, p2StrokeCol;
color p1PointCol, p2PointCol;

int radiusInfluence;
int pointSize;

color vpCol = color(0);
boolean update = true;
int td = 0; // distance type
PImage img;

// Prohibited area 
int xp1,yp1, xp2,yp2;
color prohibitedCol;

//*********************************
void setup()
{
  size(800, 800);
  smooth();
  background(240);
  noStroke();
  fill(vpCol);

  voroPoint.clear();

  player = 1;
  scoreP1 = 0;
  scoreP2 = 0;

  p1AreaCol = color(100);
  p1PointCol = color(15);
  p1StrokeCol = color(15); 
  p1FillCol = color(36,93,150); // player 1 blue
 
  p2AreaCol = color(155);
  p2PointCol = color(15);
  p2StrokeCol = color(15);
  p2FillCol = color(255,154,60); // player 2 orange
  
  radiusInfluence = 51;
  pointSize = 8;
  
  // Prohibited area
  xp1 = width/3;
  xp2 = width - xp1;
  yp1 = height/3;
  yp2 = height - yp1;
  prohibitedCol = color(255,50,50,50);

  vpPG = createGraphics(width, height);
  vpPG.smooth();
  vpPG.beginDraw();
  vpPG.clear();
  vpPG.endDraw();
}

//*********************************
void draw()
{
  //background(240);
  showInfo();
  if (update)
  {
    background(240);
    update = false;
    
    // draw voronoi areas
    //int start = millis();
    doVoronoi();
    //println(voroPoint.size(), millis()-start);
    
    // draw prohibited area
    if (voroPoint.size() < 5)
    {
      noStroke();
      fill(prohibitedCol);
      rect(xp1,0,xp2-xp1,height-1);
      //rect(0,yp1,width,yp2-yp1);
      rect(0,yp1,xp1,yp2-yp1); // left
      rect(xp2,yp1,xp1,yp2-yp1);
    }
    
    // draw voronoi points (player 1 and Player 2)
    if (voroPoint.size() > 0)
    {
      vpPG.beginDraw();
      vpPG.clear();

      for (int p=0; p < voroPoint.size(); p++)
      {
        Vpoint v = voroPoint.get(p);
        if (v.t == 1) // player 1 point
        {
          vpPG.stroke(p1StrokeCol);
          vpPG.strokeWeight(2);
          //vpPG.noStroke();
          vpPG.fill(p1FillCol);
          vpPG.ellipse((int)v.x, (int)v.y, radiusInfluence, radiusInfluence);
          vpPG.noStroke();
          vpPG.fill(p1PointCol);
          vpPG.ellipse(v.x, v.y, pointSize, pointSize);
        }
        else if (v.t == 2) // player 2 point
        {
          vpPG.stroke(p2StrokeCol);
          vpPG.strokeWeight(2);
          //vpPG.noStroke();
          vpPG.fill(p2FillCol);
          vpPG.ellipse((int)v.x, (int)v.y, radiusInfluence, radiusInfluence);
          vpPG.noStroke();
          vpPG.fill(p2PointCol);
          vpPG.ellipse(v.x, v.y, pointSize, pointSize);
        }
        else println("ERROR: wrong point tipe:",v.t, p);
      }
      //vpPG.updatePixels();
      vpPG.endDraw();
      // show points
      image(vpPG,0,0);
      // calculate score
      calcScore();
    }
  }

}

//*********************************
void mousePressed()
{
  int x1 = mouseX;
  int y1 = mouseY;
  color c;
  if (validPoint(x1,y1))  
  {
    if (player == 1)
    {
      Vpoint vp = new Vpoint(x1, y1, p1AreaCol, player);
      voroPoint.add(0, vp);
      player = 2;
    }
    else if (player == 2)
    {
      Vpoint vp = new Vpoint(x1, y1, p2AreaCol, player);
      voroPoint.add(0, vp);
      player = 1;
    }
    else println("ERROR: wrong player:", player);
    
    update = true;
  }
}


//*********************************
void keyPressed()
{
  // new game
  if (keyCode == TAB)
  {
    voroPoint.clear();
    player = 1;
    update = true;
    scoreP1 = 0;
    scoreP2 = 0;
  }
  
  // undo insert point
  if (key=='u' || key=='U')
  {
    if (voroPoint.size() > 0)
    {
      voroPoint.remove(0); 
      if (player == 1) { player = 2; }
      else if (player == 2) { player = 1; }
    }
    update = true;
  }  
  
  // save image
  if (key=='s'||key=='S')
  {
    saveImage();
  }

  if (key=='d'||key=='D')
  {
    td = (td+1) % 2;
    if (td == 0) println("euclidean");
    if (td == 1) println("manhattan");
    //if (td == 2) println("minkowski");
    update = true;
  }

}

//*********************************
void saveImage()
{
  String filename = newFilename();
  save(filename+".png");
}

//*********************************
String newFilename()
{
  int y, m, d;
  int hh, mm, ss;
  String name, out;
  y=year();
  m=month();
  d=day();
  hh=hour();
  mm=minute();
  ss=second();
  name = getClass().getSimpleName();
  out=name+"_"+y+"-"+nf(m, 2)+"-"+nf(d, 2)+"_"+nf(hh, 2)+"."+nf(mm, 2)+"."+nf(ss, 2);
  return out;
}

//*********************************
void doVoronoi()
{
  // println(voroPoint.size());
  int closest_distance;
  int point_distance;
  int maxDistance = width*width + height*height;
  loadPixels();
  for (int y = 0; y < height-1; y++)
  {
    for (int x = 0; x < width-1; x++)
    {
      closest_distance = maxDistance;
      for (int p = 0; p < voroPoint.size(); p++)
      {
        Vpoint v = voroPoint.get(p);
        // calls function to calc distance
        point_distance = fastDistance(v.x, v.y, x, y, td);
        if (point_distance < closest_distance)
        {
          pixels[x+y*width] = v.c;
          closest_distance = point_distance;
        }
      }
    }
  }
  updatePixels();
}

//*********************************
void calcScore()
{
  scoreP1 = 0;
  scoreP2 = 0;
  int loc = 0;
  loadPixels();
  for (int y = 0; y < height-1; y++)
  {
    for (int x = 0; x < width-1; x++)
    {
      loc = x + y*width;
      if (pixels[loc] == p1AreaCol)
      {
        scoreP1++;
      }
      else if (pixels[loc] == p2AreaCol)
      {
        scoreP2++;
      }
    }
  }
  int tot = scoreP1+scoreP2;
  scoreP1 = (int) round(100.0*scoreP1/(scoreP1+scoreP2));
  scoreP2 = 100 - scoreP1;
}
//*********************************
void changePlayer()
{
  if (player == 1) { player = 2; }
  else if (player == 2) { player = 1; }
  else { println("ERROR: wrong player", player); }
}


//*********************************
// check the clicked point
// The point distance must be greater of radiusInfluence from all points
boolean validPoint(int x, int y)
{
  boolean valid = true;
  // check intersections with all the points
  int influence = radiusInfluence + 2;
  for (int p = 0; p < voroPoint.size(); p++)
  {
    Vpoint v = voroPoint.get(p);
    // check distance
    if (dist(v.x, v.y, x, y) < influence)
    {
      valid = false;
      break;
    }
  }
  // check intersections with prohibited area
  if (valid && voroPoint.size() < 5)
  {
    if ((x > xp1 && x < xp2) || ((y > yp1 && y < yp2)))
    {
      valid = false;
    }
  }
  return valid;
}

//*********************************
// Pseudo distance between two points (no square root)
int fastDistance(int x1, int y1, int x2, int y2, int t)
{
  if (t == 0) // short euclidean distance
  {
    return( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) );
  }
  else if (t == 1) { return (abs(x1-x2) + abs(y1-y2)); } // manhattan distance
  //else if (t == 2) { return( (x1-x2)*(x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)*(y1-y2) );} // minkowski distance
  else  { return ((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)); }
}

//*********************************
void showInfo()
{
  String info;
  info = "VORONOI - (Turn " + (voroPoint.size()/2 + 1);
  if (player==1) { info = info + " for player " + player + " - blue )"; }
  else { info = info + " for player " + player + " - orange )"; }
  info = info + " - [Area player 1 (blue): " + scoreP1 + "%] [Area player 2 (orange): " + scoreP2 + "%]";
  // set window title
  surface.setTitle(info);
}

// voronoi concept (brute-force)
//
//for yloop = 0 to height-1
//  for xloop = 0 to width-1
//
//    // Maximal value for distance
//    closest_distance = width*width + height*height
//    // find the voronoi point with minimal distance from (xloop,yloop) point
//    for point = 0 to number_of_points-1
//      // calls function to calc distance
//      point_distance = distance(point, xloop, yloop)
//      if point_distance < closest_distance
//        closest_point = point
//        closet_distance = point_distance
//      end if
//    next
//
//  // place result in array of point types with proper color 
//  // (each voronoi point has a different color)
//  points[xloop, yloop] = point
//
//  next
//next