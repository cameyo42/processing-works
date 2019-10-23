// ***************************
// ***************************
// KEYBOARD INTERACTION
// ***************************
// ***************************
void keyPressed()
{

// KLONE IMAGE
  if (key=='u' || key=='U')
  {
    if (BACK){}
    for (int i=0; i<gXmax; i++)
    {
      for (int j=0; j<gYmax; j++)
      {
        color copyColor = get((dim/2)+i*dim,(dim/2)+j*dim);
        // draw chiodino
        fill(copyColor);
        noStroke();
        ellipse((dim/2)+i*dim, (dim/2)+j*dim, dim, dim);
        rectMode(CENTER);
        rect((dim/2)+i*dim, (dim/2)+j*dim, dim-1, dim-1);
        rectMode(CORNER);
        griglia[i][j] = 1;
        colGriglia[i][j] = copyColor;
        tipoGriglia[i][j] = 1;
      }
    }
  }


  if (key=='h' || key=='H')
  {
    showHelp();
  }

// load user palette text file
  if (key=='l' || key=='L')
  {
    loadUserPalette();
  }

// show/hide grid points
  if (key=='g' || key=='G')
  {
    gridView();
  }

// show/hide fill grid with current color
  if (key=='f' || key=='F')
  {
    if (!BACK) { colorFILL(); }
  }

// new draw -> clear board
  if (key=='n' || key=='N')
  {
    if (!newyes)
    {
      newyes = true;
      fill(230,10,10);
      text("(y/n)",width-325, height-11);
    }
    else
    {
      rectMode(CORNER);
      fill(backC);
      noStroke();
      rect(width-326, height-22,32,15);
      newyes = false;
    }
  }

  if (key=='y' || key=='Y')
  {
    if (newyes)
    {
      newyes = false;
      init();
    }
  }

// 3D effect flag
  if (key=='d' || key=='D')
  {
    if (treD == 0) { treD = 1; }
    else { treD = 0; }
    updateButtons();
  }

// show/hide zoom window
  if (key=='z' || key=='Z')
  {
    ZOOM = !ZOOM;
  }

// show/hide image background
  if (key=='i' || key=='I')
  {
    controlImage();
  }

// change chiodini dimension (and reset image)
// works only with BLANK (new) grid
  if ((key=='1') && !(wip)) { dim =  5; init(); }
  if ((key=='2') && !(wip)) { dim = 10; init(); }
  if ((key=='3') && !(wip)) { dim = 15; init(); }
  if ((key=='4') && !(wip)) { dim = 20; init(); }
  if ((key=='5') && !(wip)) { dim = 25; init(); }
  if ((key=='6') && !(wip)) { dim = 30; init(); }
  if ((key=='7') && !(wip)) { dim = 50; init(); }

// type of chiodini
  // Circle type
  if (key=='c' || key=='C')
  {
    tipo = 0; oldTipo = 0;
    updateButtons();
  }

  // Rect type
  if (key=='r' || key=='R')
  {
    tipo = 1; oldTipo = 1;
    updateButtons();
  }

  // Erase type
  if (key=='e' || key=='E')
  {
    if (tipo == 2)
    {
      tipo = oldTipo;
    }
    else
    {
      tipo = 2;
    }
    updateButtons();
  }

// pick color status
  if (key=='p' || key=='P')
  {
    pickColor = !(pickColor);
    updateButtons();
  }

// load image
  if (key=='o' || key=='O')
  {
    noLoop();
    selectInput("Select a file to load...", "loadDATA");
    dlgInput = true;
    //loadDATA();
  }

// save image
  if (key=='s' || key=='S')
  {
    noLoop();
    selectOutput("Select file to save...", "saveALL");
    dlgOutput = true;
    //saveALL();
  }

  if (key == CODED)
  {
    if (wip)
    {
    if ((griglia[gX][gY] == 0) || (tipo == 2))
    {
      putChiodino(pX,pY,dim-2,curColor,tipo, gX, gY, treD);
    }

    if (keyCode == DOWN)
    {
       if (gY < (gYmax-1))
       {
         gX = gX;
         gY = gY + 1;
         pX = dim/2+dim*(gX);
         pY = dim/2+dim*(gY);
         if ((griglia[gX][gY] == 0) || (tipo == 2))
         {
           putChiodino(pX,pY,dim-2,curColor,tipo, gX, gY, treD);
         }
       }
    }
    else if (keyCode == UP)
    {
      if (gY > 0)
      {
        gX = gX;
        gY = gY - 1;
        pX = dim/2+dim*(gX);
        pY = dim/2+dim*(gY);
        if ((griglia[gX][gY] == 0) || (tipo == 2))
        {
          putChiodino(pX,pY,dim-2,curColor,tipo, gX, gY, treD);
        }
      }
    }
    else if (keyCode == LEFT)
    {
      if (gX > 0)
      {
        gX = gX - 1;
        gY = gY;
        pX = dim/2+dim*(gX);
        pY = dim/2+dim*(gY);
        if ((griglia[gX][gY] == 0) || (tipo == 2))
        {
          putChiodino(pX,pY,dim-2,curColor,tipo, gX, gY, treD);
        }
      }
    }
    else if (keyCode == RIGHT)
    {
      if (gX < (gXmax-1))
      {
        gX = gX + 1;
        gY = gY;
        pX = dim/2+dim*(gX);
        pY = dim/2+dim*(gY);
        if ((griglia[gX][gY] == 0) || (tipo == 2))
        {
          putChiodino(pX,pY,dim-2,curColor,tipo, gX, gY, treD);
        }
      }
    }
    } //wip
  }//coded

}

