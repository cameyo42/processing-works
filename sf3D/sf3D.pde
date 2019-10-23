// SuperFormula3D
// for processing 3.x
// by cameyo
// SuperFormula Latex
// r(t)=(|\frac{1}{a}{cos(\frac{mt}{4})}|^{n_{2}}+|\frac{1}{b}{sin(\frac{mt}{4})}|^{n_{3}})^{\frac{-1}{n_{1}}}

import peasy.*;
// 3D viewer
 PeasyCam cam;
// Image of math SuperFormula
PImage sfImg;
// cartesian coordinates of points
float x, y, z;  
// parameters superformula 1
float r, r1, r2;
float m1;
float n11, n12, n13;
float a1, b1;
// parameters superformula 2
float m2;
float n21, n22, n23;
float a2, b2;
// scale factor
float factor; 
// canvas center
float xc,yc;
// step angles value (resolution)
float step;
float st;
// latitude
float minLat;
float maxLat;
//longitude
float minLon;
float maxLon;
// background color
color backCol;
// palette color
color[] base = {#002b36, #073642, #586e75, #657b83, #839496, #93a1a1, #eee8d5, #fdf6e3};
color[] hues = {#b58900, #cb4b16, #dc322f, #d33682, #6c71c4, #268bd2, #2aa198, #859900};
// current colors
color col, colWire, colFlat, colPo3D;
int alfa;
// GUI font
PFont font;
// GUI panel height
int panelH;
// palette dimension and positions
int side;
int px;
int py;
// Buttons 
Button btnSAVE, btnRND;
// Spinner
SpinBound spnSTEP;
Spinner spnFACT;
Spinner spnA1, spnB1, spnM1, spnN11, spnN12, spnN13;
Spinner spnA2, spnB2, spnM2, spnN21, spnN22, spnN23; 
//Checkbox
Checkbox cbFlat, cbWire, cbPo3D;
Checkbox cbLight;
// rendering type
boolean flat;
boolean wireframe;
boolean po3D;
boolean dynLight;

void setup()
{
  //size(1000,800,P3D);
  //size(1000,900,P3D);
size(1200,1000,P3D);  
  noSmooth();
  background(0);
  font = createFont("Calibri Bold", 14);
  textFont(font);
  textAlign(LEFT);
  // Image of formula
  sfImg = loadImage("sf.png");  
  // GUI panel
  panelH = 100;
  side = 20;
  px = width - side*8 - side/2;
  py = height - panelH + side/2;  
  // GUI buttons
  btnSAVE = new Button(px, py+44, 160, 20, "saveIMG", "Save image", color(128), color(0));
  btnRND = new Button(806, height-panelH+20, 20, 50, "randomObject", "?", color(128), color(0));
  // GUI spinners
  spnSTEP = new SpinBound(366, height-22, 64, 16, 4, 1, 1, 9, color(128), "setStep");  
  spnFACT = new Spinner(840, height-panelH+20, 100, 16, 25, 1, color(128), "setFactor");
  // sf (1)
  spnA1 = new Spinner(295, height-panelH+20, 80, 16, 91, 1, color(128), "update_A1");
  spnB1 = new Spinner(380, height-panelH+20, 80, 16, 177, 1, color(128), "update_B1");
  spnM1 = new Spinner(465, height-panelH+20, 80, 16, 111, 1, color(128), "update_M1");
  spnN11 = new Spinner(550, height-panelH+20, 80, 16, 8, 1, color(128), "update_N11");
  spnN12 = new Spinner(635, height-panelH+20, 80, 16, 6, 1, color(128), "update_N12");
  spnN13 = new Spinner(720, height-panelH+20, 80, 16, 6, 1, color(128), "update_N13");
  // sf (2)
  spnA2 = new Spinner(295, height-panelH+54, 80, 16, 91, 1, color(128), "update_A2");
  spnB2 = new Spinner(380, height-panelH+54, 80, 16, 177, 1, color(128), "update_B2");
  spnM2 = new Spinner(465, height-panelH+54, 80, 16, 111, 1, color(128), "update_M2");
  spnN21 = new Spinner(550, height-panelH+54, 80, 16, 8, 1, color(128), "update_N21");
  spnN22 = new Spinner(635, height-panelH+54, 80, 16, 6, 1, color(128), "update_N22");
  spnN23 = new Spinner(720, height-panelH+54, 80, 16, 6, 1, color(128), "update_N23");

  // GUI checbox
  cbFlat = new Checkbox(490, height-panelH+80, 12, 12, "Flat", true, color(0), color(128));
  cbWire = new Checkbox(540, height-panelH+80, 12, 12, "Wire", false, color(0), color(128));
  cbPo3D = new Checkbox(596, height-panelH+80, 12, 12, "Point", false, color(0), color(128));
  cbLight = new Checkbox(700, height-panelH+80, 12, 12, "dynamic Light", false, color(0), color(128));
  
  // backgrond color
  backCol = (#002b36);
  // Initialize variables  
  init();
  // Initialize 3D viewer
  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(2000);  
  //System.err.println("setup");  
}

void init()
{
  xc=(width)/2; 
  yc=(height-panelH)/2;
  // sf (1)
  a1 = 1.0;   spnA1.setValue(a1);
  b1 = 4.0;   spnB1.setValue(b1);
  m1 = 6.0;   spnM1.setValue(m1);
  n11 = 4.0;  spnN11.setValue(n11);
  n12 = 2.0;  spnN12.setValue(n12);
  n13 = 3.0;  spnN13.setValue(n13);
  // sf (2)
  a2 = 1.0;   spnA2.setValue(a2);
  b2 = 1.0;   spnB2.setValue(b2);
  m2 = 6.0;   spnM2.setValue(m2);
  n21 = 4.0;  spnN21.setValue(n21);
  n22 = 2.0;  spnN22.setValue(n22);
  n23 = 3.0;  spnN23.setValue(n23);
  
  minLat = -PI/2.0;
  maxLat = PI/2.0;
  // longitude
  minLon = -PI;
  maxLon = PI;  
  factor = 25.0;  spnFACT.setValue(factor);
  step = PI/60.0; // must be divisible by 6
  st = 4;
  flat = true;
  wireframe = false;
  po3D = false;
  dynLight = false;
  col = (#dc322f);
  alfa = 25;
  colWire = color(#93a1a1,alfa);
  colFlat = (#eee8d5);
  colPo3D = (#dc322f);
}

void draw()
{
  background(backCol);
  // draw GUI 
  cam.beginHUD(); 
  drawGUI();
  cam.endHUD();
  // set lights
  if (dynLight)
  {
    ambientLight(128,128,128);
    float lY = (mouseY / float(height) - 0.5) * 2;
    float lX = (mouseX / float(width) - 0.5) * 2;
    directionalLight(128, 128, 128, -lX, -lY, -1);   
    directionalLight(128, 128, 128, -lX, -lY, 1);         
  }
  else
  {
    lights();
    directionalLight(128,128,128,0,0,1);    
  }

  // Draw SuperFormula3D
  if ((flat) || (wireframe))
  {
    super3Drender();
  }
  else if (po3D)
  {  
    //set 3D point color
    stroke(colPo3D);
    fill(colPo3D);  
    super3Dpoint();
  }
}

// MOUSE WHEEL
void mouseWheel(MouseEvent event) 
{
  float e = event.getCount();
  //println(e);
  //factor = factor - 2*e;
  factor = factor - e;
  spnFACT.setValue(factor); setFactor();  
}  

// MOUSE PRESSED
void mousePressed()
{
  int mx, my;
  mx = mouseX;
  my = mouseY;
  // check click on buttons
  btnSAVE.onClick();  
  btnRND.onClick();
  // check click on spinners
  spnSTEP.onClick();
  spnFACT.onClick();
  spnA1.onClick(); spnB1.onClick(); spnM1.onClick(); spnN11.onClick(); spnN12.onClick(); spnN13.onClick();
  spnA2.onClick(); spnB2.onClick(); spnM2.onClick(); spnN21.onClick(); spnN22.onClick(); spnN23.onClick();
  // check click on checkbox
  cbFlat.onClick(); 
  flat = cbFlat.s;
  cbWire.onClick(); 
  wireframe = cbWire.s;
  cbPo3D.onClick();
  po3D = cbPo3D.s;
  cbLight.onClick();
  dynLight = cbLight.s;
  
  // check click on palette colors
  if ((mx > px)&&(mx < px+side*8)&&(my > py)&&(my < py+2*side))
  { //println("color");
    col = get(mx, my);
    if (flat) { colFlat = col; }
    else if (wireframe) { colWire = color(col,alfa); }
    else if (po3D) { colPo3D = col; }
  }
}   

// KEY PRESSED
void keyPressed() 
{
  if (key == 'R')  { st = constrain(st+1,1,9); spnSTEP.setValue(st); setStep();}
  if (key == 'r')  { st = constrain(st-1,1,9); spnSTEP.setValue(st); setStep();}
  if (key == 's')  { saveIMG(); }
  if (key == 'f')  { flat = !flat; cbFlat.s = !cbFlat.s; }  
  if (key == 'w')  { wireframe = !wireframe; cbWire.s = !cbWire.s; }    
  if (key == 'p')  { po3D = !po3D; cbPo3D.s = !cbPo3D.s; }
  if (key == 'l')  { dynLight = !dynLight; cbLight.s = !cbLight.s; }
  if (key == '+')  { factor = factor + 4; }
  if (key == '-')  { factor = factor - 4; }  
  if (key == '?')  { randomObject(); }
}

// POINT RENDER
void super3Dpoint()
{ 
  // draw the superformula using spherical coordinates
  float theta, phi;
  for (theta = minLon; theta < maxLon; theta += step) 
  { // compute by theta
    for (phi = minLat; phi < maxLat - step ; phi += step) 
    { // compute by phi
      // superformula3D (1)
      r1 =  pow( (pow(abs(cos(m1*theta/4.0)/a1), n12) + pow(abs(sin(m1*theta/4)/b1), n13)), -1.0/n11);
      // superformula3D (2)
      r2 =  pow( (pow(abs(cos(m2*phi/4.0)/a2),   n22) + pow(abs(sin(m2*phi/4)/b2), n23)),   -1.0/n21);
      // convert from spherical to cartesian coordinates      
      x = factor * r1 * cos(theta) * r2 * cos(phi); 
      y = factor * r1 * sin(theta) * r2 * cos(phi);
      z = factor * r2 * sin(phi);
      point(x, y, z);
      //println(x,y,z);
    }
  }
}

// FLAT/WIREFRAME RENDER
void super3Drender()
{
  // set rendering colors
  if (flat) { fill(colFlat); }
  else { noFill(); }
  if (wireframe) { stroke(colWire); }
  else { noStroke(); }
    
  beginShape(QUADS);
  float theta, phi;
  for (theta = minLon; theta < maxLon; theta += step) 
  { 
    for (phi = minLat; phi < maxLat - step ; phi += step) 
    {
      // quad
      pVertex(calcPoint(theta, phi));
      pVertex(calcPoint(theta + step, phi));
      pVertex(calcPoint(theta + step, phi + step));
      pVertex(calcPoint(theta, phi + step));
    }
  }
  endShape();
}
 
// call vertex with the pvector
void pVertex(PVector p) 
{
  vertex(p.x, p.y, p.z);
}
 
// calculate the points, return in a pvector
PVector calcPoint(float theta, float phi) 
{
  // superformula3D (1)
  float r1 =  pow( (pow(abs(cos(m1*theta/4.0)/a1), n12) + pow(abs(sin(m1*theta/4)/b1), n13)), -1.0/n11);
  // superformula3D (2)
  float r2 =  pow( (pow(abs(cos(m2*phi/4.0)/a2), n22) + pow(abs(sin(m2*phi/4)/b2), n23)), -1.0/n21);
  float x = factor * r1 * cos(theta) * r2 * cos(phi); 
  float y = factor * r1 * sin(theta) * r2 * cos(phi);
  float z = factor * r2 * sin(phi);
  return new PVector(x, y, z);
}

// Save button method
void saveIMG()
{
  String filename;
  filename = newFilename();
  save(filename+".png");
  //println("Saved.");
}

// set resolution
void setStep()
{
  st = spnSTEP.getValue();
  if (st == 1) { step = PI/24.0; }  
  if (st == 2) { step = PI/36.0; }
  if (st == 3) { step = PI/48.0; }
  if (st == 4) { step = PI/60.0; }
  if (st == 5) { step = PI/72.0; }
  if (st == 6) { step = PI/84.0; }
  if (st == 7) { step = PI/120.0; }
  if (st == 8) { step = PI/162.0; }
  // if (st == 9) { step = PI/192.0; }  
  if (st == 9) { step = PI/384.0; }
  println(st,step);
}  

// Spinners method
void setFactor() { factor = spnFACT.getValue(); println("factor=", factor); }
// sf (1)
void update_A1() { a1 = spnA1.getValue(); println("a1=", a1); }
void update_B1() { b1 = spnB1.getValue(); println("b1=", b1); }
void update_M1() { m1 = spnM1.getValue(); println("m1=", m1); }
void update_N11() { n11 = spnN11.getValue(); println("n11=", n11); }
void update_N12() { n12 = spnN12.getValue(); println("n12=", n12); }
void update_N13() { n13 = spnN13.getValue(); println("n13=", n13); }
// sf (2)
void update_A2() { a2 = spnA2.getValue(); println("a2=", a2); }
void update_B2() { b2 = spnB2.getValue(); println("b2=", b2); }
void update_M2() { m2 = spnM2.getValue(); println("m2=", m2); }
void update_N21() { n21 = spnN21.getValue(); println("n21=", n21); }
void update_N22() { n22 = spnN22.getValue(); println("n22=", n22); }
void update_N23() { n23 = spnN23.getValue(); println("n23=", n23); }


// generate random object
void randomObject()
{
  a1 = 1;    spnA1.setValue(a1);
  b1 = 1;    spnB1.setValue(b1);
  m1 = (int)random(1,11);   spnM1.setValue(m1);
  n11 = (int)random(1,11);  spnN11.setValue(n11);
  n12 = (int)random(1,21);  spnN12.setValue(n12);
  n13 = (int)random(1,21);  spnN13.setValue(n13);
  // sf (2)
  a2 = 1;    spnA2.setValue(a2);
  b2 = 1;    spnB2.setValue(b2);
  m2 = (int)random(1,11);   spnM2.setValue(m2);
  n21 = (int)random(1,11);  spnN21.setValue(n21);
  n22 = (int)random(1,21);  spnN22.setValue(n22);
  n23 = (int)random(1,21);  spnN23.setValue(n23);
  //println("random");
}

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
  out=name+"-"+y+"-"+nf(m, 2)+"-"+nf(d, 2)+"."+nf(hh, 2)+"-"+nf(mm, 2)+"-"+nf(ss, 2);
  return out;
}
