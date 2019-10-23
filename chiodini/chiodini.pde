// **************************************************
// * chiodini.pde
// * by cameyo 2015
// *
// * The famous game of CHIODINI
// *
// * code written for Processing 3.x
// **************************************************

//***************************************************
// CHANGE DIMENSION OF GRID
// change sizeX and sizeY
// sizeX and (SizeY-100) MUST be multiple of dim
// 5 10 15 20 25 30 50
// working sizeX and sizeY:
// 1200x700 - 1200x1000 - 1500x700 - 1500x1000 - ...
//***************************************************

import java.util.Calendar;

// *********************
// VARIABLE DECLARATION
// *********************

int MAXNUMBER = 250;

// image background
PImage backIMG;

// griglia matrix points chiodini
int[][] griglia = new int[MAXNUMBER][MAXNUMBER];
// griglia matrix colors chiodini
color[][] colGriglia = new color[MAXNUMBER][MAXNUMBER];
// griglia matrix tipo chiodini
int[][] tipoGriglia = new int[MAXNUMBER][MAXNUMBER];
// griglia matrix 3d chiodini
int[][] treDGriglia = new int[MAXNUMBER][MAXNUMBER];

// font for text
PFont font;
// output filename
String filename;
String savePath,loadPath;
// background color
color backC;
// chiodini type 0->circle, 1->square, 2->ERASE
int tipo, oldTipo;
// chiodini space (dimension)
int dim=20;
// chiodini alpha
int alfa;
// panel dimensions
int panelW, panelH;
// border weight
int linea;
// active color
color curColor;
// button red color
color redC;
// active color number
int colore;
// grid dimension
int gXmax, gYmax;
int gXmin, gYmin;
// grid current crow and column
int gX, gY;
// point grid current coords
int pX, pY;
// gridColor
color gridC;
// grid flag
boolean GRID;
// filling flag
boolean FILLING;
// zoom flag
boolean ZOOM;
// image background flag
boolean BACK;
// 3D effect flag
int treD;
// pick color flag
boolean pickColor;
// new drawing flag
boolean newyes;
// saved file flag
boolean savedFile;
// help flag
boolean HELP;
// palette heigth dimension
int palH = 90;
// flag work in progress
boolean wip;
// selectInput() dialog
boolean dlgInput;
boolean dlgOutput;
boolean thePath;
// data file lines
String linee[];


