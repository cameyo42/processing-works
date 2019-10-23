
// **********************
// drawABC FUNCTION
// **********************
void drawABC()
{
  // program name
  fill(0);
  text("CHIODINI",4, height-panelH+11);
  text("5  10  15  20  25  30  50", 192, height-panelH+94);
  rectMode(CORNER);
  noFill();
  stroke(0);
  rect(2,height-panelH+1,52,12);
  text("N-> new",2, height-panelH+25);         text("F-> fill",80, height-panelH+25);
  text("O-> open", 2, height-panelH+35);       text("G-> grid",80, height-panelH+35);
  text("S-> save", 2, height-panelH+45);       text("I-> image",80, height-panelH+45);
  text("C-> circle", 2, height-panelH+55);     text("Z-> zoom", 80, height-panelH+55);
//                                               text("Esc-> quit", 80, height-panelH+65);
  text("R-> square", 2, height-panelH+65);     text("1..7-> size", 80, height-panelH+65);
  text("E-> erase", 2, height-panelH+75);      text("-> draw", 108, height-panelH+79);
  text("P-> pick", 2, height-panelH+85);
  text("D-> 3d", 2, height-panelH+95);         text("Esc-> quit",80,height-panelH+93);

  text("circle",width-289,height-panelH+15);
  text("square",width-289,height-panelH+39);
  text("3D",width-330, height-panelH+39);
  text("open",width-322,height-panelH/2+17);
//  fill(redC);
  text("save",width-286,height-panelH/2+17);
  fill(0);
  text("new",width-283,height-panelH/2+38);
  text("load colors",width-412,height-7);

  text("erase",width-46,height-panelH+9);
  text("pick",width-42,height-panelH+96);

  text("fill",width-795, height-panelH+83+11);
  text("grid",width-731, height-panelH+83+11);
  text("image",width-669, height-panelH+83+11);

  fill(150);
  text("cameyo 2015", 60,height-90);

//*******************************************
// draw help Button and text HELP
//*******************************************
  noFill();
  stroke(0);
  strokeWeight(linea);
  rectMode(CORNER);
  rect(142,height-panelH+2,36,28);
  line(148,height-panelH+21,154,height-panelH+21);
  fill(0);
  text("HELP", 148,height-panelH+20);


//*******************************************
// draw chiodini dimension text square
//*******************************************
  noFill();
  stroke(redC);
  rectMode(CORNER);
  if (dim== 5) {
    rect(188, height-panelH+83, 14, 14);
  }
  if (dim==10) {
    rect(208, height-panelH+83, 16, 14);
  }
  if (dim==15) {
    rect(232, height-panelH+83, 16, 14);
  }
  if (dim==20) {
    rect(256, height-panelH+83, 16, 14);
  }
  if (dim==25) {
    rect(280, height-panelH+83, 16, 14);
  }
  if (dim==30) {
    rect(304, height-panelH+83, 16, 14);
  }
  if (dim==50) {
    rect(328, height-panelH+83, 16, 14);
  }

//*******************************************
// draw arrow keys: up, down, left, right
//*******************************************
  stroke(0);
  // UP arrow
  line(82,height-20,82,height-20-10);
  line(82,height-20-10,82-2,height-20-10+2);
  line(82,height-20-10,82+2,height-20-10+2);
//  line(82-2,height-20-10+2,82+2,height-20-10+2);
  // DOWN arrow
  line(88,height-20,88,height-20-10);
  line(88,height-20,88-2,height-20-2);
  line(88,height-20,88+2,height-20-2);
  // LEFT arrow
  line(94,height-28,104,height-28);
  line(94,height-28,94+2,height-28-2);
  line(94,height-28,94+2,height-28+2);
  // RIGHT arrow
  line(94,height-22,104,height-22);
  line(104,height-22,104-2,height-22-2);
  line(104,height-22,104-2,height-22+2);
}

// ********************
// drawGrid FUNCTION
// ********************
void drawGrid(int gap, int w, int h, int step)
{
  noStroke();
  fill(gridC);
  for(int i=0; i < ((w+1)/step); i++)
  {
    for(int k=0; k < ((h+1)/step); k++)
    {
      if (griglia[i][k] == 0)
      { ellipse(gap+i*step,gap+k*step,3,3); }
    }
  }
}

