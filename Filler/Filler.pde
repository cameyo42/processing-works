// Filler.pde
// by cameyo 2016
// MIT license 

import java.util.ArrayDeque;

// used by floodFill algorithm 
ArrayDeque<Point> q = new ArrayDeque<Point>();
// total number of images
int numImages = 31;
// total number of palettes
int numPalettes = 7;
// array of images
PImage[] imgs = new PImage[numImages];
// array of thumbnails
PImage[] thumbs = new PImage[numImages];
// current image number
int curImg;
// current thumbnail number
int curThumb;
// standard font
PFont font;
// canvas image 
PImage img;
// array of palettes
PImage[] pals = new PImage[numPalettes];
// current palette
int curPal;
// title image
PImage title;
// GUI panel
int Lpanel;
int Rpanel;
// current color
int curCol;
// toggle zoom
boolean zoom;
// image loaded flag
boolean loading;
// step for random fill
int fillStep;
// time for fill
int start, elapsed;
// GUI
Button btnSAVE, btnLOAD, btnMINUS, btnPLUS, btnRND;
Button btnWhiteFILL, btnSimmetryFILL;
Checkbox cbPick; 
PImage a;

void setup() 
{
  size(1200, 900);
  smooth();
  background(128);  
  //println("White: " + color(255));
  //println("Grey: " + color(128));
  //println("Black: " + color(0));
  // load title image
  title = loadImage("title.png");  
  // load images
  loadImages();
  // make thumbnails image
  makeThumbnails();
  // load palette colors
  loadPalettes();
  curPal = 0;  
  // set font
  font = createFont("Calibri Bold", 14);
  textAlign(CENTER);
  textFont(font);
  Lpanel = 140;
  Rpanel = 140;
  curCol = color(#FEC44F);
  zoom = false;
  loading = false;
  curImg = 0;
  curThumb = 0;
  fillStep = 10;
  // button
  btnRND = new Button(9, height-240, 120, 30, "fillIMG", "Random Fill", color(100), color(0) );    
  btnWhiteFILL = new Button(9, height-200, 120, 30, "fillIMG1", "White Fill", color(100), color(0) );      
  btnSimmetryFILL = new Button(9, height-160, 120, 30, "fillIMG2", "Simmetry Fill", color(100), color(0) );      
  btnSAVE = new Button(9, height-80, 120, 30, "saveIMG", "Save", color(100), color(0) );  
  btnLOAD = new Button(9, height-40, 120, 30, "btn_LOAD", "Load", color(100), color(0) );    
  btnMINUS = new Button(20, height/2 + 140, 40, 20, "thumbMINUS", "<<<", color(100), color(0) );  
  btnPLUS  = new Button(80, height/2 + 140, 40, 20, "thumbPLUS", ">>>", color(100), color(0) );    
  
  // checkbox
  cbPick = new Checkbox(width - Rpanel + 30, 750, 18, 18, "Pick color", false, color(0), color(100));  

  // set image
  setImage(curImg);
}
 
void draw() 
{
  background(128);
  if (loading)
  {
    loading = false;
    // center image
    imageMode(CENTER);  
    image(img, width/2, height/2);    
    img = get(0, 0, width, height);  
    imageMode(CORNER);      
  }  
  drawGUI();
}

// KEY PRESSED
void keyPressed() 
{
  if (key == 'l')  { openDialog(); }
  if (key == 'g')  { grabIMG(); }
  if (key == 's')  { saveIMG(); }
  if (key == 'z')  { zoom = !zoom; }
  if (key == 'p')  { cbPick.s = true; }
  if (key == 'r')  { fillStep = 10; fillIMG(); }  
  if (key == 'f')  { fillIMG1(); }    
  if (key == 'a')  { fillIMG2(); } //symmetry fill
  
  if (keyCode == LEFT)  { thumbMINUS(); }
  if (keyCode == RIGHT)  { thumbPLUS(); }
  if (keyCode == ENTER)
  {
    if (curThumb != curImg)
    {
      curImg = curThumb;
      setImage(curImg);
    }  
  }  
}

// MOUSEPRESSED
void mousePressed() 
{
  int mx, my;
  mx = mouseX;
  my = mouseY;
  //println(mx,my);

  // check click on button, checkbox, spinner
  btnMINUS.onClick();
  btnPLUS.onClick();
  btnRND.onClick();
  btnWhiteFILL.onClick();
  btnSimmetryFILL.onClick();
  btnSAVE.onClick();
  btnLOAD.onClick();
  //cbPick.onClick();    
  
  // pick active ?
  if (cbPick.s)
  { 
    int tempCol = curCol;
    curCol = get(mx, my);
    // no select black color
    if (curCol == -16777216) { curCol = tempCol; }
    cbPick.s = false;
  }
  else { cbPick.onClick(); }
  
  // check click on swatch color (change palette)
  if (mx > 1066 && mx < 1194 && my > 6 && my < 65)
  {  
    curPal++;
    if (curPal > pals.length - 1) { curPal = 0; }
//    palette = pals[curPal].get();  
  }
  // check click on palette colors
  if (mx > 1066 && mx < 1194 && my > 70 && my < 742)
  {
    int tempCol = curCol;  
    curCol = get(mx, my);
    // no select black color
    if (curCol == -16777216) { curCol = tempCol; }
    //println(curCol);
    return;
  }
  
  // check click on zoom window
  if (mx > 1071 && mx < 1190 && my > 776 && my < 895)
  {
    zoom = !zoom;
    return;
  }
  
  // check click on thumbnail window
  if (mx > 2 && mx < 136 && my > 448 && my < 582)
  {
    if (curThumb != curImg)
    {
      curImg = curThumb;
      setImage(curImg);
    }  
    return;
  }  
  
  // check click on image
  if (mx > Lpanel && mx < width-Rpanel && my > 0 && my < height)
  {
    // Flood fill area with current colour
    floodFill(img, mouseX, mouseY, curCol);
    return;
  }  
    
}

// MOUSEDRAGGED
void mouseDragged() 
{
  int mx, my;
  mx = mouseX;
  my = mouseY;
  //println(mx,my);

  // check click on palette colors
  if (mx > 1066 && mx < 1194 && my > 70 && my < 742)
  {
    int tempCol = curCol;
    curCol = get(mx, my);
    // no select black color
    if (curCol == -16777216) { curCol = tempCol; }
    //println(curCol);
  }
  
  // check click on image
  if (mx > Lpanel && mx < width-Rpanel && my > 0 && my < height)
  {
    // Flood fill area with current colour
    floodFill(img, mouseX, mouseY, curCol);
    return;
  }    
}
  
void setImage(int idx)
{
  // center image
  background(128);
  img = imgs[idx];
  imageMode(CENTER);  
  image(img, width/2, height/2);    
  img = get(0, 0, width, height);  
  imageMode(CORNER);
}  

void makeThumbnails()
{ 
  float lenX, lenY;  
  float scala;
  float lenXs, lenYs;    
  
  lenX = 130;
  lenY = 130;
  for(int i = 0; i < imgs.length; i++)
  {
    thumbs[i] = imgs[i].get();  
    // calculate the scale to fit the image 
    scala = min(lenX/thumbs[i].width, lenY/thumbs[i].height);
    lenXs = thumbs[i].width * scala;
    lenYs = thumbs[i].height * scala;
    // resize 
    thumbs[i].resize((int)lenXs+1, (int)lenYs+1);
  }    
}  

// floodFill algorithm
// adapted from processing forum code
void floodFill(PImage picture, int orgX, int orgY, int newColor) 
{
  int pw = picture.width;
  int ph = picture.height;
  if (orgX < 0 || orgX >= pw || orgY < 0 || orgY >= ph)
    return;
  // not fill gui    
  if (orgX < Lpanel || orgX >= pw-Rpanel || orgY < 0 || orgY >= ph)
    return;    
  picture.loadPixels();
  int [] pxl = picture.pixels;
  int orgColor = pxl[orgX + orgY * pw];
  // Stop if the color is not being changed.
  // TODO: Add distance color test
  // Do not write if same colors OR original color is Black
  if ((newColor == orgColor) || (orgColor == -16777216))
    return;
  // Proceed with flood fill
  Point p = new Point(orgX, orgY);
  q.add(p);
  int west, east;
  while (!q.isEmpty () ) { //&& q.size() < 500) {
    p = q.removeFirst();
    if (isToFill(p.x, p.y, pxl, pw, ph, orgColor)) {
      west = east = p.x;
      while (isToFill(--west, p.y, pxl, pw, ph, orgColor));
      while (isToFill(++east, p.y, pxl, pw, ph, orgColor));
      for (int x = west + 1; x < east; x++) {
        pxl[x + p.y * pw] = newColor;
        if (isToFill(x, p.y - 1, pxl, pw, ph, orgColor))
          q.add(new Point(x, p.y - 1));
        if (isToFill(x, p.y + 1, pxl, pw, ph, orgColor))
          q.add(new Point(x, p.y + 1));
      }
    }
  }
  picture.updatePixels();
}
 
// Returns true if the specified pixel requires filling
boolean isToFill(int px, int py, int[] pxl, int pw, int ph, int orgColor) {
  if (px < 0 || px >= pw || py < 0 || py >= ph)
    return false;
  // not fill gui
  if (px < Rpanel || px >= pw-Lpanel || py < 0 || py >= ph)
    return false;        
  return pxl[px + py * pw] == orgColor;
}
 
// class Point
class Point 
{
  int x, y;
  public Point(int x, int y) 
  {
    this.x = x;
    this.y = y;
  }
}

// Save button method
void saveIMG()
{
  String filename;
  filename = newFilename();
  PImage grabImage = get(Lpanel+1,0,width-Rpanel-Lpanel-1,height);
  grabImage.save(filename+".png");
  surface.setTitle("Filler: image saved as " + filename);  
  //println("Saved.");
}

void grabIMG()
{
  String filename;
  filename = "grab_" + newFilename();
  save(filename+".png");
  //println("Saved.");
}

// Minus button method
void thumbMINUS()
{
  curThumb--; 
  if (curThumb < 0) { curThumb = imgs.length - 1; }
}

// Plus button method
void thumbPLUS()
{
  curThumb++; 
  if (curThumb > imgs.length - 1) { curThumb = 0; }  
}  

String newFilename()
{
  int y, m, d;
  int hh, mm, ss;
  String name, out;
  y=year(); m=month(); d=day();
  hh=hour(); mm=minute(); ss=second();
  name=getClass().getSimpleName();
  out=name+"-"+y+"-"+nf(m, 2)+"-"+nf(d, 2)+"."+nf(hh, 2)+"-"+nf(mm, 2)+"-"+nf(ss, 2);
  return out;
}

void btn_LOAD()
{
  openDialog();
}
//*********************************
void openDialog()
{
  noLoop();
  selectInput("Select an image...", "loadIMG");
}

//*********************************
void loadIMG(File selection) 
{
  if (selection == null) 
  {
    //println("No file selected.");
  } 
  else 
  {
    img = loadImage (selection.getAbsolutePath());
    loading = true;
  }
  loop();
}

void fillIMG()
{ 
  cursor(WAIT);
  surface.setTitle("Filler: filling image...");      
  start = millis();  
  randomFill();
  elapsed = (millis() - start)/1000;
  surface.setTitle("Filler: image filled in " + elapsed + " seconds");    
  cursor(ARROW);
}

void randomFill()
{
  for(int i = Lpanel+1; i < width - Rpanel; i += fillStep)
  {
    for(int j = 0; j < height; j += fillStep)
    {
      int cx = (int) random(1071, 1190);
      int cy = (int) random(70, 742);
      int cc = get(cx,cy);
      // do not select black or white color
      while ((cc == -16777216) || (cc == -1)) { cc = get((int) random(1071, 1190), (int) random(70, 742)); }
      floodFill(img, i, j, cc);  
    }
  }
}

void fillIMG2()
{ 
  cursor(WAIT);
  surface.setTitle("Filler: filling image with simmetry...");      
  start = millis();  
  randomFill2();
  elapsed = (millis() - start)/1000;
  surface.setTitle("Filler: simmetry image filled in " + elapsed + " seconds");    
  cursor(ARROW);
}

//symmetry fill
void randomFill2()
{
  for(int i = Lpanel+1; i < width/2; i += fillStep)
  {
    for(int j = 0; j < height; j += fillStep)
    {
      int cx = (int) random(1071, 1190);
      int cy = (int) random(70, 742);
      int cc = get(cx,cy);
      // do not select black or white color
      while ((cc == -16777216) || (cc == -1)) { cc = get((int) random(1071, 1190), (int) random(70, 742)); }
      floodFill(img, i, j, cc);  
      //point(i,j);      
      floodFill(img, width - i, j, cc);
      //point(width - i, j);
    }
  }
  // fill along the middle line
  for(int j = 0; j < height; j += fillStep)
  {
    int cx = (int) random(1071, 1190);
    int cy = (int) random(70, 742);
    int cc = get(cx,cy);
    // do not select black or white color
    while ((cc == -16777216) || (cc == -1)) { cc = get((int) random(1071, 1190), (int) random(70, 742)); }
    floodFill(img, width/2, j, cc);  
    //point(width/2, j);
  }  
  
  //noLoop();
}

void fillIMG1()
{ 
  cursor(WAIT);
  surface.setTitle("Filler: filling white of image...");      
  start = millis();  
  randomFill1();
  elapsed = (millis() - start)/1000;
  surface.setTitle("Filler: image filled in " + elapsed + " seconds");    
  cursor(ARROW);
}

// fill only white area
void randomFill1()
{
  loadPixels();
  // Begin our loop for every pixel in the image
  for (int x = Lpanel; x < width-Rpanel; x+=1)
  {
    for (int y = 0; y < height; y+=1)
    {
      int loc = x + y*img.width;
      int c = pixels[loc];
      // if color is White
      if (c == -1)
      {
         int cx = (int) random(1071, 1190);
         int cy = (int) random(70, 742);
         int cc = get(cx,cy);
        // do not select black or white color
         while ((cc == -16777216) || (cc == -1)) { cc = get((int) random(1071, 1190), (int) random(70, 742)); }
        //int cc = (color) random(#000000);
        floodFill(img, x, y, cc);        
      }
    }
    //println(x);    
  }
//  updatePixels();
}
