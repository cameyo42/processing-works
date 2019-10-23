// texter.pde
// by cameyo 2014
// for processing 3.0
//
// library: generativedesign

// based on sketch: P_2_3_3_01_TABLET_TOOL.pde
// by Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// from book: Generative Gestaltung, ISBN: 978-3-87439-759-9
//            First Edition, Hermann Schmidt, Mainz, 2009
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 ***  MOUSE, TABLET and KEYBOARD CONTROLS
 *
 * MOUSE
 * drag                : draw with text (textfile.txt)
 *
 * TABLET
 * drag                : draw with text (textfile.txt)
 * pressure            : textsize
 *
 * KEYS & GUI
 * del                 : clear screen
 * t                   : tablet on/off
 * shift               : horizontal or vertical font direction
 * ctrl                : diagonal font direction
 * backspace           : delete last char
 * 1..9                : change font type
 * +                   : font size +1
 * -                   : font size -1
 * ,                   : font alpha -1
 * .                   : font alpha +1
 * j                   : font kerning -0.1
 * k                   : font kerning +0.1 
 * q                   : font distortion angle +0.1
 * a                   : font distortion angle -0.1
 * 0                   : font distortion angle reset
 * r                   : random font type
 * e                   : random font color
 * i                   : show/hide image (underlay.png)
 * ;                   : image alpha -1
 * ;                   : image alpha +1
 * n                   : image threshold -0.05
 * m                   : image threshold +0.05 
 * v                   : invert image
 * g                   : grayscale image
 * arrow up            : image move up one pixel
 * arrow down          : image move down one pixel
 * arrow left          : image move left one pixel
 * arrow right         : image move right one pixel
 * l                   : open image
 * x                   : open text file
 * b                   : change background color
 * c                   : load user palette (userPalette.txt)
 * s                   : save png
 * p                   : save pdf
 * u                   : show/hide popup info
 * h                   : show/hide help window 
 * z                   : zoom on/off
 */

import java.util.Calendar;

import generativedesign.*;
Tablet tablet;

import processing.pdf.*;

boolean opened=false;

boolean savePDF = false;

// start value
float x = 0, y = 0;

// distance
float stepSize = 5.0;

// current font
PFont font;

// info font
PFont infoFont;

// array of fonts type
PFont[] listfont = new PFont[10];

// array of fonts name
String[] namefont = new String[10];

String letters = "letters";

int counter = 0;

// arralist of item (char)
ArrayList drawItems;

//int undoIndex = 0;

// image base
PImage imgBase;

// image background
PImage img;
int imgAlpha = 100;
boolean showImage = false;

// output image
PImage outIMG;

//int clickPosX = 0;
//int clickPosY = 0;

// text file
String txt[];

// space for bottom menu
int menuHEIGHT=100;

// font size
float newFontSize = 50;
int fontSizeMin = 5;
int fontSizeMax = 200;
float lastFontSize = 20;

// font distorsion angle
float angleDistortion = 0.0;

// font color
color fontColor=color(0);

// font alpha
int fontAlpha=255;

// random font type
boolean rndFont=false;

// random font color
boolean rndCol=false;

// char distance
float kerning=1;

// index font
int fontNum=4;

// tablet ON/OFF
boolean wacom=false;

// draw on canvas flag
boolean canDraw=false;

// x,y image position (upper left corner)
int xIMG=0;
int yIMG=0;

