void drawGUI()
{
  println("draw GUI");
  pushStyle();
  // draw rect (bottom panel and line)
  noStroke();
  fill(#002b36);
  rect(0,height-panelH,width,panelH);
  stroke(#839496);
  line(0,height-panelH,width,height-panelH);
  //fill(#eee8d5);
  
  // show image formulae
  image(curveImg[curveNum],8, height-panelH+10);
  
  // draw palette colors
  stroke(0);
  for (int i=0; i < 8; i++)
  {
    fill(base[i]);
    rect(px+(i*side),py,side,side);
  }
  for (int i=0; i < 8; i++)
  {
    fill(hues[i]);
    rect(px+(i*side),py+side,side,side);
  }
  
  // draw current color swatch
  fill(col);
  rect(px- side, py, side/2, 2*side);
  
  // draw text center of curve coordinates
  fill(#93a1a1);
  text("center=("+int(xc)+","+int(yc)+")", width - 300, height - panelH + 16);
  
  // TODO: set alpha for col 
  
  // draw buttons
  if (start) { btnGO.t = "STOP"; btnGO.c1 = 160; btnGO.c2 = #ff1111; }
  else { btnGO.t = "START"; btnGO.c1 = 100; btnGO.c2 = 0; }
  if (curveNum==0) { btnCUR0.c2 = #fdf6e3; }
  else { btnCUR0.c2 = 0; }
  if (curveNum==1) { btnCUR1.c2 = #fdf6e3; }
  else { btnCUR1.c2 = 0; }
  if (curveNum==2) { btnCUR2.c2 = #fdf6e3; }
  else { btnCUR2.c2 = 0; }
  if (saved) { btnSAVE.c1 = 155; }
  else { btnSAVE.c1 = 100; }
  btnGO.show();  
  btnSAVE.show();
  
  btnCLEAR.show();
  btnCUR0.show();
  btnCUR1.show();
  btnCUR2.show();
  btnRND.show();

  // draw spinners
  spnSTEP.show();
  fill(#93a1a1);
  text("resolution",730, height-27);
  // generic curve
  if (curveNum==0)
  {
    spnA.show();
    spnB.show();
    spnC.show();
    spnD.show();
    spnP1.show();
    spnP2.show();
    spnP3.show();
    spnP4.show();
    spnI.show();
    spnJ.show();
    spnM.show();
    spnN.show();
    // spinners text
    fill(#eee8d5);
    text("a",415+27, height-panelH+19);
    text("b",484+27, height-panelH+19);
    text("d",621+27, height-panelH+19);
    text("c",553+27, height-panelH+19);
    text("p1",415+25, height-panelH+45);
    text("p2",484+25, height-panelH+45);
    text("p3",553+25, height-panelH+45);
    text("p4",621+25, height-panelH+45);
    text("i",415+27, height-panelH+75);
    text("j",484+27, height-panelH+74);
    text("m",553+25, height-panelH+75);
    text("n",621+25, height-panelH+75);
  }
  // hypotrochoid or epitrochoid curve
  if ((curveNum==1)||(curveNum==2))
  {  
    spnR.show();
    spnr.show();
    spnH.show();
    // spinners text
    text("R",460, height-panelH+55);
    text("r",546, height-panelH+55);
    text("h",630, height-panelH+55);
  }  
  popStyle();
  
}