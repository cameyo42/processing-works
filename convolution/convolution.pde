// convolution by cameyo 2015
// processing 3.x
// based on Convolution by Daniel Shiffman
// Applies a convolution matrix to (a portion of) an image.
// Move mouse to apply filter to different parts of the image.
// Open and save image.
// "Flamenco" image by borhan (zbrush software)
// http://www.zbrushcentral.com/showthread.php?187934-Flamenco

import java.util.Calendar;
// font used
PFont myFont;
// image loaded
PImage img;
// all window switch
boolean allWindow = false;
// quad filter side lenght
int w = 160;
//buttons
Button[] buttons = new Button[12];
//spinners
Spinner[] spinners = new Spinner[25];
//Chekcbox
Checkbox cb;
//background color
color backC = color(60,60,60);
// It's possible to convolve the image with many different
// matrices to produce different effects.
// This is a NEUTRAL filter.
float[][] matrix = { { 0,   0,   0,   0,   0,   },
                     { 0,   0,   0,   0,   0,   },
                     { 0,   0,   1,   0,   0,   },
                     { 0,   0,   0,   0,   0,   },
                     { 0,   0,   0,   0,   0,   } };
// correction parameters
float bias = 0.0;
float factor = 1.0;

void setup() {
  size(640, 470);
  myFont  = createFont("Calibri Bold", 12);
  textFont(myFont);
  //background(backC);
  // load image
  img = loadImage("data.png");
  // create buttons
  int ys = height-100;
  buttons[0] = new Button( 10, ys, 60, 18,      "btn00Method", "Neutral", color(128), color(160), color(200), color(255,128,0) );
  buttons[1] = new Button( 76, ys, 60, 18,      "btn01Method", "Sharpen", color(128), color(160), color(200), color(255,128,0) );
  buttons[2] = new Button( 142, ys, 60, 18,     "btn02Method", "Blur", color(128), color(160), color(200), color(255,128,0) );
  buttons[3] = new Button( 10, ys+24, 60, 18,   "btn03Method", "Motion", color(128), color(160), color(200), color(255,128,0) );
  buttons[4] = new Button( 76, ys+24, 60, 18,   "btn04Method", "Emboss", color(128), color(160), color(200), color(255,128,0) );
  buttons[5] = new Button( 142, ys+24, 60, 18,  "btn05Method", "Blur 2", color(128), color(160), color(200), color(255,128,0) );
  buttons[6] = new Button( 10, ys+48, 60, 18,   "btn06Method", "Enhance", color(128), color(160), color(200), color(255,128,0) );
  buttons[7] = new Button( 76, ys+48, 60, 18,   "btn07Method", "Sharpen 2", color(128), color(160), color(200), color(255,128,0) );
  buttons[8] = new Button( 142, ys+48, 60, 18,  "btn08Method", "Laplace", color(128), color(160), color(200), color(255,128,0) );
  buttons[9] = new Button( 10, ys+72, 60, 18,   "btn09Method", "Save", color(128), color(160), color(200), color(0) );
  buttons[10] = new Button( 76, ys+72, 60, 18,  "btn10Method", "Open", color(128), color(160), color(200), color(0) );
  buttons[11] = new Button( 142, ys+72, 60, 18, "btn11Method", "Random", color(128), color(160), color(200), color(255,128,0) );
  buttons[0].light=true;
  // create spinners
  spinners[0] = new Spinner(220, ys-4, 60, 14, 10, 1, color(128), color(196));
  spinners[1] = new Spinner(284, ys-4, 60, 14, 10, 1, color(128), color(196));
  spinners[2] = new Spinner(348, ys-4, 60, 14, 10, 1, color(128), color(196));
  spinners[3] = new Spinner(412, ys-4, 60, 14, 10, 1, color(128), color(196));
  spinners[4] = new Spinner(476, ys-4, 60, 14, 10, 1, color(128), color(196));
  spinners[5] = new Spinner(220, ys+14, 60, 14, 10, 1, color(128), color(196));
  spinners[6] = new Spinner(284, ys+14, 60, 14, 10, 1, color(128), color(196));
  spinners[7] = new Spinner(348, ys+14, 60, 14, 10, 1, color(128), color(196));
  spinners[8] = new Spinner(412, ys+14, 60, 14, 10, 1, color(128), color(196));
  spinners[9] = new Spinner(476, ys+14, 60, 14, 10, 1, color(128), color(196));
  spinners[10] = new Spinner(220, ys+32, 60, 14, 10, 1, color(128), color(196));
  spinners[11] = new Spinner(284, ys+32, 60, 14, 10, 1, color(128), color(196));
  spinners[12] = new Spinner(348, ys+32, 60, 14, 10, 1, color(128), color(196));
  spinners[13] = new Spinner(412, ys+32, 60, 14, 10, 1, color(128), color(196));
  spinners[14] = new Spinner(476, ys+32, 60, 14, 10, 1, color(128), color(196));
  spinners[15] = new Spinner(220, ys+50, 60, 14, 10, 1, color(128), color(196));
  spinners[16] = new Spinner(284, ys+50, 60, 14, 10, 1, color(128), color(196));
  spinners[17] = new Spinner(348, ys+50, 60, 14, 10, 1, color(128), color(196));
  spinners[18] = new Spinner(412, ys+50, 60, 14, 10, 1, color(128), color(196));
  spinners[19] = new Spinner(476, ys+50, 60, 14, 10, 1, color(128), color(196));
  spinners[20] = new Spinner(220, ys+68, 60, 14, 10, 1, color(128), color(196));
  spinners[21] = new Spinner(284, ys+68, 60, 14, 10, 1, color(128), color(196));
  spinners[22] = new Spinner(348, ys+68, 60, 14, 10, 1, color(128), color(196));
  spinners[23] = new Spinner(412, ys+68, 60, 14, 10, 1, color(128), color(196));
  spinners[24] = new Spinner(476, ys+68, 60, 14, 10, 1, color(128), color(196));
  updateSpinners();
  //create checkbox
  cb = new Checkbox(500, ys+86, 12, 12, "(A)ll",false, color(128), color(196));  
}

