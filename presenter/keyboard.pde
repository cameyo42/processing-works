//*********************************
void keyPressed()
{
  // 112 = F1; 123 = F12
  println("keyCode="+keyCode+" \tkey="+int(key)+" \ttype="+key);

  // Disable ESC key
  if (keyCode==ESC)
  {
    key = 0;
  }  

  // Show help file
  if (keyCode==112) // F1
  {
    launch(dataPath("help.pdf"));
  }
  
  // gui ON/OFF
  if (keyCode==TAB)
  {
    btn_Menu();
  }  

  // goto page
  if (key == 'g' || key == 'G')
  {
    gotoPage();
  }
  
  // zoom(ON/OFF)
  if (key == 'z' || key == 'Z')
  {
    cb_Zoom();
    cbZoom.s = !cbZoom.s;
  }
  
  // center image on canvas
  if (key == '0')
  {
    btn_Center();
  }

  // zoom out
  if (key == '1' || key == '1')
  {
    zoomFactor = constrain(--zoomFactor, 1, 32); 
  }  
  
  // zoom in
  if (key == '2' || key == '2')
  {
    zoomFactor = constrain(++zoomFactor, 1, 32); 
  }  
  
  // Show ToolTip (ON/OFF)
  if (key == 't' || key == 'T')
  {
    showTooltip = !showTooltip ;
    cbToolTip.s = !cbToolTip.s;
  }

  // Play Song (ON/OFF)
  if (key == 'm' || key == 'M')
  {
    btn_Song();
    btnSong.s = !btnSong.s;
  }

  // Click sound keys (ON/OFF)
  if (key == 'c' || key == 'C')
  {
    btn_Click();
    btnClick.s = !btnClick.s;
  }

  // volume up (Song)
  if (key == '+')
  {
    volume = volume + 0.05;
    if (volume > 1) { volume = 1; }
    slVolume.v = volume*100;;
    if (soundSong) { song.amp(volume); }
  }

  // volume down (Song)
  if (key == '-')
  {
    volume = volume - 0.05;
    if (volume < 0) { volume = 0; }
    slVolume.v = volume*100;
    if (soundSong) { song.amp(volume); }
  }

  // start/stop the timer
  if (key=='a' || key=='A')
  {
    btn_Timer();
    btnTimer.s = !btnTimer.s;
  }

  // Toggle fit all images on canvas
  if (key=='f' || key=='F')
  {
    cb_FitAll();
    cbFitAll.s = !cbFitAll.s;
  }

  // toggle fit only bigger images on canvas
  if (key=='b' || key=='B')
  {
    cb_FitBigger();
    cbFitBigger.s = !cbFitBigger.s;
  }

  // toggle infinite loop when autoplay
  if (key=='l' || key=='L')
  {
    cb_LoopTime();
    cbLoopTime.s = !cbLoopTime.s;
  }

  // show PLAY control buttons
  if (key=='p' || key=='P')
  {
    cb_Control();
    cbControl.s = !cbControl.s;
  }

  // show PLAY control buttons (phantom)
  if (key=='x' || key=='X')
  {
    cb_PhantomControl();
    cbPhantomControl.s = !cbPhantomControl.s;
  }

  // goto first page
  if (keyCode == 36 ) // HOME key
  {
    btn_Begin();
  }

  // goto last page
  if (keyCode==35) // END key
  {
    btn_End();
  }

  // show next page
  if (keyCode == RIGHT || keyCode == 33) // right arrow or PageUp
  {
    btn_Next();
  }

  // show previous page
  if (keyCode == LEFT || keyCode == 34) // left arrow or PageDown
  {
    btn_Previous();
  }

  // add loop time (+1 sec)
  if (keyCode == UP) // Up arrow
  {
    slStepTime.v ++;
    if (slStepTime.v > maxTime) { slStepTime.v = maxTime; }
    waitTime = (int)slStepTime.v * 1000;
  }

  // sub loop time (-1 sec)
  if (keyCode == DOWN)  // Down arrow
  {
    slStepTime.v --;
    if (slStepTime.v < 1) { slStepTime.v = 1; }
    waitTime = (int)slStepTime.v * 1000;
  }

  // save canvas screenshot (automatic filename)
  if (key=='s'|| key=='S')
  {
    String filename = newFilename();
    save(filename + ".png");
  }
}
//*********************************