// ***************************
// ***************************
// MOUSE INTERACTION
// ***************************
// ***************************

// ***************************
// mousePressed()
// ***************************
void mousePressed()
{
  if (mouseY < height - panelH)
  {
    // calculate positions
    gX = mouseX/dim;
    gY = mouseY/dim;
    pX = dim/2+dim*(mouseX/dim);
    pY = dim/2+dim*(mouseY/dim);
//  println(mouseX+" -  "+mouseY);
//  println(gX+" -  "+gY);
//  println(pX+" -  "+pY);
  }

  // draw chiodino with active color
  if (!(pickColor) && (mouseY < height - panelH))
  {
    if ((griglia[gX][gY] == 0) || (tipo == 2))
    {
      putChiodino(pX,pY,dim-2,curColor,tipo, gX, gY, treD);
    }
  }
  // OR pick panel menu item
  else if (!(pickColor) && (mouseY > height - panelH))
  {
    // println("panel menu...");
    // pick raimbow color palette
    if (mouseX > (width-258+15) && mouseX < (width-258+15+2*palH) && mouseY > (height-panelH+2) && mouseY < (height-panelH+2+palH))
    {
      curColor = get(mouseX,mouseY);
      // draw ColorBox and Color Text
      updateCurrentColorGUI();
    }
    // pick user color palette
    if (mouseX > (width-416) && mouseX < (width-416+75) && mouseY > (height-panelH+2) && mouseY < (height-panelH+2+75))
    {
      curColor = get(mouseX,mouseY);
      // draw ColorBox and Color Text
      updateCurrentColorGUI();
    }
    // pick web safe color palette
    if (mouseX > (width-1010) && mouseX < (width-1010+467) && mouseY > (height-panelH+2) && mouseY < (height-panelH+2+77))
    {
      curColor = get(mouseX,mouseY);
     // draw ColorBox and Color Text
     updateCurrentColorGUI();
    }
    // pick erase
    if (mouseX > (width-30-7) && mouseX < (width-30+7) && mouseY > (height-panelH/2-30-7) && mouseY < (height-panelH/2-30+7))
    {
      if (tipo == 2)
      {
        tipo = oldTipo;
      }
      else
      {
        tipo = 2;
      }
      updateButtons();
    }
    // pick pick button
    if (mouseX > (width-30-7) && mouseX < (width-30+7) && mouseY > (height-panelH/2+28-7) && mouseY < (height-panelH/2+28+7))
    {
      pickColor = !(pickColor);
      updateButtons();
    }
    // pick circle button
    if (mouseX > (width-300-7) && mouseX < (width-300+47) && mouseY > (height-panelH/2-38-7) && mouseY < (height-panelH/2-38+7))
    {
      tipo = 0; oldTipo = 0;
      updateButtons();
    }
    // pick square button
    if (mouseX > (width-300-7) && mouseX < (width-300+47) && mouseY > (height-panelH/2-14-7) && mouseY < (height-panelH/2-14+7))
    {
      tipo = 1; oldTipo = 1;
      updateButtons();
    }
    // pick 3D button
    if (mouseX > (width-329) && mouseX < (width-329+10) && mouseY > (height-panelH+18) && mouseY < (height-panelH+18+10))
    {
      if (treD == 0) { treD = 1; }
      else { treD = 0; }
      updateButtons();
    }
    // pick load button
    if (mouseX > (width-310-14) && mouseX < (width-301+14) && mouseY > (height-panelH/2+14-7) && mouseY < (height-panelH/2+14+7))
    {
      noLoop();
      selectInput("Select a file to load...", "loadDATA");
      dlgInput = true;      
      //loadDATA();
    }
    // pick save button
    if (mouseX > (width-274-14) && mouseX < (width-274+14) && mouseY > (height-panelH/2+14-7) && mouseY < (height-panelH/2+14+7))
    {
    noLoop();
    selectOutput("Select file to save...", "saveALL");
    dlgOutput = true;
      //saveALL();
    }
    // pick new button
    if (mouseX > (width-274-14) && mouseX < (width-274+14) && mouseY > (height-panelH/2+35-7) && mouseY < (height-panelH/2+35+7))
    {
      if (!newyes)
      {
        newyes = true;
        fill(240,10,10);
        text("(y/n)",width-325, height-11);
      }
    }
    // pick load colors button
    if (mouseX > (width-378-37) && mouseX < (width-378+37) && mouseY > (height-11-7) && mouseY < (height-11+7))
    {
      loadUserPalette();
    }
    // pick zoom button
    if (mouseX > (width-526) && mouseX < (width-526+94) && mouseY > (height-panelH+2) && mouseY < (height-panelH+2+94))
    {
      ZOOM=!ZOOM;
    }
    // pick fill button
    if (mouseX > (width-803) && mouseX < (width-803+39) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+14))
    {
      if (!BACK) { colorFILL(); }
    }
    // pick grid button
    if (mouseX > (width-738) && mouseX < (width-738+39) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+14))
    {
      gridView();
    }
    // pick image button
    if (mouseX > (width-673) && mouseX < (width-673+39) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+14))
    {
      controlImage();
    }
    // pick chiodini dimension
    if (mouseX > (188) && mouseX < (188+14) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+14))
    {
      if (!wip) { dim = 5; init(); }
    }
    // pick chiodini dimension
    if (mouseX > (208) && mouseX < (208+14) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+16))
    {
      if (!wip) { dim = 10; init(); }
    }
    // pick chiodini dimension
    if (mouseX > (232) && mouseX < (232+14) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+16))
    {
      if (!wip) { dim = 15; init(); }
    }
    // pick chiodini dimension
    if (mouseX > (256) && mouseX < (256+14) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+16))
    {
      if (!wip) { dim = 20; init(); }
    }
    // pick chiodini dimension
    if (mouseX > (280) && mouseX < (280+14) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+16))
    {
      if (!wip) { dim = 25; init(); }
    }
    // pick chiodini dimension
    if (mouseX > (304) && mouseX < (304+14) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+16))
    {
      if (!wip) { dim = 30; init(); }
    }
    // pick chiodini dimension
    if (mouseX > (328) && mouseX < (328+14) && mouseY > (height-panelH+83) && mouseY < (height-panelH+83+16))
    {
      if (!wip) { dim = 50; init(); }
    }
    // pick HELP button
    if (mouseX > (142) && mouseX < (142+36) && mouseY > (height-panelH+2) && mouseY < (height-panelH+2+28))
    {
      showHelp();
    }

  }
  // OR pick color anywhere from window
  else if (pickColor)
  {
    curColor = get(mouseX,mouseY);
    pickColor = !(pickColor);
    updateButtons();
    // draw ColorBox and Color Text
    updateCurrentColorGUI();
  }

}


// ***************************
// mouseMoved()
// ***************************
//void mouseMoved()
//{
//  println((mouseY)/dim+" -  "+(mouseX)/dim);
//}


// ***************************
// mouseDragged()
// ***************************
void mouseDragged()
{
  // draw chiodino with active color
  if (!(pickColor) && (mouseY < height - panelH))
  {
    gX = mouseX/dim;
    gY = mouseY/dim;
    pX = dim/2+dim*(mouseX/dim);
    pY = dim/2+dim*(mouseY/dim);
//  println(mouseX+" -  "+mouseY);
//  println(gX+" -  "+gY);
//  println(pX+" -  "+pY);
    if ((gX > -1) && (gX < 250) && (gY > -1) && (gY < 250))
    {
      if ((griglia[gX][gY] == 0) || (tipo == 2))
      {
        putChiodino(pX,pY,dim-2,curColor,tipo,gX,gY,treD);
      }
    }
  }

}