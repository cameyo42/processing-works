void drawGUI()
{
  //println("draw GUI");
  pushStyle();
  // draw Panel line
  stroke(#839496);
  line(0,height-panelH,width,height-panelH);
  // show image formula
  image(sfImg,2,height-60);
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
  rect(px - side, py, side/2, 2*side);  
  // draw buttons
  btnSAVE.show();
  btnRND.show();
  // draw spinners
  spnSTEP.show();
  spnFACT.show();
  spnA1.show(); spnB1.show(); spnM1.show(); spnN11.show(); spnN12.show(); spnN13.show(); 
  spnA2.show(); spnB2.show(); spnM2.show(); spnN21.show(); spnN22.show(); spnN23.show(); 
  // draw checkbox
  cbFlat.show(); cbWire.show(); cbPo3D.show();
  cbLight.show();
  // draw text
  fill(#eee8d5);
  text("SuperFormula 3D", 10, height-panelH+22);
  // sf (1)
  text("1",282,height-panelH+33);
  text("a",295+36, height-panelH+18);
  text("b",380+36, height-panelH+18);
  text("m",465+34, height-panelH+18);
  text("n1",550+34, height-panelH+18);
  text("n2",635+34, height-panelH+18);
  text("n3",720+34, height-panelH+18);
  // sf (2))
  text("2",282,height-panelH+67);  
  text("a",295+36, height-panelH+52);
  text("b",380+36, height-panelH+52);
  text("m",465+34, height-panelH+52);
  text("n1",550+34, height-panelH+52);
  text("n2",635+34, height-panelH+52);
  text("n3",720+34, height-panelH+52);  
  // resolution
  text("Resolution",296, height-panelH+90);
  // factor
  text("magnify factor",846, height-panelH+18);
  // end GUI  
}  