// palette colors
color[] userPal = {
  #262B30, #E09A25, #F0D770, #F2EDBC, #C51C30, #FFFFCD, #CC5C54, #F69162, #85A562, #7AB5DB, #0C2550, #A3D0C1, #FDF6DD, #FEE406, #F4651C, #302F2F, #74AD92, #F07F47, #FFAA42, #FFE224, #D9C6B0, #314650, #2D4761, #45718C, #B6E1F2, #C3CCC8, #442412, #475D1C, #859356, #B9961C, #666666, #607F9C, #E9CCAE, #FFFFF3, #D01312, #C3CCC8, #442412, #475D1C, #859356, #B9961C, #666666, #607F9C, #E9CCAE, #FFFFF3, #D01312
};
color[] web = {
  #000000, #000033, #000066, #000099, #0000CC, #0000FF, #003300, #003333, #003366, #003399, #0033CC, #0033FF, #006600, #006633, #006666, #006699, #0066CC, #0066FF, #009900, #009933, #009966, #009999, #0099CC, #0099FF, #00CC00, #00CC33, #00CC66, #00CC99, #00CCCC, #00CCFF, #00FF00, #00FF33, #00FF66, #00FF99, #00FFCC, #00FFFF, #330000, #330033, #330066, #330099, #3300CC, #3300FF, #333300, #333333, #333366, #333399, #3333CC, #3333FF, #336600, #336633, #336666, #336699, #3366CC, #3366FF, #339900, #339933, #339966, #339999, #3399CC, #3399FF, #33CC00, #33CC33, #33CC66, #33CC99, #33CCCC, #33CCFF, #33FF00, #33FF33, #33FF66, #33FF99, #33FFCC, #33FFFF, #660000, #660033, #660066, #660099, #6600CC, #6600FF, #663300, #663333, #663366, #663399, #6633CC, #6633FF, #666600, #666633, #666666, #666699, #6666CC, #6666FF, #669900, #669933, #669966, #669999, #6699CC, #6699FF, #66CC00, #66CC33, #66CC66, #66CC99, #66CCCC, #66CCFF, #66FF00, #66FF33, #66FF66, #66FF99, #66FFCC, #66FFFF, #990000, #990033, #990066, #990099, #9900CC, #9900FF, #993300, #993333, #993366, #993399, #9933CC, #9933FF, #996600, #996633, #996666, #996699, #9966CC, #9966FF, #999900, #999933, #999966, #999999, #9999CC, #9999FF, #99CC00, #99CC33, #99CC66, #99CC99, #99CCCC, #99CCFF, #99FF00, #99FF33, #99FF66, #99FF99, #99FFCC, #99FFFF, #CC0000, #CC0033, #CC0066, #CC0099, #CC00CC, #CC00FF, #CC3300, #CC3333, #CC3366, #CC3399, #CC33CC, #CC33FF, #CC6600, #CC6633, #CC6666, #CC6699, #CC66CC, #CC66FF, #CC9900, #CC9933, #CC9966, #CC9999, #CC99CC, #CC99FF, #CCCC00, #CCCC33, #CCCC66, #CCCC99, #CCCCCC, #CCCCFF, #CCFF00, #CCFF33, #CCFF66, #CCFF99, #CCFFCC, #CCFFFF, #FF0000, #FF0033, #FF0066, #FF0099, #FF00CC, #FF00FF, #FF3300, #FF3333, #FF3366, #FF3399, #FF33CC, #FF33FF, #FF6600, #FF6633, #FF6666, #FF6699, #FF66CC, #FF66FF, #FF9900, #FF9933, #FF9966, #FF9999, #FF99CC, #FF99FF, #FFCC00, #FFCC33, #FFCC66, #FFCC99, #FFCCCC, #FFCCFF, #FFFF00, #FFFF33, #FFFF66, #FFFF99, #FFFFCC, #FFFFFF
};

// background color
color backColor=color(255);

// help window flag
boolean showHelp=false;
boolean eraseHelp=false;

// help image
PImage helpIMG;

// zoom flag
boolean zoom=false;
//int zoomFactor=16;

// canvas scale flag
boolean winScale=false;

// popup text
String popup = "Texter by cameyo 2014";
// popup flag
boolean showPopup=false;
// creator
String creator="Texter by cameyo 2014";

//image editing
float imgTH=0.0;

