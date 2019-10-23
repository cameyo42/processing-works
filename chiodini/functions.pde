// **********************
// putChiodino FUNCTION
// **********************
void putChiodino(int x, int y, int d, color c, int t, int iG, int jG, int ddd)
// x -> x position
// y -> y position
// d -> chiodino diameter
// c -> chiodino color
// t -> chiodino tipo
// iG -> X grid index
// jG -> Y grid index
{
  wip = true;
  savedFile = false;
  // draw chiodino
  fill(c);
  noStroke();
  if (t == 0)      //circle
  {
    ellipse(x, y, d, d);
    if (!FILLING) { griglia[iG][jG] = 1; }
    colGriglia[iG][jG] = c;
    tipoGriglia[iG][jG] = t;
    treDGriglia[iG][jG] = ddd;
  }
  else if (t == 1) //rect
  {
    rectMode(CENTER);
    rect(x, y, d, d);
    rectMode(CORNER);
    if (!FILLING) { griglia[iG][jG] = 1; }
    colGriglia[iG][jG] = c;
    tipoGriglia[iG][jG] = t;
    treDGriglia[iG][jG] = ddd;
  }
  else if (t == 2) //erase
  {
    fill(backC);
    rectMode(CENTER);
    rect(x, y, d+1, d+1);
    fill(gridC);
    if (GRID)
    { ellipse(x, y, 3, 3); }
    rectMode(CORNER);
    griglia[iG][jG] = 0;
  }

  // 3D for circle
  if ((ddd==1) && (t==0) && (dim != 5))
  {
    // draw small white circle
    fill(230, 230, 230, 200);
    // fill(200,200,200,255);
    ellipse(x+d/5, y-d/5, d/5, d/5);
  }

  // 3D for square
  if ((ddd==1) && (t==1) && (dim != 5))
  {
    // draw small white circle
    noFill();
    stroke(230, 230, 230, 200);
    // stroke(200,200,200,255);
    rectMode(CENTER);
    if (dim % 2 == 0)
    {
      rect(x, y, d-3, d-3);
    }
    else
    { rect(x, y, d-4, d-4); }
    rectMode(CORNER);
  }
  updateSaveButton();
}

// **********************
// drawChiodini FUNCTION
// **********************
void drawChiodini()
{
  for (int i=0; i<gXmax; i++)
  {
    for (int j=0; j<gYmax; j++)
    {
      if (griglia[i][j] == 1)
      {
        putChiodino((dim/2)+i*dim, (dim/2)+j*dim, dim-2, color(colGriglia[i][j]), tipoGriglia[i][j], i, j, treDGriglia[i][j]);
      }
    }
  }
}

// **********************
// saveALL FUNCTION
// **********************
void saveALL(File savePath)
{
  // Opens file chooser
  //String savePath = selectOutput("Save file...");
  thePath = false;
  if (savePath != null)
  {
    thePath = true; // a file has been selected
    // If a file was selected
    cursor(WAIT);
    //**************************
    // save chiodini draw image
    //**************************
    PImage outIMG;
    outIMG = get(0, 0, width, height-panelH);
    // filename = "ch_" + width + "_" + height + "_" + dim + "_" + timestamp() + ".png";
    outIMG.save(savePath+".png");
    //***********************
    // save data (text file)
    //***********************
    String lista="", riga="";
    // get data from griglia matrix
    for (int i=0; i<gXmax; i++)
    {
      for (int j=0; j<gYmax; j++)
      {
        if (griglia[i][j] == 1)
        {
          riga = str(i)+","+str(j)+","+str(colGriglia[i][j])+","+str(tipoGriglia[i][j])+","+str(treDGriglia[i][j])+"\n";
          lista=lista+riga;
        }
      }
    }
    String[] outTXT = split(lista, "\n");
    saveStrings(savePath,outTXT);
    savedFile = true;
    updateSaveButton();
    cursor(ARROW);
    thePath=false;
    // restart draw()
    loop();
  }
}

// **********************
// loadDATA FUNCTION
// **********************
void loadDATA(File loadPath)
{
  // Opens file chooser
  //String loadPath = selectInput("Open file...");
  thePath = false;
  if (loadPath != null)
  {
    thePath = true; // a file has been selected
    //println(loadPath);
    // load data
    String tline[] = loadStrings(loadPath);
    linee=tline;
  }
  // restart draw() function
  loop();
}

// **********************
// colorFILL FUNCTION
// **********************
void colorFILL()
{
  FILLING = (!FILLING);
  if (FILLING) // fill grid
  {
    for (int i=0; i<gXmax; i++)
    {
      for (int j=0; j<gYmax; j++)
      {
        if (griglia[i][j] == 0)
        {
          putChiodino((dim/2)+i*dim, (dim/2)+j*dim, dim-2, curColor, tipo, i, j, treD);
          griglia[i][j]=0;
        }
      }
    }
  }
  else // remove fill grid
  {
    for (int i=0; i<gXmax; i++)
    {
      for (int j=0; j<gYmax; j++)
      {
        if (griglia[i][j] == 0)
        {
          putChiodino((dim/2)+i*dim, (dim/2)+j*dim, dim-2, curColor, 2, i, j, treD);
          griglia[i][j]=0;
        }
      }
    }
  }
}

