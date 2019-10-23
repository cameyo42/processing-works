// Presenter (presenter.pde)
// A simple slideshow of images (pages)
// processing 3.x
// by cameyo 2018
// icon Sound: Wallec - http://wwalczyszyn.deviantart.com
// icon Click: IconLeak - http://iconleak.com
// icon Center: Custom Icon Design - http://www.customicondesign.com

import processing.sound.*; // keyboard click and play song
import javax.swing.JOptionPane; // Input dialog

// image logo
PImage logoIMG;
// mouse coords
float x1,y1,x2,y2;
// application font
PFont font;
// Sound files (.wav)
SoundFile click, song;
float volume;
// Sound toggle
boolean soundClick;
boolean soundSong;
// Array List of images
ArrayList<PImage> IMG = new ArrayList<PImage>();
// Number of images
int numImages;

// current image number
int currImage;
// center of image
float cximg, cyimg;
// drag mouse coords
float startX, startY, endX, endY; 
boolean dragging;
// scale image to Fit
boolean fitImage;
boolean fitBigger;
float scaleImg;
float lenXimg, lenYimg;
// zoom image at mouse cursor
PImage canvasIMG;
boolean zoom; 
float zoomFactor;
// toggle show/hide alternative image (imageAlter)
boolean showAlter;
// timer
boolean theTimer;
int startTime;
int elapsedTime;
int waitTime;
int maxTime; // (sec)
boolean loopTime;

// colors
color black, white, highLight, darkGray, gray, lightGray;
color backMenuCol, textMenuCol;

// GUI
boolean showGUI;
boolean showControl;
boolean showPhantomControl;
boolean showTooltip;
PImage guiIMG;
// menu button
PImage btnMenu_img;
Button btnMenu;
// Timer button
PImage btnTimerON_img, btnTimerOFF_img;
ButtonIMG btnTimer;
// BEGIN - PREVIOUS - NEXT - END buttons
PImage btnBegin_img, btnPrevious_img, btnNext_img, btnEnd_img;
Button btnBegin, btnPrevious, btnNext, btnEnd;
// Sound buttons
PImage btnSongON_img, btnSongOFF_img, btnClickON_img, btnClickOFF_img;
ButtonIMG btnSong, btnClick;
// center image button
PImage btnCenter_img;
Button btnCenter;
// help button
PImage btnHelp_img;
Button btnHelp;
// checkbox
Checkbox cbFitAll, cbFitBigger;
Checkbox cbControl, cbPhantomControl;
Checkbox cbLoopTime;
Checkbox cbToolTip;
Checkbox cbZoom;
Slider slStepTime, slVolume;