//*********************
// SETUP
//*********************
void setup()
{
  // use full screen size (meno qualcosa...)
  // size(screen.width-screen.width/30, screen.height-screen.width/30);
  size(1200, 900);
  
  //surface.setResizable(true);

  background(backColor);
  smooth();
  tablet = new Tablet(this);
  drawItems = new ArrayList();

  // use the following line to view your system fonts
  //printArray(PFont.list());
  
  //font = createFont("ArnhemFineTT-Normal",10);
  listfont[1]= createFont("Arial",12);
  listfont[2]= createFont("Courier New",12);
  listfont[3]= createFont("Consolas",12);
  listfont[4]= createFont("Georgia",12);
  listfont[5]= createFont("Impact",12);
  listfont[6]= createFont("Verdana",12);
  listfont[7]= createFont("Segoe Script",12);
  listfont[8]= createFont("Times New Roman",12);
  listfont[9]= createFont("xkcd",12);

  namefont[1]= "Arial";
  namefont[2]= "Courier New";
  namefont[3]= "Consolas";
  namefont[4]= "Georgia";
  namefont[5]= "Impact";
  namefont[6]= "Verdana";
  namefont[7]= "Segoe Script";
  namefont[8]= "Times New Roman";
  namefont[9]= "xkcd";

  infoFont = createFont("Arial",12);
  font = listfont[fontNum];
  textFont(font, fontSizeMin);

  cursor(CROSS);

  // load image for background
  img = loadImage("underlay.png");
  //  xIMG=0;
  //  yIMG=0;
  xIMG=width/2;
  yIMG=(height-menuHEIGHT)/2;
  imageMode(CENTER);
  
  //base image
  imgBase = loadImage("underlay.png");

  // load image for help
  helpIMG = loadImage("help.png");

  // load text file
  txt = loadStrings("textfile.txt");
  //println(txt.length);
  //for (int i=0; i < txt.length; i++)
  //{ println(txt[i]); }

  // concatenate lines
  letters="";
  for (int i=0; i < txt.length; i++)
  { 
    letters=letters+txt[i]+" ";
  }
  //println(letters);

  //draw bottom menu
reDrawAllDrawItems();  
  drawMenu();
}