// *************************
// gridView FUNCTION
// *************************
void gridView()
{
  GRID = !(GRID);
  if (GRID) // show grid points
  {
    background(backC);
    drawButtons();
    updateButtons();
    updateSaveButton();
    drawABC();
    drawSpectrum();
    drawUserPalette();
    drawWebPalette();
    if (BACK)
    {
      image(backIMG, 0, 0, width, height-panelH);
    }
    drawGrid(dim/2, width, height-panelH, dim);
    // draw ColorBox and Color Text
    updateCurrentColorGUI();
    drawChiodini();
  }
  else     // hide grid points
  {
    background(backC);
    drawButtons();
    updateButtons();
    updateSaveButton();
    drawABC();
    drawSpectrum();
    drawUserPalette();
    drawWebPalette();
    if (BACK)
    {
      image(backIMG, 0, 0, width, height-panelH);
    }
    // draw ColorBox and Color Text
    updateCurrentColorGUI();
    drawChiodini();
  }
}


// *************************
// controlImage FUNCTION
// *************************
void controlImage()
{
  BACK = !(BACK);
  if (BACK) // show image
  {
    image(backIMG, 0, 0, width, height-panelH);
    if (GRID)
    {
      drawGrid(dim/2, width, height-panelH, dim);
    }
    drawChiodini();
  }
  else  // redraw ALL
  {
    background(backC);
    drawButtons();
    updateButtons();
    updateSaveButton();
    drawABC();
    drawSpectrum();
    drawUserPalette();
    drawWebPalette();
    if (GRID)
    {
      drawGrid(dim/2, width, height-panelH, dim);
    }
    // draw ColorBox and Color Text
    updateCurrentColorGUI();
    drawChiodini();
  }
}

// *************************
// controlImage FUNCTION
// *************************
void showHelp()
{
    HELP = (!HELP);
    if (HELP)
    {
      //draw window help
      rectMode(CENTER);
      strokeWeight(linea);
      stroke(0);
      fill(0,0,0,210);
      rect(width/2,(height-panelH)/2,900,590);
      fill(240,240,240,255);
      rectMode(CORNER);
      //load and show help file (help.txt);
      String lines[] = loadStrings("help.txt");
      for (int i=0; i < lines.length; i++)
      {
        text(lines[i],width/2-370,height/2-295-28+i*12);
      }
    }
    else
    {
      // redraw all
      background(backC);
      drawButtons();
      updateButtons();
      drawABC();
      drawSpectrum();
      drawUserPalette();
      drawWebPalette();
      if (BACK)
      {
        image(backIMG, 0, 0, width, height-panelH);
      }
      if (GRID)
      {
        drawGrid(dim/2, width, height-panelH, dim);
      }
      // draw ColorBox and Color Text
      updateCurrentColorGUI();
      drawChiodini();
    }
}


// **********************
// timestamp FUNCTION
// **********************
String timestamp()
{
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}


// *************************
// loadUserPalette FUNCTION
// *************************
void loadUserPalette()
{
  String colori[] = loadStrings("userPalette.txt");
  for (int i=0; i < colori.length; i++)
  {
   userPal[i] = color(unhex(colori[i])|0xff000000);
  }
  drawUserPalette();
}


// ******************
// winZoom FUNCTION
// ******************
void winZoom()
{
  PImage imgZoom;
  int zoomFactor = 16;
  int cx=0, cy=0, ex=0, ey=0;
  int xz = mouseX-zoomFactor/2;
  int yz = mouseY-zoomFactor/2;
  if ( xz < 0) {xz = 0; }
  if ( yz < 0) {yz = 0; }
  if ( xz > width-zoomFactor)  {xz = width-zoomFactor; }
  if ( yz > height-zoomFactor) {yz = height-zoomFactor; }
  imgZoom = get(xz,yz,zoomFactor,zoomFactor);
  cx = width-526; cy = height-panelH+2; ex = cx+94/2; ey = cy+94/2;
  image(imgZoom,cx,cy,94,94);
  // draw black rect border
  stroke(0,0,0,255);
  strokeWeight(1);
  noFill();
  rectMode(CORNER);
  rect(cx,cy,94,94);
  rectMode(CENTER);
  // draw center point
  noStroke();
  fill(0);
  ellipse(ex,ey,2,2);
}


// ******************
// resetGrid FUNCTION
// ******************
void resetGrid()
{
  int nn=0;
    for (int i=0; i<gXmax; i++)
    {
      for (int j=0; j<gYmax; j++)
      {
        griglia[i][j] = 0;
        colGriglia[i][j] = 0;
        tipoGriglia[i][j] = 0;
        treDGriglia[i][j] = 0;
      }
    }
}