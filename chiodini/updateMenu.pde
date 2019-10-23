//**********************************
// updateButtons() FUNCTION
//**********************************
void updateButtons()
{
  // draw buttons (disabled)

  // erase button
  rectMode(CENTER);
  strokeWeight(linea);
  stroke(0);
  fill(backC);
  rect(width-30,height-panelH/2-30,15,15);
  rectMode(CORNER);

  // pick button
  rectMode(CENTER);
  strokeWeight(linea);
  stroke(0);
  fill(backC);
  rect(width-30,height-panelH/2+28,15,15);
  fill(0);
  rect(width-30,height-panelH/2+28,9,9);
  fill(255);
  rect(width-30,height-panelH/2+28,5,5);
  rectMode(CORNER);

  // circle button (chiodino)
  // delete
  stroke(backC);
  fill(backC);
  ellipse(width-300,height-panelH/2-38,17,17);
  // redraw
  strokeWeight(linea);
  stroke(0);
  fill(backC);
  ellipse(width-300,height-panelH/2-38,15,15);

  // square button (chiodino)
  rectMode(CENTER);
  strokeWeight(linea);
  stroke(0);
  fill(backC);
  rect(width-300,height-panelH/2-14,15,15);
  rectMode(CORNER);

  // draw 3D button
  stroke(0,0,0,255);
  strokeWeight(linea);
  fill(backC);
  rectMode(CORNER);
  rect(width-329, height-panelH+18,10,10);

  // draw selected button (red)
  if (pickColor)
  {
    rectMode(CENTER);
    fill(redC);
    rect(width-30, height-panelH/2+28, 5, 5);
    rectMode(CORNER);
  }

  if ((tipo == 0) && (!pickColor))
  {
    fill(redC);
    noStroke();
    ellipse(width-300, height-panelH/2-38, 7, 7);
  }

  if ((tipo == 1) && (!pickColor))
  {
    fill(redC);
    noStroke();
    rectMode(CENTER);
    rect(width-300, height-panelH/2-14, 7, 7);
    rectMode(CORNER);
  }

  if ((tipo == 2) && (!pickColor))
  {
    stroke(redC);
    strokeWeight(linea+1);
    line(width-30+5, height-panelH/2-30-6, width-30-6, height-panelH/2-30+5);
    line(width-30-6, height-panelH/2-30-6, width-30+5, height-panelH/2-30+5);
    strokeWeight(linea);
  }

  if (treD==1)
  {
   // draw 3D button (red)
    stroke(0,0,0,255);
    strokeWeight(linea);
    noFill();
    rectMode(CORNER);
    stroke(redC);
    rect(width-327, height-panelH+20,6,6);
  }
}

//**********************************
// updateCurrentColorGUI() FUNCTION
//**********************************
void updateCurrentColorGUI()
{
  //********************************
  // draw/update current color text
  //********************************
  // delete text
  fill(backC);
  stroke(0);
  rectMode(CORNER);
  rect(width-606, height-panelH+83,59,14);
  // write text value color
  fill(0);
  text(hex(curColor), width-600, height-panelH+94);

  //*******************************************
  // draw/update status of CURRENT COLOR BOX
  //*******************************************
  // current color
  rectMode(CENTER);
  strokeWeight(linea);
  stroke(0);
  fill(curColor);
  rect(width-30, height-panelH/2-2, 30, 30);
  rectMode(CORNER);
}

//**********************************
// updateSaveButton() FUNCTION
//**********************************
void updateSaveButton()
{
//************************************
// draw/update status of SAVE button
//***********************************
// overwrite "save" text with rect
  rectMode(CORNER);
  fill(backC);
  noStroke();
  rect(width-287, height-panelH/2+8, 26, 11);
  // rewrite "save" text (red or black color)
  fill(redC);
  if (savedFile) { fill(0); }
  text("save", width-286, height-panelH/2+17);
}

