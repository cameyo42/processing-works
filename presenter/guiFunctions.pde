// Functions of gui elements

void btn_Menu()
{
  showGUI = !showGUI;
  // disable timer when show the menu
  if (showGUI) { theTimer = false; btnTimer.s = true; }    
}

void btn_Center()
{
  cximg = width/2;
  cyimg =height/2;
}


void btn_Song()
{
  soundSong = !soundSong;
  if (soundSong)
  {
    song.loop();
    song.amp(volume);
  }
  else
  {
    //song.stop();
    song.pause();
  }
}

void btn_Click()
{
  soundClick = !soundClick;
  if (soundClick)
  {
    click.play();
  }
}

void cb_ToolTip()
{
  showTooltip = !showTooltip ;
}

void cb_Zoom()
{
  zoom = !zoom;
}

void cb_Control()
{
  showControl = !showControl;
  if (showControl)
  {
    showPhantomControl = false;
    cbPhantomControl.s = false;
  }
}

void cb_PhantomControl()
{
  showPhantomControl = !showPhantomControl;
  if (showPhantomControl)
  {
    showControl = false;
    cbControl.s = false;
  }
}

void cb_FitAll()
{
  fitImage = !fitImage;
  if (fitImage)
  {
    fitBigger = false;
    cbFitBigger.s = false;
  }
}

void cb_FitBigger()
{
  fitBigger = !fitBigger;
  if (fitBigger)
  {
    fitImage = false;
    cbFitAll.s = false;
  }
}

void cb_LoopTime()
{
  loopTime = !loopTime;
}

void sl_StepTime()
{
  waitTime = (int)slStepTime.v * 1000;
}

void sl_Volume()
{
  volume = slVolume.v/100;
  if (volume > 1) { volume = 1; }
  if (volume < 0) { volume = 0; }
  if (soundSong) { song.amp(volume); }
}

void btn_Timer()
{
  theTimer = !theTimer;
  if (theTimer)
  {
    startTime = millis();
  }
  if (currImage == numImages - 1)
  {
    currImage = 0;
  }
  mousePressed = false;
  keyPressed = false;
}

void btn_Begin()
{
  if (soundClick) { click.play(); }
  currImage = 0;
  showAlter = false;
  mousePressed = false;
  keyPressed = false;
}

void btn_Previous()
{
  if (soundClick) { click.play(); }
  currImage -= 1;
  if (currImage < 0) { currImage = numImages - 1; }
  showAlter = false;
  mousePressed = false;
  keyPressed = false;
}

void btn_Next()
{
  if (soundClick) { click.play(); }
  currImage += 1;
  if (currImage > numImages - 1) { currImage = 0; }
  showAlter = false;
  mousePressed = false;
  keyPressed = false;
}

void btn_End()
{
  if (soundClick) { click.play(); }
  currImage = numImages - 1;
  showAlter = false;
  mousePressed = false;
  keyPressed = false;
}

void btn_Help()
{
  launch(dataPath("help.pdf"));
}

//*********************************
void gotoPage()
{
  String error = "Error: wrong page number";
  String page = JOptionPane.showInputDialog("Enter page number (1.." + numImages + "): ");
  int numPage=0;
  if (page != null) // Not cancel and valid string
  {
      try
      {
        numPage = Integer.parseInt(page);
      }
      catch (NumberFormatException e)
      {
        println(error);
      }
      if (numPage < 1 || numPage > numImages)
      {
        println(error);
      }
      else currImage = numPage - 1;
  }
  else { println(error); }
  keyPressed = false;
  mousePressed = false;
}