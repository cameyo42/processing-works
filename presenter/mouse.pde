//*********************************
void mousePressed()
//*********************************
{
  x2 = mouseX;
  y2 = mouseY;
  x1 = pmouseX;
  y1 = pmouseY;
  println(mouseX,mouseY);

  if (mouseButton == LEFT)
  {
    // check if press menu button
    if (mouseX > 2 && mouseX < 23 && mouseY >2 && mouseY < 19)
    { 
      btn_Menu();
    }   
    // check if press on page number (goto page)
    else if (mouseX > (width-51) && mouseX < (width-5) && mouseY > (height-26) && mouseY < (height-4))
    {
      gotoPage();
    }
    // check if press previous/next page with mouse (left/right of canvas)
    else if (!showGUI && !showControl && (mouseX > 490 || mouseY < height - 130))  // GUI and Control not visible
    {
      if (mouseY < 30) { showAlter = !showAlter;}
      else if (mouseX > width/2) { btn_Next(); }
      else if (mouseX < width/2) { btn_Previous(); }
    }
    else if (!showGUI && (showControl || showPhantomControl)) // GUI not visible and Control visible
    {
      // check if pressed a button
      btnTimer.onClick();
      btnBegin.onClick();
      btnPrevious.onClick();
      btnNext.onClick();
      btnEnd.onClick();
    }
    else if (showGUI)
    {
      btnHelp.onClick();
      btnCenter.onClick();
      btnSong.onClick();
      btnClick.onClick();
      cbZoom.onClick();
      cbToolTip.onClick();
      cbControl.onClick();
      cbPhantomControl.onClick();
      cbFitAll.onClick();
      cbFitBigger.onClick();
      cbLoopTime.onClick();
      slStepTime.onClick();
      slVolume.onClick();
    }

  }
  else if (mouseButton == RIGHT) // drag image
  {
    if (!showGUI)
    {    
      dragging = true;
      startX = mouseX;
      startY = mouseY;
    }  
  }

}

//*********************************
void mouseDragged()
//*********************************
{
  x2 = mouseX;
  y2 = mouseY;
  x1 = pmouseX;
  y1 = pmouseY;
  if (mouseButton == LEFT)
  {
    if (showGUI)
    {
      slStepTime.onDrag();
      slVolume.onDrag();
    }
  }

  // drag image
  if (mouseButton == RIGHT)
  {
    if (dragging && !showGUI)
    {
      endX = mouseX;
      endY = mouseY;
      cximg = cximg + (endX - startX);
      cyimg = cyimg + (endY - startY);
      startX = endX;
      startY = endY;
    }  
  }    
}

//*********************************
void mouseReleased()
//*********************************
{
  slStepTime.locked = false;
  slVolume.locked = false;
  dragging = false;
}

//*********************************
void mouseMoved()
//*********************************
{
  //x2 = mouseX;
  //y2 = mouseY;
  //x1 = pmouseX;
  //y1 = pmouseY;
}

//*********************************
void mouseWheel(MouseEvent event)
//*********************************
{
  float e = event.getCount();
  println(e); // -1.0 or 1.0
  if (e > 0)
  {
    if (zoom) // change zoom
    { zoomFactor = constrain(--zoomFactor, 1, 32); }
  }
  else // e < 0
  {
    if (zoom)
    { zoomFactor = constrain(++zoomFactor, 1, 32); }
  }
}
