// draw random geometric figure

void drawFigure(int idx)
{
  int choice = idxFigure;

  // select random figure
  if (rndFigure)
  {
    while (choice == idxFigure)
    {
      choice = (int) random(0,numFigure);
    }
  }
  // select figure with index = idx
  else
  {
    choice = idx;
  }

  idxFigure = choice;
  //println("choice =",choice);

  if (choice == 0) // circle
  {
    figureName = "Circle";
    ellipse(ww, hh, 150, 150);
  }

  if (choice == 1) // ellipse
  {
    figureName = "Ellipse";
    ellipse(ww, hh, 200, 100);
  }

  if (choice == 2) // triangle
  {
    figureName = "Triangle";
    triangle(ww, hh - 60, ww - 120, hh + 60 , ww + 120, hh + 60);
  }

  if (choice == 3) // square
  {
    figureName = "Square";
    rectMode(CENTER);
    rect(ww, hh, 150, 150);
    rectMode(CORNER);
  }

  if (choice == 4) // rectangle
  {
    figureName = "Rectangle";
    rectMode(CENTER);
    rect(ww, hh, 200, 100);
    rectMode(CORNER);
  }

  if (choice == 5) // exagon
  {
    figureName = "Exagon";
    polygon(ww, hh, 100, 6);
  }

  if (choice == 6) // star
  {
    figureName = "Star";
    star(ww, hh, 50, 100 ,5);
  }

  if (choice == 7) // square spiral
  {
    figureName = "Square spiral";
    beginShape();
    for(int i=0; i<12; i++)
    {
      float x = ((i+3)/4) * (((i+1)/2)%2*2-1) *25;
      float y = ((i+2)/4) * (((i)/2)%2*2-1) *25;
      vertex(x+ww,y+hh);
    }
    endShape();
  }

  if (choice == 8) // circular spiral
  {
    figureName = "Circular spiral";
    strokeWeight(2);
    spiral(ww, hh, 100, 2);
    strokeWeight(3);
  }

  if (choice == 9) // concentric circles
  {
    figureName = "Concentric circles";
    ellipse(ww, hh, 150, 150);
    ellipse(ww, hh, 50, 50);
  }

  if (choice == 10) // concentric squares
  {
    figureName = "Concentric squares";
    pushMatrix();
    translate(ww, hh);
    beginShape();
    // Exterior part of shape, clockwise winding
    vertex(-75, -75);
    vertex(75, -75);
    vertex(75, 75);
    vertex(-75, 75);
    // Interior part of shape, counter-clockwise winding
    beginContour();
    vertex(-25, -25);
    vertex(-25, 25);
    vertex(25, 25);
    vertex(25, -25);
    endContour();
    endShape(CLOSE);
    popMatrix();
  }

  if (choice == 11) // triple circles
  {
    figureName = "Triple circles";
    ellipse(ww, hh, 50, 50);
    ellipse(ww-100, hh, 50, 50);
    ellipse(ww+100, hh, 50, 50);
  }

  if (choice == 12) // triple squares
  {
    figureName = "Triple squares";
    rectMode(CENTER);
    rect(ww, hh, 50, 50);
    rect(ww-100, hh, 50, 50);
    rect(ww+100, hh, 50, 50);
    rectMode(CORNER);
  }

  if (choice == 13) // home
  {
    figureName = "Home";
    rectMode(CENTER);
    rect(ww, hh, 100, 100);
    rect(ww-24, hh-20, 14, 14);
    rect(ww+24, hh-20, 14, 14);
    rect(ww, hh+30, 20, 40);
    rectMode(CORNER);
    line(ww-50, hh-50, ww, hh-75);
    line(ww+50, hh-50, ww, hh-75);
  }

  if (choice == 14) // man
  {
    figureName = "Man";
    ellipse(ww, hh-100, 50, 50);
    line(ww, hh-72, ww, hh+40);
    line(ww, hh-72, ww-50, hh-50);
    line(ww, hh-72, ww+50, hh-50);
    line(ww, hh+40, ww-40, hh+90);
    line(ww, hh+40, ww+40, hh+90);
  }
  
  if (choice == 15) // snowman
  {
    figureName = "Snowman";
    fill(base[0]);
    ellipse(ww, hh+40, 110, 90);
    ellipse(ww, hh-10, 90, 70);
    ellipse(ww, hh-60, 50, 50);
  }
  
  if (choice == 16) // smile
  {
    figureName = "Smile";
    ellipse(ww, hh, 160, 160);
    ellipse(ww-36, hh-36, 20,20);
    ellipse(ww+36, hh-36, 20,20);
    arc(ww, hh+24, 80, 60, 0 , PI);
    line(ww, hh-16, ww, hh+16);
  }  

}

// polygon creator
void polygon(float x, float y, float radius, int npoints)
{
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

// spiral creator
void spiral( int xCentre, int yCentre, int maxRadius, float twistFactor)
{
    float angle, angleStep;
    float radius, radiusStep;
    float x, y, lastX, lastY;
    angle=0.0;
    angleStep=twistFactor*PI/(maxRadius*10);
    radius=0.0;
    radiusStep=0.05;
    lastX=xCentre;
    lastY=yCentre;
    while(radius <= maxRadius)
    {
        x=xCentre+radius*cos(angle);
        y=yCentre+radius*sin(angle);
        line( lastX, lastY, x, y);
        lastX=x;
        lastY=y;
        angle+=angleStep;
        radius+=radiusStep;
    }
}

// star creator
void star(float x, float y, float radius1, float radius2, int npoints)
{
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}