//*******************
void setup()
{
  size(1280, 700);
  //fullScreen();
  background (0);
  // create font
  font = createFont("Consolas Bold", 18);
  textFont(font);
  surface.setTitle("::: Presenter :::                LOADING DATA...");
  // menu colors
  white = color(255);
  black = color(0);
  highLight = color(83,114,142);
  darkGray = color(66,66,66);
  gray = color(72,72,72);
  lightGray = color(128,128,128);
  backMenuCol = color(56,56,56);
  textMenuCol = color(202, 202, 202);
  theTimer = false;
  soundClick = false;
  soundSong = false;
  volume = 0.5;
  currImage = 0;
  cximg = width/2;
  cyimg = height/2;
  dragging = false;
  startX = 0;
  startY = 0;
  endX = 0;
  endY = 0;
  fitImage = false;
  fitBigger = true;
  zoom = false;
  zoomFactor = 2.0;
  showAlter = false;
  elapsedTime = 0;
  waitTime = 5000; //millisec
  maxTime = 600;
  loopTime = false;
  // load sound files from the data folder
  click = new SoundFile(this, "click.wav");
  song = new SoundFile(this, "song.mp3");
  // loading images
  openImages();
  // GUI
  showGUI = false;
  showTooltip = true;
  showControl = false;
  showPhantomControl = true;
  // load gui images
  guiIMG = loadImage("gui_images.png");
  btnTimerON_img  = guiIMG.get(0, 0, 64, 64);
  btnTimerOFF_img = guiIMG.get(64, 0, 64, 64);
  btnBegin_img    = guiIMG.get(128, 0, 100, 64);
  btnPrevious_img = guiIMG.get(228, 0, 64, 64);
  btnNext_img     = guiIMG.get(292, 0, 64, 64);
  btnEnd_img      = guiIMG.get(356, 0, 100, 64);
  btnClickON_img  = guiIMG.get(0, 64, 64, 64);
  btnClickOFF_img = guiIMG.get(64, 64, 64, 64);
  btnSongON_img   = guiIMG.get(128, 64, 64, 64);
  btnSongOFF_img  = guiIMG.get(192, 64, 64, 64);
  btnMenu_img     = guiIMG.get(256, 96, 20, 16);
  btnHelp_img     = guiIMG.get(256, 64, 32, 32);
  btnCenter_img   = guiIMG.get(328, 72, 48, 48);
  logoIMG         = guiIMG.get(0, 128, 455, 160);

  // create GUI (Preferences)
  int gbx, gby, stepX, stepY;
  gbx = 40;
  gby = 190;
  stepX = 70;
  stepY = 80;
  btnMenu          = new Button(2, 2, btnMenu_img, "", textMenuCol, "btn_Menu", "Menu [TAB]");
  btnHelp          = new Button(450, 10, btnHelp_img, "", textMenuCol, "btn_Help", "Help [F1]");
  btnCenter        = new Button(420, 180, btnCenter_img, "", textMenuCol, "btn_Center", "Center image [0]");
  btnSong          = new ButtonIMG(gbx-20, gby, btnSongON_img, btnSongOFF_img, true, "", textMenuCol, "btn_Song", "Music On/Off [M]");
  slVolume         = new Slider(gbx+stepX, gby+stepY-40, gbx+stepX+100, gby+stepY-40, 12, "Volume [+,-]", 0, 100, 50, black, highLight, textMenuCol, textMenuCol, "sl_Volume", 2);
  btnClick         = new ButtonIMG(gbx-20, gby+stepY, btnClickON_img, btnClickOFF_img, true, "", textMenuCol, "btn_Click", "Click On/Off [C]");
  cbToolTip        = new Checkbox(gbx+3*stepX+40, gby-50, 20, 20, "Show tooltip [T]", true, black, darkGray, highLight, gray, textMenuCol, "cb_ToolTip");
  cbZoom           = new Checkbox(gbx+3*stepX+40, gby, 20, 20, "Zoom [Z]", false, black, darkGray, highLight, gray, textMenuCol, "cb_Zoom");
  cbControl        = new Checkbox(gbx, gby+2*stepY+10, 20, 20, "Show Play buttons [P]", false, black, darkGray, highLight, gray, textMenuCol, "cb_Control");
  cbPhantomControl = new Checkbox(gbx, gby+2*stepY+45, 20, 20, "Show Play buttons (phantom) [X]", true, black, darkGray, highLight, gray, textMenuCol, "cb_PhantomControl");
  cbFitAll         = new Checkbox(gbx, gby+3*stepY+10, 20, 20, "Fit all Images to canvas [F]", false, black, darkGray, highLight, gray, textMenuCol, "cb_FitAll");
  cbFitBigger      = new Checkbox(gbx, gby+3*stepY+45, 20, 20, "Fit bigger Images to canvas [B]", true, black, darkGray, highLight, gray, textMenuCol, "cb_FitBigger");
  cbLoopTime       = new Checkbox(gbx, gby+4*stepY+10, 20, 20, "AutoPlay loop [L]", false, black, darkGray, highLight, gray, textMenuCol, "cb_LoopTime");
  slStepTime       = new Slider(gbx+20, gby+5*stepY, gbx+380, gby+5*stepY, 12, "Autoplay step time (sec) [Up,Down]", 1, maxTime, 5, black, highLight, textMenuCol, textMenuCol, "sl_StepTime", 1);

  // create Control buttons
  gbx = 30;
  gby = height - 30 - 64;
  stepX = 74;
  stepY = 74;
  btnTimer    = new ButtonIMG(gbx, gby, btnTimerON_img, btnTimerOFF_img, true, "", textMenuCol, "btn_Timer", "Autoplay On/Off [A]");
  btnBegin    = new Button(gbx+stepX, gby, btnBegin_img, "", textMenuCol, "btn_Begin", "First page [Home]");
  btnPrevious = new Button(gbx+stepX*2+36, gby, btnPrevious_img, "", textMenuCol, "btn_Previous", "Previous page [Left,PageDown]");
  btnNext     = new Button(gbx+stepX*3+36, gby, btnNext_img, "", textMenuCol, "btn_Next", "Next page [Right,PageUp]");
  btnEnd      = new Button(gbx+stepX*4+36, gby, btnEnd_img, "", textMenuCol, "btn_End", "Last page [End]");

  // start the timer
  if (theTimer) { startTime = millis(); }
  
}

