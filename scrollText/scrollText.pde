// scrollText.pde
// by cameyo 2016
// processing 3.x

// font
PFont font;
PFont fontBig;
String[] lines = new String[5];
// global constant variables
int global;
// palette color
color[] base = {#002b36, #073642, #586e75, #657b83, #839496, #93a1a1, 
#eee8d5, #fdf6e3};
color[] hues = {#b58900, #cb4b16, #dc322f, #d33682, #6c71c4, #268bd2, 
#2aa198, #859900};
// global variables
String filename;
boolean start;
float x,y;
int lineGap;

//*********************************
void setup()
{
  size(640, 480);
  frameRate(60);
  smooth();
  background(base[0]);
  font = createFont("Calibri Bold", 14);
  fontBig = createFont("Calibri Bold", 34);
  textFont(font);
  // set global constant variables
  global = 0;
  // set global variables
  init();
}

//*********************************
void init()
{
  textAlign(CENTER,CENTER);
  x = width/2;
  lineGap = 50;
  y = -lineGap*lines.length;  
  start = true;
  filename  = "";
  lines[0] = "Principi di Programmazione";
  lines[1] = "Teorema di Bohm-Jacopini";
  lines[2] = "Object Oriented";
  lines[3] = "Functional Programming";
  lines[4] = "Refactoring";
  
}

//*********************************
void draw()
{
  float pos;
  if (start)
  {
    background(base[0]);
    stroke(#073642);
    line(0, height/2, width, height/2); 
    for(int i = 0; i < lines.length; i++)
    {
      pos = y + i*lineGap;
      if ((pos > height/2 - lineGap/2) && (pos < height/2 + lineGap/2))
      {
        textFont(fontBig);
        fill(#eee8d5);
      }
      else
      {
        textFont(font);
        fill(#586e75);
        fill(#073642);
      }      
      text(lines[i],x,pos);
    }
    y = y+.5;
    if (y > height+lineGap) { y = -lineGap*lines.length;  }    
  }
}

//*********************************
void mousePressed()
{
  int mx = mouseX;
  int my = mouseY;
  //println(mx,my);
}

void mouseMoved()
{
  int mx = mouseX;
  int my = mouseY;
  //println(mx,my);
}

//*********************************
void keyPressed()
{
  // start/stop
  if (key==' ')
  {
    start = (!start);
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
  name = getClass().getSimpleName();
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