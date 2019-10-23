//*********************************
// zoom canvas
// draw zoom window at mouse cursor
void showZoom(float zoomFactor)
{
  // draw zoom window at mouse cursor
  int x = mouseX;
  int y = mouseY;
  int u, v;
  int xsize = 250;
  int ysize = 250;
  canvasIMG = get(0,0,width,height);
  for (int vd = - ysize; vd < ysize; vd++)
  {
    for (int ud = - xsize; ud < xsize; ud++)
    {
        u = floor(ud/zoomFactor) + mouseX;
        v = floor(vd/zoomFactor) + mouseY;
        if (u >= 0 && u < canvasIMG.width && v >= 0 && v < canvasIMG.height)
          { set(ud + x, vd + y, canvasIMG.get(u, v)); }
    }
  }
  // draw zoom window border
  noFill();
  stroke(255,30,30,100);
  rectMode(CENTER);
  rect(mouseX,mouseY,2*xsize,2*ysize);
  rectMode(CORNER);
}