//*******************
void draw()
//*******************
{
  background(69);
  imageMode(CENTER);
  if (numImages > 0)
    {
    // Show current image
    if (fitImage)
    {
      //scaleImg = min(width/(IMG.get(currImage).width), height/(IMG.get(currImage).height)); // integer scale
      scaleImg = min(width/(1.0*IMG.get(currImage).width), height/(1.0*IMG.get(currImage).height));
      lenXimg = IMG.get(currImage).width * scaleImg;
      lenYimg = IMG.get(currImage).height * scaleImg;
      image(IMG.get(currImage), cximg, cyimg, lenXimg, lenYimg);
    }
    else if (fitBigger)
    {
      if (IMG.get(currImage).width > width || IMG.get(currImage).height > height)
      {
        scaleImg = min(width/(1.0*IMG.get(currImage).width), height/(1.0*IMG.get(currImage).height));
        lenXimg = IMG.get(currImage).width * scaleImg;
        lenYimg = IMG.get(currImage).height * scaleImg;
        image(IMG.get(currImage), cximg, cyimg, lenXimg, lenYimg);
      }
      else { image(IMG.get(currImage), cximg, cyimg); }
    }
    else { image(IMG.get(currImage), cximg, cyimg); }
  }
  // Draw gui elements
  if (showGUI)
  {
    // show gui preferences
    noStroke();
    fill(0,0,0,128);
    //rect(0,0,475,height);
    rect(0,0,492,height);
    // logo
    imageMode(CORNER);
    image(logoIMG,32,0);
    // show button
    btnHelp.show();
    btnCenter.show();
    btnSong.show();
    btnClick.show();
    cbToolTip.show();
    cbZoom.show();
    cbControl.show();
    cbPhantomControl.show();
    cbFitAll.show();
    cbFitBigger.show();
    cbLoopTime.show();
    slStepTime.show();
    slVolume.show();
    // show tooltip
    if (showTooltip)
    {
      btnHelp.toolTip();
      btnCenter.toolTip();
      btnSong.toolTip();
      btnClick.toolTip();
    }
  }
  //  Draw controller elements
  if (showControl && !showPhantomControl)
  {
    drawController();
    // show tooltip
    if (showTooltip)
    {
      btnTimer.toolTip();
      btnBegin.toolTip();
      btnPrevious.toolTip();
      btnNext.toolTip();
      btnEnd.toolTip();
    }
  }
  //  Draw phantom controller elements
  if (!showControl && showPhantomControl)
  {
    // check if mouse is over phantom control buttons (rectangle)
    if (mouseX < 490 && mouseY > height - 130)
    {
      drawController();
      // show tooltip
      if (showTooltip)
      {
        btnTimer.toolTip();
        btnBegin.toolTip();
        btnPrevious.toolTip();
        btnNext.toolTip();
        btnEnd.toolTip();
      }
    }
  }

  // show Menu button
  btnMenu.show();
  if (showTooltip) { btnMenu.toolTip(); }
  
  // show image/page number
  showNumber();
  
  if (zoom) // draw zoom window at mouse cursor
  {
    showZoom(zoomFactor);
  }  
  
  // show cursor
  showCursor();

  // show info
  showInfo();

  // check timer (time elapsed)
  if (theTimer)
  {
    elapsedTime = millis() - startTime;
    if (elapsedTime > waitTime)
    {
      currImage++;
      showAlter = false;
      startTime = millis();
    }
    if (currImage > numImages-1)
    {
      if (!loopTime) //stop slideshow to last image
      {
        currImage = numImages-1;
        theTimer = false;
        btnTimer.s = true;
      }
      else  //repeat slideshow from first image
      {
        currImage = 0;
      }
    }
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
  name = getClass().getSimpleName();
  out=name+"_"+y+"-"+nf(m, 2)+"-"+nf(d, 2)+"_"+nf(hh, 2)+"."+nf(mm, 2)+"."+nf(ss, 2);
  return out;
}

//*********************************
void drawController()
{
  btnTimer.show();
  btnBegin.show();
  btnPrevious.show();
  btnNext.show();
  btnEnd.show();
  // show time elapsed
  if (theTimer)
  {
    fill(0);
    textSize(12);
    text((1 + elapsedTime/1000) + "/" + (int)slStepTime.v, btnTimer.x+12 ,btnTimer.y-4);
    fill(255);
    textSize(12);
    text((1 + elapsedTime/1000) + "/" + (int)slStepTime.v, btnTimer.x+12 ,btnTimer.y+76);
    textSize(18);
  }
}

//*********************************
void showNumber()
{
  fill(255);
  stroke(0);
  rect(width-50,height-25,44,20);
  textAlign(CENTER);
  fill(0);
  text(currImage+1,width-27,height-8);

  //draw line middle of width
  stroke(255);
  line(width/2,0, width/2,1);
  line(width/2,height, width/2,height-2);
}

//*********************************
void showInfo()
{
  String info="::: Presenter :::";
  // info = nf(int(frameRate),0);
  if (theTimer)
  {
    info = info + "                time: " + elapsedTime/1000;
  }
  surface.setTitle(info);
}

//*********************************
void showCursor()
{
  if ( (mouseX > (width-51) && mouseX < (width-5) && mouseY > (height-26) && mouseY < (height-4)) ||
       btnMenu.isOver() ||
       btnHelp.isOver() ||
       btnCenter.isOver() ||
       btnSong.isOver() ||
       slVolume.isOver() ||
       btnClick.isOver() ||
       cbToolTip.isOver() ||
       cbZoom.isOver() ||
       cbControl.isOver() ||
       cbPhantomControl.isOver() ||
       cbFitAll.isOver() ||
       cbFitBigger.isOver() ||
       cbLoopTime.isOver() ||
       slStepTime.isOver() ||
       btnTimer.isOver() ||
       btnBegin.isOver() ||
       btnPrevious.isOver() ||
       btnNext.isOver() ||
       btnEnd.isOver() )
  {
    cursor(HAND);
  }
  else { cursor(ARROW); }
}

//*********************************
void openImages()
{
  numImages = 0;
  if (fileExists(dataPath("list.txt")))
  {
    String listImages[] = loadStrings(dataPath("list.txt"));
    //println("There are " + listImages.length + " immagini");
    //for (int i = 0 ; i < listImages.length; i++)
    //{ println(listImages[i]); }

    // load images
    for(int i=0; i<listImages.length; i++)
    {
      String fileImage = listImages[i];
      println(fileImage);
      if (fileExists(fileImage))
      {
        if (listImages[i].length() > 0)
        {
          //println(listImages[i],listImages[i].length());
          PImage imageLoaded = loadImage(fileImage);
          IMG.add(imageLoaded);
        }
      }
      else
      {
        println("Image " + fileImage + " not found.");
      }
    }
  }
  else
  {
    println("File " + dataPath("list.txt") + " not found.");
  }
  numImages = IMG.size();
}

//*********************************
boolean fileExists(String path)
{
  File file=new File(path);
  boolean exists = file.exists();
  return (exists);
}