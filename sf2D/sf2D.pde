// superFormula2D.pde
// Curve Graphing
// by cameyo 2016
// processing 3.x
// superformula 2D LaTex
// r(t)=(|\frac{cos(\frac{m_{2}t}{4})}{k_{2}}|^{n_{2}}+|\frac{sin(\frac{m_{3}t}{4})}{k_{3}}|^{n_{3}})^{\frac{-1}{n_{1}}}

// Image of Curve's Formulae
PImage[] curveImg = new PImage[4];
// point of curve
float x, y, z;
// angle of curve
float t;
// resolution
float step;
float st;
// center of curve
float xc, yc;
// radius
float r, R;
//distance between radius
float h;
// parameters
float a, b, c, d;
// parameters (angle)
float p1, p2, p3, p4;
// parameters (power)
float i, j, m, n;

//superformula2D
float k2, k3, m2, m3, n1, n2, n3;
float sf;

// max framerate
int maxFrame;
// palette color
color[] base = {#002b36, #073642, #586e75, #657b83, #839496, #93a1a1, #eee8d5, #fdf6e3};
color[] hues = {#b58900, #cb4b16, #dc322f, #d33682, #6c71c4, #268bd2, #2aa198, #859900};
// current color
color col;
// current alpha
int alfa;
// curve number
int curveNum;
// curve names
String[] curveName = { "Generic", "Hypotrochoid", "Epitrochoid", "SuperFormula" };
// GUI font
PFont font;
// GUI panel height
int panelH;
// palette dimension and positions
int side;
int px;
int py;
// background color
color backCol;
// GUI button amd spinners
Button btnSAVE, btnGO, btnCLEAR, btnRND;
Button btnCUR0, btnCUR1, btnCUR2, btnCUR3;
Spinner spnA, spnB, spnC, spnD;
Spinner spnP1, spnP2, spnP3, spnP4;
Spinner spnI, spnJ, spnM, spnN;
Spinner spnR, spnr, spnH;
Spinner spnK2, spnK3, spnM2, spnM3, spnN1, spnN2, spnN3, spnSF;
SpinBound spnSTEP;
// start/stop draw
boolean start;
// clear canvas ?
boolean clear;
// Update GUI ?
boolean changed;
// save color toggle
boolean saved;

void setup()
{
  size(1200, 800);
  smooth();
  frameRate(5000);
  font = createFont("Calibri Bold", 14);
  textFont(font);
  textAlign(LEFT);
//  textSize(14);
  // GUI panel
  panelH = 100;
  side = 20;
  px = width - side*8 - side/2;
  py = height-panelH + side/2;
  // Images of formulae
  curveImg[0] = loadImage("Generic.png");
  curveImg[1] = loadImage("Hypotrochoid.png");
  curveImg[2] = loadImage("Epitrochoid.png");
  curveImg[3] = loadImage("Superformula.png");
  // GUI buttons
  btnGO = new Button(px, py+50, 60, 30, "go", "START", color(100), color(#000000));
  btnSAVE = new Button(px+70, py+60, 40, 20, "saveIMG", "Save", color(100), color(#000000));
  btnCLEAR = new Button(px+120, py+60, 40, 20, "clearCanvas", "New", color(100), color(#000000));
  btnCUR0 = new Button(310, height-panelH+10, 90, 16, "curve0", "Generic", color(100), color(#000000));
  btnCUR1 = new Button(310, height-panelH+32, 90, 16, "curve1", "Hypotrochoid", color(100), color(#000000));
  btnCUR2 = new Button(310, height-panelH+54, 90, 16, "curve2", "Epitrochoid", color(100), color(#000000));
  btnCUR3 = new Button(310, height-panelH+76, 90, 16, "curve3", "SuperFormula", color(100), color(#000000));  
  btnRND = new Button(790, height-30, 20, 20, "randomParameters", "?", color(100), color(#000000));

  // GUI spinners
  spnA = new Spinner(415, height-panelH+20, 80, 14, 91, 1, color(128), "update_A");
  spnB = new Spinner(505, height-panelH+20, 80, 14, 177, 1, color(128), "update_B");
  spnC = new Spinner(595, height-panelH+20, 80, 14, 111, 1, color(128), "update_C");
  spnD = new Spinner(685, height-panelH+20, 80, 14, 73, 1, color(128), "update_D");

  spnP1 = new Spinner(415, height-panelH+48, 80, 14, 8, 1, color(128), "update_P1");
  spnP2 = new Spinner(505, height-panelH+48, 80, 14, 6, 1, color(128), "update_P2");
  spnP3 = new Spinner(595, height-panelH+48, 80, 14, 6, 1, color(128), "update_P3");
  spnP4 = new Spinner(685, height-panelH+48, 80, 14, 8, 1, color(128), "update_P4");

  spnI = new Spinner(415, height-panelH+76, 80, 14, 1, 1, color(128), "update_I");
  spnJ = new Spinner(505, height-panelH+76, 80, 14, 2, 1, color(128), "update_J");
  spnM = new Spinner(595, height-panelH+76, 80, 14, 1, 1, color(128), "update_M");
  spnN = new Spinner(685, height-panelH+76, 80, 14, 2, 1, color(128), "update_N");

  spnR = new Spinner(435, height-panelH+44, 80, 14, 77, 1, color(128), "update_R");
  spnr = new Spinner(525, height-panelH+44, 80, 14, 98, 1, color(128), "update_r");
  spnH = new Spinner(615, height-panelH+44, 80, 14, 81, 1, color(128), "update_H");
  
  spnK2 = new Spinner(415, height-panelH+20, 80, 14, 1, 1, color(128), "update_K2");
  spnK3 = new Spinner(505, height-panelH+20, 80, 14, 1, 1, color(128), "update_K3");
  spnM2 = new Spinner(415, height-panelH+48, 80, 14, 6, 1, color(128), "update_M2");
  spnM3 = new Spinner(505, height-panelH+48, 80, 14, 6, 1, color(128), "update_M3");
  spnN2 = new Spinner(415, height-panelH+76, 80, 14, 4, 1, color(128), "update_N2");
  spnN3 = new Spinner(505, height-panelH+76, 80, 14, 17, 1, color(128), "update_N3");
  spnN1 = new Spinner(595, height-panelH+76, 80, 14, 3, 1, color(128), "update_N1");  
  spnSF = new Spinner(685, height-panelH+76, 80, 14, 50, 1, color(128), "update_SF");
  
  spnSTEP = new SpinBound(width-270, height-24, 60, 14, 4, 1, 1, 10, color(128), "setStep");

  // backgrond color
  backCol=(#002b36);

  // initialize variables
  init();
}

void init()
{
  background(backCol);
  maxFrame=0;
  xc=(width)/2; 
  yc=(height-panelH)/2;
  // set parameters
  t = 0.0;
  step = 0.01;
  st = 4;
  R = 77.0;  r = 98.0;  h = 81.0;
  a = 91.0;  b = 177;  c = 111.0;  d = 73.0;
  i = 1.0;  j = 2.0;  m = 1.0;  n = 2.0;
  p1 = 8.0;  p2 = 6.0;  p3 = 6.0;  p4 = 8.0;
  k2 = 1.0; k3 = 1.0;
  m2 = 6.0; m3 = 6.0;
  n2 = 4.0; n3 = 17.0; n1 = 3.0;
  sf = 50.0;

  // curve color
  noStroke();
  col = hues[int(random(0, 8))];
  // set alpha
  alfa = 255;
  //fill(color(col,alfa));

  // start draw ?
  start=false;
  // clear canvas?
  clear = false;
  // update GUI ?
  changed = true;
  // saved
  saved = false;
  // curve number
  curveNum = 0;
}

void draw()
{
  if ((clear)||(changed))
  { 
    if (clear) { 
      background(backCol);
    }
    drawGUI();
    clear = false;
    changed = false;
  }    

  // set curve color
  fill(col);
  // set alpha
  //fill(color(col,alfa));  
  // select curve
  switch (curveNum)
  {
  case 0: 
    generic(xc, yc);    
    break;
  case 1: 
    hypotrochoid(xc, yc); 
    break;
  case 2: 
    epitrochoid(xc, yc);  
    break;
  case 3: 
    super2D(xc, yc);    
    break;    
  }
  // draw current curve point
  if (start)
  {
    // if (colRND) 
    // { 
      // fill(hues[(int)random(0,8)]);
    // }  
    ellipse(x, y, 1, 1);
    //point(x,y,z);
    // increment angle
    t += step;
    //println(x,y,t);
  }
}

void keyPressed()
{
  // start/stop draw
  if (key==' ') { go(); }

  // new canvas
  if (key=='z'||key=='Z') { clearCanvas(); }

  // save image and parameters
  if (key=='s'||key=='S') { saveIMG(); }

  // change curve type
  if (key == '0') { curve0(); }
  if (key == '1') { curve1(); }
  if (key == '2') { curve2(); }
  if (key == '3') { curve3(); }  

  // change parameters value
  if (key == 'a') { a--; spnA.setValue(a); changed = true; }
  if (key == 'A') { a++; spnA.setValue(a); changed = true; }
  if (key == 'b') { b--; spnB.setValue(b); changed = true; }
  if (key == 'B') { b++; spnB.setValue(b); changed = true; }
  if (key == 'c') { c--; spnC.setValue(c); changed = true; }
  if (key == 'C') { c++; spnC.setValue(c); changed = true; }
  if (key == 'd') { d--; spnD.setValue(d); changed = true; }
  if (key == 'D') { d++; spnD.setValue(d); changed = true; }
  if (key == 'i') { i--; spnI.setValue(i); changed = true; }
  if (key == 'I') { i++; spnI.setValue(i); changed = true; }
  if (key == 'j') { j--; spnJ.setValue(j); changed = true; }
  if (key == 'J') { j++; spnJ.setValue(j); changed = true; }
  if (key == 'm') { m--; spnM.setValue(m); changed = true; }
  if (key == 'M') { m++; spnM.setValue(m); changed = true; }
  if (key == 'n') { n--; spnN.setValue(n); changed = true; }
  if (key == 'N') { n++; spnN.setValue(n); changed = true; }
  // R, r and h parameters
  if (key == 'q') { R--; spnR.setValue(R); changed = true; }
  if (key == 'Q') { R++; spnR.setValue(R); changed = true; }
  if (key == 'w') { r--; spnr.setValue(r); changed = true; }
  if (key == 'W') { r++; spnr.setValue(r); changed = true; }
  if (key == 'h') { h--; spnH.setValue(h); changed = true; }
  if (key == 'H') { h++; spnH.setValue(h); changed = true; }
  
  // random parameters
  if (key=='x'||key=='X') { randomParameters(); }

  // show current framerate
  if (key=='f'||key=='F')
  {
    //println("framerate");
    String FM = nf(frameRate, 0, 0);
    surface.setTitle(FM);
  }

  // print parameters
  if (key=='p'||key=='P') { showParam(); }
}

void mouseMoved()
{
  if (!start)
  {
    if (mouseY < height-panelH) { cursor(CROSS); } 
    else { cursor(ARROW); }
  }
}

void mousePressed()
{
  int mx, my;
  mx = mouseX;
  my = mouseY;
  //println(mx,my);

  // Check buttons
  btnSAVE.onClick();
  btnGO.onClick();
  btnCLEAR.onClick();
  btnCUR0.onClick();
  btnCUR1.onClick();
  btnCUR2.onClick();
  btnCUR3.onClick();  
  btnRND.onClick();
  
  // Check spinners
  spnSTEP.onClick();
  
  // spinners for generic curve (0)
  if (curveNum==0)
  {
    spnA.onClick();  spnB.onClick();  spnC.onClick();  spnD.onClick();
    spnP1.onClick();  spnP2.onClick();  spnP3.onClick();  spnP4.onClick();
    spnI.onClick();  spnJ.onClick();  spnM.onClick();  spnN.onClick();
  }
  // spinners for hypotrochoid or epitrochoid curve (1) (2)
  if ((curveNum==1)||(curveNum==2))
  {
    spnR.onClick();  spnr.onClick();  spnH.onClick();
  }
  // spinners for superformula (3)
  if (curveNum==3)
  {
    spnK2.onClick();  spnK3.onClick();  
    spnM2.onClick();  spnM3.onClick();
    spnN2.onClick();  spnN3.onClick();  spnN1.onClick();
    spnSF.onClick();
  }  

  // click on palette colors
  if ((mx > px)&&(mx < px+side*8)&&(my > py)&&(my < py+2*side))
  {
    col = get(mx, my);
    changed = true;
    //println("color");
  }

  // set center of curve
  if ((!start)&&(my<height-panelH))
  {
    changed = true;
    xc = mouseX;
    yc = mouseY;
    //println("center", xc, yc);
  }
}

// Start/Stop button method
void go()
{
  changed = true;
  //if (start) { println("stop."); } 
  //else { println("start..."); }
  start=!start;
}
// New button method
void clearCanvas()
{
  if (!start)
  {
    clear = true;
    changed = true;
    backCol=col;
    t = 0.0;
    xc = (width-panelH) >> 1;
    yc = (height-panelH) >> 1;
    while (col==backCol)
    {
      col = hues[int(random(0, 8))];
    }
    start = false;
    //println("New");
  }
}
// Save button method
void saveIMG()
{
  String filename;
  changed = true;
  filename = newFilename();
  // save image
  save(filename+".png");
  // save text file
  String[] txt1 = new String[4];
  String[] txt2 = new String[2];
  if (curveNum==0)
  {
    txt1[0] = curveName[curveNum];    
    txt1[1] = "a=" + nf(a,0,0) + " b=" + nf(b,0,0) + " c=" + nf(c,0,0)+ " d=" + nf(d,0,0);
    txt1[2] = "p1=" + nf(p1, 0, 0) + " p2=" + nf(p2, 0, 0) + " p3=" + nf(p3, 0, 0) + " p4=" + nf(p4, 0, 0);
    txt1[3] = "i=" + nf(i, 0, 0) + " j=" + nf(j, 0, 0) + " m=" + nf(m, 0, 0) + " n=" + nf(n, 0, 0);
    //saveStrings(filename+".txt", txt1);
  }
  else if (curveNum == 1 || curveNum == 2)
  {
    txt2[0] = curveName[curveNum];    
    txt2[1] = "R=" + nf(R, 0, 0) + " r=" + nf(r, 0, 0) + " h=" + nf(h, 0, 0);
    //saveStrings(filename+".txt", txt2);
  }
  else if (curveNum == 3)
  {
    txt1[0] = curveName[curveNum];    
    txt1[1] = "k2=" + nf(k2,0,0) + " k3=" + nf(k3,0,0);
    txt1[2] = "m2=" + nf(m2,0,0) + " m3=" + nf(m3,0,0);
    txt1[3] = "n2=" + nf(n2,0,0) + " n3=" + nf(n3, 0, 0) + " n1=" + nf(n1, 0, 0);
    //saveStrings(filename+".txt", txt1);
  }  
  saved= (!saved);
  //println("Saved.");
}
//Curve buttons methods
void curve0()
{
  changed = true;
  curveNum = 0;
  t = 0.0;
  //println(curveName[curveNum], "-", curveNum);
}
void curve1()
{
  changed = true;
  curveNum = 1;
  t = 0.0;
  //println(curveName[curveNum], "-", curveNum);
}
void curve2()
{
  changed = true;
  curveNum = 2;
  t = 0.0;
  //println(curveName[curveNum], "-", curveNum);
}
void curve3()
{
  changed = true;
  curveNum = 3;
  t = 0.0;
  //println(curveName[curveNum], "-", curveNum);
}
// Spinners method
void update_A()
{
  changed = true;
  a = spnA.getValue();
  println("a=", a);
}
void update_B()
{
  changed = true;
  b = spnB.getValue();
  println("b=", b);
}
void update_C()
{
  changed = true;
  c = spnC.getValue();
  println("c=", c);
}
void update_D()
{
  changed = true;
  d = spnD.getValue();
  println("d=", d);
}

void update_P1()
{
  changed = true;
  p1 = spnP1.getValue();
  println("p1=", p1);
}
void update_P2()
{
  changed = true;
  p2 = spnP2.getValue();
  println("p2=", p2);
}
void update_P3()
{
  changed = true;
  p3 = spnP3.getValue();
  println("p3=", p3);
}
void update_P4()
{
  changed = true;
  p4 = spnP4.getValue();
  println("p4=", p4);
}
void update_I()
{
  changed = true;
  i = spnI.getValue();
  println("i=", i);
}
void update_J()
{
  changed = true;
  j = spnJ.getValue();
  println("j=", j);
}
void update_M()
{
  changed = true;
  m = spnM.getValue();
  println("m=", m);
}
void update_N()
{
  changed = true;
  n = spnN.getValue();
  println("n=", n);
}

void update_R()
{
  changed = true;
  R = spnR.getValue();
  println("R=", R);
}
void update_r()
{
  changed = true;
  r = spnr.getValue();
  println("r=", r);
}
void update_H()
{
  changed = true;
  h = spnH.getValue();
  println("h=", h);
}

void update_K2()
{
  changed = true;
  k2 = spnK2.getValue();
  println("k2=", k2);
}

void update_K3()
{
  changed = true;
  k3 = spnK3.getValue();
  println("k3=", k3);
}

void update_M2()
{
  changed = true;
  m2 = spnM2.getValue();
  println("m2=", m2);
}

void update_M3()
{
  changed = true;
  m3 = spnM3.getValue();
  println("m3=", m3);
}

void update_N2()
{
  changed = true;
  n2 = spnN2.getValue();
  println("n2=", n2);
}

void update_N3()
{
  changed = true;
  n3 = spnN3.getValue();
  println("n3=", n3);
}

void update_N1()
{
  changed = true;
  n1 = spnN1.getValue();
  println("n1=", n1);
}

void update_SF()
{
  changed = true;
  sf = spnSF.getValue();
  println("sf=", sf);
}

void randomParameters()
{
  changed = true;
  if (curveNum == 0)
  {
    a = int(random(-100, 101));
    spnA.setValue(a);
    b = int(random(-100, 101));
    spnB.setValue(b);
    c = int(random(-100, 101));
    spnC.setValue(c);
    d = int(random(-100, 101));
    spnD.setValue(d);

    p1 = int(random(1, 11));
    spnP1.setValue(p1);
    p2 = int(random(1, 11));
    spnP2.setValue(p2);
    p3 = int(random(1, 11));
    spnP3.setValue(p3);
    p4 = int(random(1, 11));
    spnP4.setValue(p4);

    i = int(random(1, 9));
    spnI.setValue(i);
    j = int(random(1, 9));
    spnJ.setValue(j);
    m = int(random(1, 9));
    spnM.setValue(m);
    n = int(random(1, 9));
    spnN.setValue(n);
  }
  if ((curveNum == 1)||(curveNum == 2))
  {   
    R = int(random(50, 101));
    spnR.setValue(R);
    r = int(random(50, 101));
    spnr.setValue(r);
    h = int(random(50, 101));
    spnH.setValue(h);
  }
  if (curveNum == 3)
  {   
    k2 = 1;
    spnK2.setValue(k2);
    k3 = 1;
    spnK3.setValue(k3);
    
    m2 = int(random(2, 10));
    spnM2.setValue(m2);
    m3 = m2/(int)random(1,8);
    spnM3.setValue(m3);
    
    n2 = int(random(1, 10));
    spnN2.setValue(n2);
    n3 = n2/(int)random(1,8);
    spnN3.setValue(n3);
    n1 = int(random(1, 10));
    spnN1.setValue(n1);
    
    sf = int(random(10, 50));
    spnSF.setValue(sf);
    
  }  
}

void setStep()
{
  changed = true;
  st = spnSTEP.getValue();
  if (st == 1) { step = 1; }  
  if (st == 2) { step = 0.1; }
  if (st == 3) { step = 0.05; }
  if (st == 4) { step = 0.01; }
  if (st == 5) { step = 0.005; }
  if (st == 6) { step = 0.001; }
  if (st == 7) { step = 0.0005; }
  if (st == 8) { step = 0.0001; }
  if (st == 9) { step = 0.00001; }
  if (st == 10) { step = 0.00005; }
  //println(st,step);
}  
  
void showParam()
{
  println("R="+R, "r="+r, "h="+h);
  println("a="+a, "b="+b, "c="+c, "d="+d);
  println("p1="+p1, "p2="+p2, "p3="+p3, "p4="+p4);
  println("i="+i, "j="+j, "m="+m, "n="+n);
  println("k2="+k2, "k3="+k3);  
  println("m2="+m2, "m3="+m3);
  println("n2="+n2, "n3="+n3, "n1="+n1);  
  println("sf="+sf);
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