void draw() {
  background(backC);
  //if(img != null)
  image(img, 0, 0);
  // Calculate the small rectangle we will process
  int xstart = constrain(mouseX - w/2, 0, img.width);
  int ystart = constrain(mouseY - w/2, 0, img.height);
  int xend = constrain(mouseX + w/2, 0, img.width);
  int yend = constrain(mouseY + w/2, 0, img.height);
  // if allwindows process all image
  if (allWindow==true)
  {
    xstart=0;ystart=0;xend=img.width;yend=img.height;
  }
  //filter dimension
  int matrixsize = 5;
  loadPixels();
  // Begin our loop for every pixel in the (smaller) image
  for (int x = xstart; x < xend; x++)
  {
    for (int y = ystart; y < yend; y++ )
    {
      color c = convolute(x, y, matrix, matrixsize, img);
      int loc = x + y*img.width;
      pixels[loc] = c;
    }
  }
  updatePixels();

  // draw rectangle
  noFill();
  stroke(0);
  if(ystart < img.height)
  { rect(xstart,ystart,xend-xstart,yend-ystart-1); }

 //draw buttons
  for(int i=0; i<buttons.length; i++)
  {
    buttons[i].draw();
  }
  //draw spinners
  for(int i=0; i<spinners.length; i++)
  {
    spinners[i].draw();
  }
  //draw checkbox
  cb.draw();
  //show matrix values
  fill(0);
  //showMatrix(false,true);
  //show factor and bias values
  fill(#eee8d5);  
  int ys = height - 100;
  text("(f) factor (F): " + nf(factor,1,2), 220, ys+95);
  text("(b) bias   (B): " + nf(bias,1,1), 350, ys+95);  

  // print ego
  //fill(#eee8d5);
  //text("Image Convolution by cameyo (2015)", 220, ys+97);

  // check the button pressed and do action...
  if (buttons[0].status) { Neutral();   buttons[0].status = false; resetBtn(0); updateSpinners();}
  if (buttons[1].status) { Sharpen();   buttons[1].status = false; resetBtn(1); updateSpinners();}
  if (buttons[2].status) { Blur();      buttons[2].status = false; resetBtn(2); updateSpinners();}
  if (buttons[3].status) { Motion();    buttons[3].status = false; resetBtn(3); updateSpinners();}
  if (buttons[4].status) { Emboss();    buttons[4].status = false; resetBtn(4); updateSpinners();}
  if (buttons[5].status) { Blur2();     buttons[5].status = false; resetBtn(5); updateSpinners();}
  if (buttons[6].status) { Enhance();   buttons[6].status = false; resetBtn(6); updateSpinners();}
  if (buttons[7].status) { Sharpen2();  buttons[7].status = false; resetBtn(7); updateSpinners();}
  if (buttons[8].status) { Laplace();   buttons[8].status = false; resetBtn(8); updateSpinners();}
  if (buttons[9].status) { saveIMG();   buttons[9].status = false; }
  if (buttons[10].status){ buttons[10].status = false; openLoad(); }
  if (buttons[11].status) { rndMatrix(); buttons[11].status = false; resetBtn(11); updateSpinners();}

  // check the spinner pressed and do action...
  for(int i=0; i<spinners.length; i++)
  {
    if (spinners[i].status==true)
    {
      updateMatrix();
      spinners[i].status=false;
      break;
    }
  }
  // check the checkbox pressed and do action...
  if (cb.s == true)
  { 
    allWindow=true;
  }
  else
  { 
    allWindow=false;
  }  
  
}

//convolute function
color convolute(int x, int y, float[][] matrix, int matrixsize, PImage conv)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++)
  {
    for (int j= 0; j < matrixsize; j++)
    {
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + conv.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,conv.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(conv.pixels[loc]) * matrix[i][j]);
      gtotal += (green(conv.pixels[loc]) * matrix[i][j]);
      btotal += (blue(conv.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  //rtotal = constrain(rtotal, 0, 255);
  //gtotal = constrain(gtotal, 0, 255);
  //btotal = constrain(btotal, 0, 255);
  // Use bias and factor
  // Make sure RGB is within range
  rtotal = constrain(rtotal*factor + bias, 0, 255);
  gtotal = constrain(gtotal*factor + bias, 0, 255);
  btotal = constrain(btotal*factor + bias, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}

// open load dialog
void openLoad()
{
  noLoop();
  selectInput("Select an image to process", "loadIMG");
}

//loadIMG
void loadIMG(File selection) 
{
  if (selection == null) 
  {
    println("No file selected.");
  } 
  else 
  {
    img = loadImage (selection.getAbsolutePath());
    //int w,h;    
    //w = constrain(img.width,640,img.width);
    //h = constrain(img.height,640,img.height);
    //surface.setSize(w, h+100);
    surface.setSize(img.width, img.height+110);
    //print(width,height);
    resetBtnSpin();
  }
  loop();
}

// save image
void saveIMG()
{
  cursor(WAIT);
  // the image borders have some problems :-)
  int xstart = 0;
  int ystart = 0;
  int xend = img.width;
  int yend = img.height;
  println(img.width,img.height);
  // filter dimension
  int matrixsize = 5;
  loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = xstart; x < xend; x++) 
  {
    for (int y = ystart; y < yend; y++ ) 
    {
      color c = convolute(x, y, matrix, matrixsize, img);
      int loc = x + y*img.width;
      pixels[loc] = c;
    }
  }
  updatePixels();
  // save image
  String filename = "";
  Calendar now = Calendar.getInstance();
  filename = "img_" + String.format("20%1$ty-%1$tm-%1$td_%1$tH.%1$tM.%1$tS", now) + ".png";
  save(savePath(filename));
  cursor(ARROW);
}

// buttons methods
void btn00Method()
{
  buttons[0].status = true;
  buttons[0].light = true;
}
void btn01Method()
{
  buttons[1].status = true;
  buttons[1].light = true;
}
void btn02Method()
{
  buttons[2].status = true;
  buttons[2].light = true;
}
void btn03Method()
{
  buttons[3].status = true;
  buttons[3].light = true;
}
void btn04Method()
{
  buttons[4].status = true;
  buttons[4].light = true;
}
void btn05Method()
{
  buttons[5].status = true;
  buttons[5].light = true;
}
void btn06Method()
{
  buttons[6].status = true;
  buttons[6].light = true;
}
void btn07Method()
{
  buttons[7].status = true;
  buttons[7].light = true;
}
void btn08Method()
{
  buttons[8].status = true;
  buttons[8].light = true;
}
// save image
void btn09Method()
{
  buttons[9].status = true;
  buttons[9].light = false;
}
// load image
void btn10Method()
{
  buttons[10].status = true;
  buttons[10].light = false;
}
void btn11Method()
{
  buttons[11].status = true;
  buttons[11].light = true;
}
void resetBtn(int b)
{
   // reset all but b light buttons
  for(int i=0; i<buttons.length; i++)
  {
    if (i!=b) buttons[i].light=false;
  }
}

void mousePressed()
{
  // check buttons
  for(int i=0; i<buttons.length; i++)
  {
    buttons[i].onClick();
  }
  // check spinners
  for(int i=0; i<spinners.length; i++)
  {
    spinners[i].onClick();
  }
  // chech checkbox
  cb.onClick();
}

void keyPressed()
{
  if (key == 'f')
  {
    factor=factor-0.01;
    factor=constrain(factor,0.01,10);
  }
  if (key == 'F')
  {
    factor=factor+0.01;
    factor=constrain(factor,0.01,10);
  }
  if (key == 'b')
  {
    bias=bias-1;
    bias=constrain(bias,-255,255);
  }
  if (key == 'B')
  {
    bias=bias+1;
    bias=constrain(bias,-255,255);
  }
  if ((key == 'a') || (key == 'A'))
  {
    cb.s=!(cb.s);
    //allWindow = !(allWindow);
  }
}

// set buttons and spinners in a new position
// after loading a new image
void resetBtnSpin()
{
  int ys = height - 100;
  buttons[0].x = 10;          buttons[0].y = ys;
  buttons[1].x = 76;          buttons[1].y = ys;
  buttons[2].x = 142;         buttons[2].y = ys;
  buttons[3].x = 10;          buttons[3].y = ys+24;
  buttons[4].x = 76;          buttons[4].y = ys+24;
  buttons[5].x = 142;         buttons[5].y = ys+24;
  buttons[6].x = 10;          buttons[6].y = ys+48;
  buttons[7].x = 76;          buttons[7].y = ys+48;
  buttons[8].x = 142;         buttons[8].y = ys+48;
  buttons[9].x = 10;          buttons[9].y = ys+72;
  buttons[10].x = 76;         buttons[10].y = ys+72;
  buttons[11].x = 142;        buttons[11].y = ys+72;

  spinners[0].x = 220;        spinners[0].y = ys-4;  
  spinners[1].x = 284;        spinners[1].y = ys-4;
  spinners[2].x = 348;        spinners[2].y = ys-4;
  spinners[3].x = 412;        spinners[3].y = ys-4;
  spinners[4].x = 476;        spinners[4].y = ys-4;
  spinners[5].x = 220;        spinners[5].y = ys+14;
  spinners[6].x = 284;        spinners[6].y = ys+14;
  spinners[7].x = 348;        spinners[7].y = ys+14;
  spinners[8].x = 412;        spinners[8].y = ys+14;
  spinners[9].x = 476;        spinners[9].y = ys+14;
  spinners[10].x = 220;       spinners[10].y = ys+32;
  spinners[11].x = 284;       spinners[11].y = ys+32;
  spinners[12].x = 348;       spinners[12].y = ys+32;
  spinners[13].x = 412;       spinners[13].y = ys+32;
  spinners[14].x = 476;       spinners[14].y = ys+32;
  spinners[15].x = 220;       spinners[15].y = ys+50;
  spinners[16].x = 284;       spinners[16].y = ys+50;
  spinners[17].x = 348;       spinners[17].y = ys+50;
  spinners[18].x = 412;       spinners[18].y = ys+50;
  spinners[19].x = 476;       spinners[19].y = ys+50;
  spinners[20].x = 220;       spinners[20].y = ys+68;
  spinners[21].x = 284;       spinners[21].y = ys+68;
  spinners[22].x = 348;       spinners[22].y = ys+68;
  spinners[23].x = 412;       spinners[23].y = ys+68;
  spinners[24].x = 476;       spinners[24].y = ys+68;
  cb.x = 500;
  cb.y = ys+86;
}