// copyGame.pde
// by cameyo 2015
// erase (draw over) geometric figure as fast as possible...
// processing 3.x

// font
PFont font;
// global constant variables
int global;
// palette color
color[] base = {#002b36, #073642, #586e75, #657b83, #839496, #93a1a1, #eee8d5, #fdf6e3};
color[] hues = {#b58900, #cb4b16, #dc322f, #d33682, #6c71c4, #268bd2, #2aa198, #859900};
// global variables
String filename;
// start new game ?
boolean start;
// canvas image
PImage img;
// logo image
PImage logo;
// figure color
color colFig;
// paint color
color colPaint;
// paintbrush dimension
int brushSize;
// allowed time for paint (ms)
int paintTime = 5000;
// start time of paint
int startTime;
// start to paint ?
boolean startPaint;
// allow to draw ?
boolean stopDraw;
// % erased
float erased;
// max number of figure
int numFigure;
// name of figure
String figureName;
// number of pixels of figure
int pixelFig;
// figure index
int idxFigure;
// random figure ?
boolean rndFigure;
// lines distance
int dd;
// center of screen
int ww, hh;

//*********************************
void setup()
{
  size(640, 480);
  smooth();
  frameRate(60);
  background(base[0]);
  logo = loadImage("logo.jpg");
  font = createFont("Calibri Bold", 32);
  textFont(font);
  textAlign(CENTER);
  // set global constant variables
  global = 0;
  numFigure = 17;
  dd = 60;
  ww = width/2;
  hh = height/2;

  // set global variables
  idxFigure = 0;
  figureName = "Circle";
  rndFigure = false;
  init();

}

//*********************************
void init()
{
  start = true;
  filename  = "";
  colFig = hues[0];
  colPaint = base[0];
  brushSize = 12;
  startPaint = false;
  stopDraw = false;
  erased = 0.0;
  textSize(32);

}

//*********************************
void draw()
{
  if (start)
  {
    start = false;
    background(base[0]);
    // draw random figure
    noFill();
    stroke(colFig);
    strokeWeight(3);
    if (rndFigure)
    {
       drawFigure(0);
    }
    else
    {
       drawFigure(idxFigure);
    }
    // draw lines
    strokeWeight(1);
    stroke(base[3]);
    line(0, dd, width, dd);
    line(0, height-dd, width, height-dd);
    // draw buttons
    drawButton(base[3],base[1]);
    // draw time
    fill(base[2]);
    text("Time: " + paintTime/100, ww, 42);
    // draw figure name
    textSize(24);
    fill(hues[0]);
    textAlign(LEFT);
    text(figureName, 10, height-20);
    textAlign(CENTER);
    // draw logo
    image(logo, width-170,height-45);
    // draw erased
    textSize(32);
    fill(base[2]);
    text("Erased: " + erased + " %", ww, height-18);

    // calc number of pixel of figure
    img = get(0, dd+1, width, height-2*dd-2);
    //img.save(newFilename()+".png");
    pixelFig = countColor(img, colFig);
    //println(pixelFig);
  }

  if (startPaint)
  {
    int elapsed = millis() - startTime;
    if (elapsed < paintTime) // time OK
    {
      // draw rectangles mask
      noStroke();
      fill(base[0]);
      rect(0,0,width,dd);
      rect(0, height - dd, width, dd);
      // draw lines
      strokeWeight(1);
      stroke(base[3]);
      line(0, dd, width, dd);
      line(0, height-dd, width, height-dd);
      // draw buttons
      drawButton(base[3],base[1]);
      // draw time
      fill(base[5]);
      text("Time: " + nf((paintTime - elapsed)/100, 2), ww, 42);
      // draw figure name
      textSize(24);
      fill(hues[0]);
      textAlign(LEFT);
      text(figureName, 10, height-20);
      textAlign(CENTER);
      // draw logo
      image(logo, width-170,height-45);
      // draw erased
      textSize(32);
      fill(base[3]);
      text("Erased: " + erased + " %", ww, height-18);
    }
    else // time elapsed
    {
      // stop draw
      startPaint = false;
      stopDraw = true;
      // draw rectangles mask
      noStroke();
      fill(base[0]);
      rect(0,0,width,dd);
      rect(0, height - dd, width, dd);
      // draw lines
      strokeWeight(1);
      stroke(base[3]);
      line(0, dd, width, dd);
      line(0, height-dd, width, height-dd);
      // draw buttons
      drawButton(base[3],base[1]);
      // draw time
      fill(base[5]);
      text("Time: 00", ww, 42);
      // draw figure name
      textSize(24);
      fill(hues[0]);
      textAlign(LEFT);
      text(figureName, 10, height-20);
      textAlign(CENTER);
      // draw logo
      image(logo, width-170,height-45);

      // calc number of pixel of figure
      img = get(0, dd+1, width, height-2*dd-2);
      //img.save(newFilename()+".png");
      int cc = countColor(img, colFig);
      //println(cc);
      erased = (100.0*(pixelFig-cc)/pixelFig);

      // draw erased
      textSize(32);
      fill(base[5]);
      text("Erased: " + nf(erased,1,1) + " %", ww, height-18);
    }
  }
}

//*********************************
int countColor(PImage img, color col)
{
  int numPixel=0;
  // scan image pixels
  for (int x=0; x < img.width; x++)
  {
    for (int y=0; y < img.height; y++)
    {
      // get color
      //color c = imgPal.get(x, y);
      color c = img.pixels[y*img.width+x];
      if (c != base[0])
      {
        if (deltaE(c, col, 2) < 60)
        //if (c == col)
        {
          numPixel++;
        }
      }
    }
  }
  return numPixel;
}

//*********************************
void mousePressed()
{
  int mx = mouseX;
  int my = mouseY;
  //println(mx,my);

  // click inside less time button OR more time button
  //ellipse(ww-90, 30, 30,30);
  //ellipse(ww+90, 30, 30,30);
  if (my < dd)
  {
    // get distance between the mouse click point and circle's center (LESS)
    float distance = dist(mx, my, ww-90, 30);
    if (distance <= 15) 
    {
      paintTime = constrain(paintTime - 1000, 1000, 9000);
      //println("LEFT");
      rndFigure = false;
      init();
    }
    // get distance between the mouse click point and circle's center (MORE)
    distance = dist(mx, my, ww+90, 30);
    if (distance <= 15) 
    {
      paintTime = constrain(paintTime + 1000, 1000, 9000);
      //println("RIGHT");
      rndFigure = false;
      init();
    }      
  }  

  // click inside Random button
  //rect(10, 10, 88, 40);
  if ((mx > 10) && (mx < 98) && (my > 10) && (my < 50))
  {
    //println("random");
    rndFigure = true;
    init();
  }

  // click inside Retry button
  //rect(110, 10, 62, 40);  
  if ((mx > 110) && (mx < 172) && (my > 10) && (my < 50))
  {
    //println("Retry");
    rndFigure = false;
    init();
  }

  
  // click inside Next figure (+) button
  //rect(width-50, 10, 40, 40);
  if ((mx > width-50) && (mx < width-10) && (my > 10) && (my < 50))
  {
    rndFigure = false;
    idxFigure = idxFigure + 1;
    if (idxFigure == numFigure)
    {
      idxFigure = 0;
    }
    init();
  }
  // click inside (-) button
  //rect(width-110, 10, 40, 40);
  if ((mx > width-110) && (mx < width-70) && (my > 10) && (my < 50))
  {
    rndFigure = false;
    idxFigure = idxFigure - 1;
    if (idxFigure < 0)
    {
      idxFigure = numFigure-1;
    }
    init();
  }

  // click on painting area
  if ((my > dd) && (my < height-dd))
  {
    noStroke();
    fill(colPaint);    
    if (!stopDraw)
    {
      ellipse(mx, my, brushSize, brushSize);
    }
    if ((startPaint==false) && (!stopDraw))
    {
      startPaint = true;
      startTime = millis();
      //println("start Timer="+startTime);
    }
  }

}

//*********************************
void mouseDragged()
{
  int mx = mouseX;
  int my = mouseY;
  //println(mx,my);

  if ((!stopDraw) && (my > dd) && (my < height-dd))
  {
    noStroke();
    fill(colPaint);
    ellipse(mx, my, brushSize, brushSize);
  }
}


//*********************************
void drawButton(color s, color f)
{
  stroke(s);
  fill(f);
  
  // Random button
  rect(10, 10, 88, 40);
  fill(s);
  textSize(22);
  text("Random", 54, 38);
  
  // Retry button
  fill(f);  
  rect(110, 10, 62, 40);
  fill(s);
  textSize(22);
  text("Retry", 140, 38);  
  
  // Next figure (+) button
  stroke(s);
  fill(f);
  rect(width-50, 10, 40, 40);
  fill(s);
  textSize(60);
  text("+", width-29, 48);
  
  // Previous figure (-) button
  stroke(s);
  fill(f);
  rect(width-110, 10, 40, 40);
  fill(s);
  text("-", width-90, 46);
  
  // Less time button
  stroke(s);
  fill(f);
  ellipse(ww-90, 30, 30, 30);
  line(ww-90, 40, ww-90, 20);
  line(ww-90, 40, ww-84, 34);
  line(ww-90, 40, ww-96, 34);

  // More time button
  ellipse(ww+90, 30, 30, 30);
  line(ww+90, 40, ww+90, 20);
  line(ww+90, 20, ww+96, 26);  
  line(ww+90, 20, ww+84, 26);
  fill(s);
  textSize(36);
}

//*********************************
void keyPressed()
{
  // start new random figure
  if (key==' ')
  {
    rndFigure = true;
    init();
  }

  // start next figure
  if (key=='+')
  {
    rndFigure = false;
    idxFigure = idxFigure + 1;
    if (idxFigure == numFigure)
    {
      idxFigure = 0;
    }
    init();
  }

  // start next figure
  if (key=='-')
  {
    rndFigure = false;
    idxFigure = idxFigure - 1;
    if (idxFigure < 0)
    {
      idxFigure = numFigure-1;
    }
    init();
  }

  if (key=='c')
  {
    // get canvas image
    img = get(0, dd+1, width, height-2*dd-2);
    // count color
    println(countColor(img, colFig));
  }

  // save image
  if (key=='s'||key=='S')
  {
    saveImage();
  }

 // show info
  if (key=='i'||key=='I')
  {
    info();
  }

  // open file
  if (key=='o'||key=='O')
  {
    openLoad();
  }
}

//*********************************
void info()
{
  String info;
  info = nf(int(frameRate),0);
  println(info);
  surface.setTitle(info);
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
  name=getClass().getSimpleName();
  out=name+"_"+y+"-"+nf(m, 2)+"-"+nf(d, 2)+"_"+nf(hh, 2)+"."+nf(mm, 2)+"."+nf(ss, 2);
  return out;
}

//*********************************
void openLoad()
{
  noLoop();
  selectInput("Select a file...", "loadFile");
}

//*********************************
void loadFile(File selection)
{
  if (selection == null)
  {
    println("No file selected.");
  }
  else
  {
    filename=selection.getAbsolutePath();
    println(filename);
  }
  loop();
}