//*********************
// DRAW
//*********************
void draw()
{
  
  if (opened)
  {
    reDrawAllDrawItems();
    drawMenu();
    opened=false;
    println("draw opened");
  }  
  
  // PDF
  if (savePDF)
  {
    beginRecord(PDF, timestamp()+".pdf");
    reDrawAllDrawItems();
    drawMenu();
  }
  if (savePDF)
  {
    savePDF = false;
    endRecord();
  }

  if ((mousePressed) && canDraw)
  {
    float d = dist(x, y, mouseX, mouseY);
    // gamma values optimized for wacom intuos 3
    //float pressure = gamma(tablet.getPressure()*1.1, 2.5);
    // gamma values optimized for my wacom tablet...
    if (wacom)
    {
      float pressure = gamma(tablet.getPressure()*1.1, 2.0);
      newFontSize = fontSizeMin + 200*pressure;
      //println("newFontSize="+newFontSize);
    }

    //newFontSize=22;
    textFont(font, newFontSize);
    char newLetter = letters.charAt(counter);
    stepSize = textWidth(newLetter)*kerning;

    float angle = atan2(mouseY-y, mouseX-x);

    // press SHIFT to draw horizontal/vertical aligned text (both direction)
    if (keyPressed && keyCode == SHIFT)
    {
      angle = round(8*angle/TWO_PI);
      if (angle%2 == 0) angle = angle * TWO_PI/8;
      else d = 0;
      //println("pressed SHIFT");
    }

    // press CONTROL to draw diagonal aligned text (both direction)
    if (keyPressed && keyCode == CONTROL)
    {
      angle = round(8*angle/TWO_PI);
      //println(angle+"-"+angle%2);
      if (angle%2 == 1) angle = angle * TWO_PI/8;
      else if (angle%2 == -1) angle = angle * PI/4;
      else d = 0;
      //println("pressed CONTROL");
    }

    if (d > stepSize)
    {
      angle += random(angleDistortion);

      drawItem drw = new drawItem();
      drw.angle = angle;
      drw.x = x;
      drw.y = y;
      drw.letter = newLetter;
      if (rndFont)
      { 
        drw.dfont = listfont[int(random(1, 10))];
      }
      else 
      {  
        drw.dfont = font;
      }  
      if (rndCol)
      { 
        drw.dcolor = userPal[int(random(0,16))];
      }
      else 
      {  
        drw.dcolor = fontColor;
      }        
      drw.fontSize = newFontSize;
      drw.dalpha = fontAlpha;

      drw.draw();
      drawItems.add(drw);

      counter++;

      // check for end of letters
      if (counter > letters.length()-1) counter = 0;

      x = x + cos(angle) * stepSize;
      y = y + sin(angle) * stepSize;
    }
  }

  // show windows help
  if (showHelp) { 
    winHelp();
  }
  else if (eraseHelp)
  {
    reDrawAllDrawItems();
    drawMenu();
    eraseHelp=false;
  }

  // show popup text
  if (showPopup)
  {
    textFont(infoFont);
    fill(60);
    stroke(255);
    rect(width/2-85, height-90, 170, 16);
    fill(255);
    textAlign(CENTER);
    text(popup, 1+width/2, height-77);
    textAlign(LEFT);
  }

  // zomm window
  if (zoom)
  { 
    PImage imgZoom;
    int zoomFactor = 16;
    int cx=0, cy=0, ex=0, ey=0;
    int xz = mouseX-zoomFactor/2;
    int yz = mouseY-zoomFactor/2;
    if ( xz < 0) { xz = 0; }
    if ( yz < 0) { yz = 0; }
    if ( xz > width-zoomFactor)  { xz = width-zoomFactor; }
    if ( yz > height-zoomFactor) { yz = height-zoomFactor; }
    imgZoom = get(xz, yz, zoomFactor, zoomFactor);
    cx = width-365+38; 
    cy = height-menuHEIGHT+5+37; 
    ex = cx; 
    ey = cy;
    //noSmooth();
    tint(255,255);
    image(imgZoom, cx, cy, 74, 74);
    // draw cross
    stroke(0);
    line(cx-8, cy, cx+8, cy);
    line(cx, cy-8, cx, cy+8);
    // draw center point
    noStroke();
    fill(255, 0, 0);
    ellipse(ex, ey, 3, 3);
    //smooth();
  }

}


//*********************
// GAMMA function
//*********************
// gamma ramp, non linear mapping ...
float gamma(float theValue, float theGamma)
{
  return pow(theValue, theGamma);
}

// timestamp
String timestamp()
{
  Calendar now = Calendar.getInstance();
  return String.format("20%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

//*********************
// reDrawAllDrawItems
//*********************
void reDrawAllDrawItems()
{
  background(backColor);
  if (showImage)
  {
    background(backColor);
    tint(255, imgAlpha);
    image(img, xIMG, yIMG);
  }

  for (int i = 0; i < drawItems.size(); i++)
  {
    drawItem tmp = (drawItem) drawItems.get(i);
    tmp.draw();
  }
}


//*********************
// UNDO
//*********************
// remove only last drawed chars
//void undoDrawItems(int theUndoIndex) {
//  theUndoIndex -= 1;
//  if (drawItems.size() > 0 && theUndoIndex >= 0) {
//    for (int i = drawItems.size()-1; i > theUndoIndex; i--) {
//      drawItems.remove(i);
//    }
//  }

// remove one char at time (cameyo)
void undoDrawItem()
{
  if (drawItems.size() > 0)
  {
    drawItems.remove(drawItems.size()-1);
    counter--;
    if (counter < 0) { 
      counter = 0;
    }
  }
}

// *************************
// loadUserPalette FUNCTION
// *************************
void loadUserPalette()
{
  String colori[] = loadStrings("userPalette.txt");
  for (int i=0; i < colori.length; i++)
  {
    userPal[i] = color(unhex(colori[i])|0xff000000);
  }
}

// *************************
// winHelp FUNCTION
// *************************
void winHelp()
{
  image(helpIMG, width/2, (height-menuHEIGHT)/2);
}