// ********************
// drawPanel FUNCTION
// ********************
void drawPanel()
{
  stroke(80,80,80);
  fill(212);
  strokeWeight(linea);
  rectMode(CORNERS);
  rect(0,height-panelH+linea,width-linea,height-linea);
  rectMode(CORNER);
}


// *********************
// drawButtons FUNCTION
// *********************
// draw only static parts of buttons and GUI elements
void drawButtons()
{
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

  // save button
  rectMode(CENTER);
  strokeWeight(linea);
  stroke(0);
  fill(backC);
  rect(width-274,height-panelH/2+14,30,15);

  // load button
  rectMode(CENTER);
  strokeWeight(linea);
  stroke(0);
  fill(backC);
  rect(width-310,height-panelH/2+14,30,15);

  // new button
  rectMode(CENTER);
  strokeWeight(linea);
  stroke(0);
  fill(backC);
  rect(width-274,height-panelH/2+35,30,15);

  // load colors button
  rectMode(CENTER);
  strokeWeight(linea);
  stroke(0);
  fill(backC);
  rect(width-378,height-11,75,15);

  // circle button (chiodino)
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

  // zoom button
  stroke(0,0,0,255);
  strokeWeight(1);
  noFill();
  rectMode(CORNER);
  rect(width-526,height-panelH+2,94,94);
  rectMode(CENTER);

  // draw center point ZOOM
  noStroke();
  fill(0);
  ellipse(width-526+94/2,height-panelH+2+94/2,2,2);

  // draw fill button
  stroke(0,0,0,255);
  strokeWeight(linea);
  noFill();
  rectMode(CORNER);
  rect(width-803, height-panelH+83,39,14);
  rectMode(CENTER);

  // draw grid button
  stroke(0,0,0,255);
  strokeWeight(linea);
  noFill();
  rectMode(CORNER);
  rect(width-738, height-panelH+83,39,14);

  // draw image button
  stroke(0,0,0,255);
  strokeWeight(linea);
  noFill();
  rectMode(CORNER);
  rect(width-673, height-panelH+83,39,14);

  // draw 3D button
  stroke(0,0,0,255);
  strokeWeight(linea);
  fill(backC);
  rectMode(CORNER);
  rect(width-329, height-panelH+18,10,10);
}


// *********************
// drawSpectrum FUNCTION
// *********************
void drawSpectrum()
{
  // draw color palette
  noStroke();
  colorMode(HSB, palH*2, palH, palH, 255);
  rectMode(CORNER);
  for (int i=15; i < (palH*2)+1; i+=15)
  {
    for (int j=30; j < palH+1; j+=15)
    {
      fill(i, j, 255);
      rect(width-258+i, height-panelH-12+j, 15, 15);
    }
  }
  // draw grayscale palette
  colorMode(RGB, 200, 200, 200, 255);
  for (int i=0; i < 6; i+=1)
  {
    fill(i*40, i*40, i*40, 255);
    rect(width-258+15+i*30, height-panelH+3, 30, 15);
  }
  // draw palette border
  colorMode(RGB,255,255,255,255);
  noFill();
  strokeWeight(1);
  stroke(0,0,0,255);
  rect(width-258+15,height-panelH+2,2*palH,palH);
}

// ************************
// drawUserPalette FUNCTION
// ************************
void drawUserPalette()
{
  // draw color palette
  noStroke();
  colorMode(RGB);
  rectMode(CORNER);
  int uX,uY;
  uX = width-416;
  uY = height-panelH+2;
  int k = 0;
  for (int i=0; i < 5; i++)
  {
    for (int j=0; j < 5; j++)
    {
      fill(userPal[k]);
      rect(uX+15*i, uY+15*j, 15, 15);
      k++;
    }
  }
  // draw palette border
  colorMode(RGB,255,255,255,255);
  noFill();
  strokeWeight(1);
  stroke(0,0,0,255);
  rect(uX,uY,75,75);
}

// ************************
// drawWebPalette FUNCTION
// ************************
void drawWebPalette()
{
  int i,j,k,x0,y0;
  noStroke();
  k = 0;
  x0 = width-1010;
  y0 = height - panelH+2;
  for(i=0; i < 36; i++)
  {
    for(j=0; j < 6; j++)
    {
      fill(web[k]);
      rect(x0+i*13,y0+j*13,12,12);
      k++;
    }
  }
}