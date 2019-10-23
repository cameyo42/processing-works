void drawGUI()
{
  // draw image
  image(img, 0, 0);
  
  // draw black lines (panels)
  stroke(0);
  line(width - Lpanel, 0, width - Lpanel, height);
  line(Rpanel, 0, Rpanel, height);

  // draw title  
  image(title,0,6);

  // draw thumbnail
  showThumb(curThumb);
  
  // draw color palette
  image(pals[curPal], width-Rpanel+6, 70);
  
  // draw current swatch color
  stroke(0);
  fill(curCol);
  rect(width-Rpanel+6, 5, 128, 60);

  // draw buttons
  btnPLUS.show();
  btnMINUS.show();
  btnWhiteFILL.show();
  btnRND.show();
  btnSimmetryFILL.show();
  btnSAVE.show();  
  btnLOAD.show();  
  cbPick.show();
  
  //draw zoom window
  winZoom(); 
}

void showThumb(int idx)
{ 
  float imgX, imgY;
  float lenX, lenY;
  // thumbnail position
  imgX = 4;
  imgY = height/2;
  // thumbnail rect dimension (cornice)
  lenX = 130;
  lenY = 130;
  // draw rect (cornice)
  stroke(0);
  fill(100);
  //strokeWeight(1);
  rect(imgX-2, imgY-2,  lenX+4, lenY+4);
  // show thumbnail
  imageMode(CENTER);
  image(thumbs[idx], imgX+lenX/2, imgY+lenY/2);
  imageMode(CORNER);

}  

void winZoom()
{
  PImage imgZoom;
  int zoomFactor = 8;
  int cx=0, cy=0, ex=0, ey=0;
  // int xz = mouseX-zoomFactor/2;
  // int yz = mouseY-zoomFactor/2;
  int xz = mouseX-zoomFactor/2;
  int yz = mouseY-zoomFactor/2;  
  if ( xz < 0) {xz = 0; }
  if ( yz < 0) {yz = 0; }
  if ( xz > width-zoomFactor)  {xz = width-zoomFactor; }
  if ( yz > height-zoomFactor) {yz = height-zoomFactor; }
  cx = width-Rpanel+11; cy = height-124; ex = cx+120/2; ey = cy+120/2;
  // draw black rect border
  stroke(0);
  fill(100);
  rectMode(CORNER);
  rect(cx-1,cy-1,121,121);
  if (zoom)
  {
    // show zoom image
    imgZoom = get(xz,yz,zoomFactor,zoomFactor);
    image(imgZoom,cx,cy,120,120);
    // draw center point
    noStroke();
    fill(255,0,0);
    ellipse(ex,ey,3,3);    
  }
  else
  {  
    // draw text
    fill(0);
    text("Zoom window", width - Rpanel/2, height - 60);  
  }

}