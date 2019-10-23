// **************************************************
// * spiderPaint.pde
// * by cameyo 2015
// *
// * Idea from:
// * "harmony" procedural drawing app
// * http://mrdoob.com/lab/javascript/harmony/#web
// *
// * Processing 3.x
// **************************************************
import controlP5.*;

// ********************
// VARIABLE DECLARATION
// ********************  

// variable for controllers
ControlP5 cp5;

// colorpicker control
ColorPicker cp;

// boolean control for button (no run first event)
boolean theNEW=true, theFIX=true, theSAVE=true, theALPHA= true;

// array of line history
ArrayList history = new ArrayList();

// distance of attraction
float attraction = 50;
// density of line drawing
float density = 0.4;
// alpha of stroke draw
int transparency = 50;
// height of bottom menu
int menuHeight = 120;

// font for text
PFont myFont1, myFont2;

// background color
color backColor = color(255);
color BIANCO = color(255);
color NERO = color(0);

// drawing color
color brushColor;

// swatch color
color swatchColor = color(0);

// color of bottom menu 
color menuColor = color(60);

// image palette
PImage paletteIMG;

// type of brush
boolean PENCIL = false;

void setup()
{
  size(1200, 900);
  background(backColor);
  myFont1 = loadFont("Consolas-16.vlw"); 
  myFont2 = loadFont("Consolas-Bold-16.vlw"); 
  brushColor = color(0, transparency);  
  stroke(brushColor);  
  strokeWeight(1);

  cp5 = new ControlP5(this);

  // button NEW control 
  PImage[] imgs1 = { loadImage("btnNEW01.png"), loadImage("btnNEW02.png"), loadImage("btnNEW03.png") };
  cp5.addButton("newCanvas")
     .setValue(1)
     .setPosition(20, height-menuHeight+20)
     .setImages(imgs1)
     .updateSize()
     ;     

  // button FIX control 
  PImage[] imgs2 = { loadImage("btnFIX01.png"), loadImage("btnFIX02.png"), loadImage("btnFIX03.png") };
  cp5.addButton("fix")
     .setValue(2)
     .setPosition(64, height-menuHeight+20)
     .setImages(imgs2)
     .updateSize()
     ;          

  // button SAVE control 
  PImage[] imgs3 = { loadImage("btnSAVE01.png"), loadImage("btnSAVE02.png"), loadImage("btnSAVE03.png") };
  cp5.addButton("save")
     .setValue(3)
     .setPosition(108, height-menuHeight+20)
     .setImages(imgs3)
     .updateSize()
     ;

  // color picker control  
  cp = cp5.addColorPicker("myPicker")
     .setPosition(width-570, height-menuHeight+20)
     .setColorValue(color(0, 0, 0, transparency))
     .setBarHeight(20)
     ;
  
  // "attraction" slider control  
  cp5.addSlider("attraction")
     .setPosition(width-280, height-menuHeight+20)
     .setSize(200, 20)
     .setRange(1, 200)
     .setValue(60)
     .setColorForeground(#777777)
     .setColorBackground(#101010)
     ;  
  //cp5.controller("attraction").setColorForeground(#777777);
  //cp5.controller("attraction").setColorBackground(#101010);     

  // "density" slider control     
  cp5.addSlider("density")
     .setPosition(width-280, height-menuHeight+58)
     .setSize(200, 20)
     .setRange(0, 1)
     .setValue(0.4)
     .setColorForeground(#777777)     
     .setColorBackground(#101010)
     ;       
  //cp5.controller("density").setColorForeground(#777777);
  //cp5.controller("density").setColorBackground(#101010);     

  // "alfa" slider control       
  cp5.addSlider("fineAlpha")
     .setPosition(width-570, height-menuHeight+96)
     .setWidth(490)
     .setRange(0,40) // values can range from big to small as well
     .setValue(40)
     .setColorForeground(#777777)
     .setColorBackground(#101010)
     .setNumberOfTickMarks(41)
     .setSliderMode(Slider.FLEXIBLE)
     //.setSliderMode(Slider.FIX)     
     // use Slider.FIX or Slider.FLEXIBLE to change the slider handle     
     // by default it is Slider.FIX       
     ;
  //cp5.controller("fineAlpha").setColorForeground(#777777);
  //cp5.controller("fineAlpha").setColorBackground(#101010);  

  // load image palette
  paletteIMG = loadImage("palette.png");
  smooth();
}

//**********************
//* DRAW function
//**********************
void draw()
{
  // draw bottom menu background
  stroke(menuColor);
  fill(menuColor);
  rect(0, height - menuHeight, width, height);

  // draw white rectangle under colorpicker control
  fill(255);
  noStroke();
  rect(width-570, height - menuHeight+20, 255, 59);  

// draw swatch color rectangle
  fill(swatchColor);
  stroke(255);
  rect(width-640, height - menuHeight+20, 58, 58);  

  // draw text buttons (NEW - FIX - SAVE)
  textFont(myFont1);
  fill(255);
  text("new", 19, height-menuHeight + 65);
  text("fix", 62, height-menuHeight + 65);
  text("save", 103, height-menuHeight + 65);
  
  // draw backgroud color swatch (BLACK and WHITE)
  text("canvas", 50, height-menuHeight + 108);

  if (backColor == BIANCO) { stroke(255,0,0); }  
  else { stroke(255);}
  fill(255);
  rect(19,height-menuHeight + 90, 20, 20);
  
  if (backColor == NERO) { stroke(255,0,0); }  
  else { stroke(0);}
  fill(0);
  rect(114,height-menuHeight + 90, 20, 20);  

  // show image color palette
  image(paletteIMG, 200, height-menuHeight+10);  

  // set color brush
  noFill();
  stroke(brushColor);
}

// slider ALFA event
public void fineAlpha(int theValue) 
{
  // println("alfa slider" + theValue);  
  transparency = theValue;
  int r = int(red(brushColor));
  int g = int(green(brushColor));
  int b = int(blue(brushColor));
  cp.setColorValue(color(r, g, b, transparency));  
}

// button NEWCANVAS event
public void newCanvas(int theValue) 
{ 
  if (theNEW) { theNEW = false; }
  else
  {
    // println("new button: " + theValue);
    history.clear();    
    background(backColor);
  }
}

// button FIX event
public void fix(int theValue) 
{
  if (theFIX) { theFIX = false; }
  else
  {  
    // println("fix button: " + theValue);
    // clear history
    history.clear();
    // show fixed image    
    PImage fixIMG;
    fixIMG = get(0, 0, width, height-menuHeight);
    image(fixIMG, 0, 0, width, height-menuHeight);
  }
}

// button SAVE event
public void save(int theValue) 
{
  if (theSAVE) { theSAVE = false; }
  else
  {    
    // println("save button: " + theValue);
    PImage outIMG;
    outIMG = get(0, 0, width, height-menuHeight);
    outIMG.save(newFilename() + ".png");  
  }
}

// controlpicker event (select color)
public void controlEvent(ControlEvent c) {
  // when a value change from a ColorPicker is received, extract the ARGB values
  // from the controller's array value
  if (c.isFrom(cp)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    color col = color(r, g, b, a);
    brushColor = color(r, g, b, a);
    swatchColor = color(r, g, b, 255);
    transparency = a;
    // cp5.controller("fineAlpha").setValue(a);  // DO NOT WORK !!! (circular reference ?)
    // println("colorpicher event\talpha:"+a+"\tred:"+r+"\tgreen:"+g+"\tblue:"+b+"\tcol"+col);
  }
}

// ***************************
// MOUSE INTERACTION
// ***************************

// mouse pressed
void mousePressed()
{
   //println("Mouse pressed at: " + mouseX + " - " + mouseY);  
   // mouse over color palette ?
   if ((mouseX > 200) && (mouseX < 200+197) && (mouseY > height-menuHeight+10) && (mouseY < height-menuHeight+10+99))
   {
     color pickColor = get(mouseX,mouseY);
     // println(pickColor);     
     int r = int(red(pickColor));
     int g = int(green(pickColor));
     int b = int(blue(pickColor));
     cp.setColorValue(color(r, g, b, transparency));
   }  
   // mouse over canvas (black and white) buttons ?   
   if ((mouseX > 19) && (mouseX < 19+20) && (mouseY > height-menuHeight+90) && (mouseY < height-menuHeight+90+20))
   {   
     backColor = BIANCO;
   }  
   if ((mouseX > 114) && (mouseX < 114+20) && (mouseY > height-menuHeight+90) && (mouseY < height-menuHeight+90+20))
   {   
     backColor = NERO;
   }  
}   

// mouse dragged
void mouseDragged()
{
  if (mouseY < height-menuHeight)
  {
    if (PENCIL)
    { line(pmouseX,pmouseY,mouseX,mouseY); }
    else
    {
      PVector d = new PVector(mouseX, mouseY, 0);
  
      history.add(0, d);
  
      for (int p=0; p<history.size(); p++)
      {
        PVector v = (PVector) history.get(p);
        float joinchance = p/history.size() + d.dist(v)/attraction;
        if (joinchance < random(density))  line(d.x, d.y, v.x, v.y);
  
  //      if (joinchance < random(density))  
  //      {
  //        fill(150,transparency);
  //        quad(d.x, d.y, v.x,d.y, v.x,v.y, d.x,v.y);
  //        ellipse((d.x+v.x)/2,(d.y+v.y)/2,dist(d.x,d.y,v.x,v.y),dist(d.x,d.y,v.x,v.y));
  //        bezier(d.x,d.y, v.x,d.y, d.x,v.y, v.x,v.y);
  //        bezier(d.x,d.y, d.x,v.y, v.x,d.y, v.x,v.y);        
  //        bezier(d.x,d.y, d.x,v.y, v.x,v.y, v.x,d.y);                
  //      }  
      }
    }
  }
}

// ***************************
// KEYBOARD INTERACTION
// ***************************

void keyPressed()
{
  // new drawing with current color as background
  if (key=='b' || key=='B')
  {
    history.clear();
    background(brushColor);
  }

  // less DENSITY
  if (key == '1') 
  {
    PENCIL=!(PENCIL);
    //    cp.setColorValue(color(255, 128, 25, transparency));
  }  

  // more DENSITY
  if (key == '2') 
  {
    if (history.size() > 1) 
    { 
      println(history.size());
      history.remove(1); 
//      redraw(); 
    }
  }  

  // save canvas image
  if (key=='s' || key=='S') 
  {
    PImage outIMG;
    outIMG = get(0, 0, width, height-menuHeight);
    outIMG.save(newFilename() + ".png");
  }

  // fix canvas image  
  if (key=='f' || key=='F') 
  {  
    // clear history
    history.clear();
    // show fixed image    
    PImage fixIMG;
    fixIMG = get(0, 0, width, height-menuHeight);
    image(fixIMG, 0, 0, width, height-menuHeight);
  }
  
  // toggle canvas background color (new)
  if (key=='c' || key=='C') 
  {  
    if (backColor == BIANCO) { backColor = NERO; }
    else { backColor = BIANCO; }
  }  
  
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