//******************************
// USER PALETTE
//******************************
//color[] userPal = {#263C8B, #4E74A6, #BDBF78, #BFA524, #2E231F, #0F0B26, #522421, #8C5A2E, #BF8641, #B3B372, #4D7186, #284253, #E0542E, #F4A720, #EF8C12, #3C535E, #252D2A, #F9D882, #3F422E, #261901, #514264, #527E8E, #8DB0A7, #989A55, #255C3F};
//color[] userPal = {#9F9694, #791F33, #BA3D49, #F1E6D4, #E2E1DC, #678C8B, #8FA89B, #A2BAB0, #D0EDDE, #B3B597, #262B30, #E09A25, #F0D770, #F2EDBC, #C51C30, #FFFFCD, #CC5C54, #F69162, #85A562, #7AB5DB, #0C2550, #A3D0C1, #FDF6DD, #FEE406, #F4651C, #302F2F, #74AD92, #F07F47, #FFAA42, #FFE224, #D9C6B0, #314650, #2D4761, #45718C, #B6E1F2, #C3CCC8, #442412, #475D1C, #859356, #B9961C, #666666, #607F9C, #E9CCAE, #FFFFF3, #D01312};
color[] userPal = {#262B30, #E09A25, #F0D770, #F2EDBC, #C51C30, #FFFFCD, #CC5C54, #F69162, #85A562, #7AB5DB, #0C2550, #A3D0C1, #FDF6DD, #FEE406, #F4651C, #302F2F, #74AD92, #F07F47, #FFAA42, #FFE224, #D9C6B0, #314650, #2D4761, #45718C, #B6E1F2, #C3CCC8, #442412, #475D1C, #859356, #B9961C, #666666, #607F9C, #E9CCAE, #FFFFF3, #D01312, #C3CCC8, #442412, #475D1C, #859356, #B9961C, #666666, #607F9C, #E9CCAE, #FFFFF3, #D01312};
color[] web = {#000000,#000033,#000066,#000099,#0000CC,#0000FF,#003300,#003333,#003366,#003399,#0033CC,#0033FF,#006600,#006633,#006666,#006699,#0066CC,#0066FF,#009900,#009933,#009966,#009999,#0099CC,#0099FF,#00CC00,#00CC33,#00CC66,#00CC99,#00CCCC,#00CCFF,#00FF00,#00FF33,#00FF66,#00FF99,#00FFCC,#00FFFF,#330000,#330033,#330066,#330099,#3300CC,#3300FF,#333300,#333333,#333366,#333399,#3333CC,#3333FF,#336600,#336633,#336666,#336699,#3366CC,#3366FF,#339900,#339933,#339966,#339999,#3399CC,#3399FF,#33CC00,#33CC33,#33CC66,#33CC99,#33CCCC,#33CCFF,#33FF00,#33FF33,#33FF66,#33FF99,#33FFCC,#33FFFF,#660000,#660033,#660066,#660099,#6600CC,#6600FF,#663300,#663333,#663366,#663399,#6633CC,#6633FF,#666600,#666633,#666666,#666699,#6666CC,#6666FF,#669900,#669933,#669966,#669999,#6699CC,#6699FF,#66CC00,#66CC33,#66CC66,#66CC99,#66CCCC,#66CCFF,#66FF00,#66FF33,#66FF66,#66FF99,#66FFCC,#66FFFF,#990000,#990033,#990066,#990099,#9900CC,#9900FF,#993300,#993333,#993366,#993399,#9933CC,#9933FF,#996600,#996633,#996666,#996699,#9966CC,#9966FF,#999900,#999933,#999966,#999999,#9999CC,#9999FF,#99CC00,#99CC33,#99CC66,#99CC99,#99CCCC,#99CCFF,#99FF00,#99FF33,#99FF66,#99FF99,#99FFCC,#99FFFF,#CC0000,#CC0033,#CC0066,#CC0099,#CC00CC,#CC00FF,#CC3300,#CC3333,#CC3366,#CC3399,#CC33CC,#CC33FF,#CC6600,#CC6633,#CC6666,#CC6699,#CC66CC,#CC66FF,#CC9900,#CC9933,#CC9966,#CC9999,#CC99CC,#CC99FF,#CCCC00,#CCCC33,#CCCC66,#CCCC99,#CCCCCC,#CCCCFF,#CCFF00,#CCFF33,#CCFF66,#CCFF99,#CCFFCC,#CCFFFF,#FF0000,#FF0033,#FF0066,#FF0099,#FF00CC,#FF00FF,#FF3300,#FF3333,#FF3366,#FF3399,#FF33CC,#FF33FF,#FF6600,#FF6633,#FF6666,#FF6699,#FF66CC,#FF66FF,#FF9900,#FF9933,#FF9966,#FF9999,#FF99CC,#FF99FF,#FFCC00,#FFCC33,#FFCC66,#FFCC99,#FFCCCC,#FFCCFF,#FFFF00,#FFFF33,#FFFF66,#FFFF99,#FFFFCC,#FFFFFF};

// ********************
// ********************
// SETUP FUNCTION
// ********************
// ********************
void setup()
{
  //******************************
  //       GRID DIMENSION
  //******************************
  size(1200, 700);
  //******************************
  smooth();
  // do not need a fast screen update
  frameRate(60);
  // ********************************************************************
  // load background image (dimension multiple of width and (height-100))
  // ********************************************************************
  backIMG = loadImage("backImage.jpg");
  //font = createFont("Liberation Mono",10,true);
  font = loadFont("LiberationMono-10.vlw");  
  // initialization of variables
  init();
  //  noLoop();

}

// ********************
// init FUNCTION
// ********************
void init()
{
  dlgInput = false;
  dlgOutput = false;
  // initialization of variables
  initVars();
  // set background color
  background(backC);
  // draw GUI buttons
  drawButtons();
  updateButtons();
  // draw ColorBox and Color Text
  updateCurrentColorGUI();
  // draw GUI text
  drawABC();
  // draw GUI rainbow color palette
  drawSpectrum();
  // draw GUI user color palette
  drawUserPalette();
  // draw GUI websafe color palette
  drawWebPalette();
  //draw points of grid
  drawGrid(dim/2, width, height-panelH, dim);
  //  noLoop();
}  
// ********************
// initVars FUNCTION
// ********************
void initVars()
{
  //String[] fontList = PFont.list();
  //println(fontList);
  
  textFont(font);
  colorMode(RGB);
  wip = false;
  tipo = 0;
  oldTipo = 0;
  alfa = 255;
  panelW = width;
  panelH = 100;
  curColor = color(0, 127, 255);
//  gridC = color(212, 212, 212, 255);
  gridC = color(180, 180, 180, 255);
  //  backC = color(180,180,190,255);
  backC = color(230, 230, 230, 255);
  redC = color(240, 10, 10);
  colore = 0;
  gXmax = width/dim;
  gYmax = (height-panelH)/dim;
  gXmin = 0;
  gYmin = 0;
  linea = 1;
  treD = 0;
  pickColor = false;
  newyes = false;
  savedFile = true;
  filename="";
  GRID = true;
  ZOOM = false;
  BACK = false;
  FILLING = false;
  HELP = false;
  // clear griglia matrix values
  resetGrid();
}

// ********************
// ********************
// DRAW FUNCTION
// ********************
// ********************
void draw()
{
  //************************
  // draw/update cursor type
  //************************
  // cursor
  //cursor(ARROW);
  if (pickColor) { cursor(HAND); }
  if (!(pickColor) && (mouseY < height - panelH))
  {
    cursor(CROSS);
  }
  else if (!(pickColor) && (mouseY > height - panelH))
  {
    cursor(ARROW);
  }

  //************************
  // draw/update zoom window
  //************************
  if (ZOOM)
  {
    winZoom();
  }

//  if (mousePressed == true)
//  {
//    println("mousepressed");
//    println(mouseX+" -  "+mouseY);
//  }
  
  // draw data from opened file
  if ((dlgInput==true) && (thePath==true))
  {   
    String[] punto;
    int iX, iY, iCol, t, z;
    dlgInput = false;
    cursor(WAIT);
    // clear grid matrix values
    resetGrid();
    // erase grid image
    noStroke();
    fill(backC);
    rectMode(CORNER);
    rect(0,0,width,height-panelH);
    // draw grid points
    drawGrid(dim/2, width, height-panelH, dim);
    // load data
    // linee[] = loadStrings(loadPath);
    int numPoints = linee.length - 1;
    for (int i=0; i < numPoints; i++)
    {
      punto = split(linee[i], ",");
      iX = int(punto[0]);
      iY = int(punto[1]);
      iCol = int(punto[2]);
      t = int(punto[3]);
      z = int(punto[4]);
      griglia[iX][iY] = 1;
      colGriglia[iX][iY] = iCol;
      tipoGriglia[iX][iY] = t;
      treDGriglia[iX][iY] = z;
      gX = iX;
      gY = iY;
      if ((gX < gXmax) && (gY < gYmax))
      {
        putChiodino((dim/2)+iX*dim, (dim/2)+iY*dim, dim-2, color(colGriglia[iX][iY]), tipoGriglia[iX][iY], iX, iY, treDGriglia[iX][iY]);
      }
    }
    savedFile = false;
    updateSaveButton();
    wip = true;
    cursor(ARROW);
  }
  
}