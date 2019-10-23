// GUI.pde
// (texter.pde)
// by cameyo 2014
// for processing 1.5.1
//
// library: generativedesign

// based on sketch: P_2_3_3_01_TABLET_TOOL.pde
// by Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// from book: Generative Gestaltung, ISBN: 978-3-87439-759-9
//            First Edition, Hermann Schmidt, Mainz, 2009
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

void drawMenu()
{
  // draw menu rectangle
  strokeWeight(1);
  stroke(0);
  fill(60);
  rect(0,height-menuHEIGHT,width-1,menuHEIGHT-1);

  // draw color palette
  drawUserPalette();
  drawSpectrum();

  // draw current font gliph
  textFont(font,newFontSize);
  if (newFontSize > 100) { textFont(font,100); }
  fill(fontColor,fontAlpha);
  textAlign(CENTER,CENTER);
//  text("Font",18,height-18);
  text("Font",140,height-68);
  textAlign(LEFT);

  // draw size Font value
  fill(255);
  textFont(infoFont,10);
  text(int(newFontSize),2,height-2);

  // draw current font name
  textAlign(CENTER);
  text(namefont[fontNum],454,height-3);
  textAlign(LEFT);

  // draw angle Font value
  text(nfs(angleDistortion,1,1),98,height-2);

  //draw "clear screen" button
  noFill();
  stroke(255,0,0);
  rect(2,height-98,9,9);
  rect(4,height-96,5,5);
  rect(6,height-94,1,1);

  // draw - font size button
  noFill();
  stroke(255);
  rect(2,height-62,10,10);
  line(4,height-57,10,height-57);
  // draw + font size button
  rect(2,height-46,10,10);
  line(4,height-41,10,height-41);
  line(7,height-44,7, height-38);

  // draw - font angle button
  rect(50,height-13,10,10);
  line(50,height-13,60,height-3);
  // draw = font angle button
  rect(66,height-13,10,10);
  line(66,height-8,76,height-8);
  // draw + font angle button
  rect(82,height-13,10,10);
  line(92,height-13,82,height-3);

  // draw tablet button (on/off)
  if (wacom) { stroke(255,128,0); }
  else { stroke(255); }
  rect(150,height-13,10,10);
  ellipse(155,height-8,2,2);

  // draw image button (show/hide)
  if (showImage) { stroke(255,128,0); }
  else { stroke(255); }
  rect(170,height-13,10,10);
  ellipse(173,height-10,2,2);
  ellipse(177,height-10,2,2);
  ellipse(173,height-6,2,2);
  ellipse(177,height-6,2,2);
  stroke(255);

  // draw delete char button
  rect(190,height-13,20,10);
  line(192,height-8,208,height-8);
  line(192,height-8,194,height-10);
  line(192,height-8,194,height-6);

  // draw save color button (pdf)
  rect(240,height-13,16,10);
  rect(242,height-11,12,6);
  rect(244,height-9,8,2);

  // draw save color button (png)
  rect(265,height-13,16,10);
  rect(267,height-11,5,6);
  rect(274,height-11,5,6);

  // draw help button
  noFill();
  stroke(40,150,10);
  rect(358,height-13,34,10);
  stroke(255);
  rect(360,height-11,6,6);
  rect(368,height-11,6,6);
  rect(376,height-11,6,6);
  rect(384,height-11,6,6);

  // SHIFT led button
  rect(310,height-13,6,10);

  // CTRL led button
  rect(322,height-13,6,10);

  // draw background color button
  fill(fontColor);
  rect(width-201,height-96,11,76);
  
  // draw random color font button
  noFill();
  if (rndCol) { stroke(255,128,0); }
  else {stroke(255); }
  rect(width-201,height-16,11,11);
  noStroke();
  int px=width-200;  
  int py=height-15;
  int cl=0;
  for(int j=0; j<5; j++)
  {
    for(int i=0; i<5; i++)
    {
      fill(userPal[cl]);
      rect(px+i*2,py+j*2,2,2);
      cl++;
    }  
  }  

  // draw load palette button
  noFill();
  stroke(180);
  rect(width-282,height-16,76,11);
  stroke(0);
  rect(width-280,height-14,72,7);
  stroke(180);
  rect(width-278,height-12,68,3);

  // draw info window
  stroke(120);
  rect(width/2-85,height-90,170,16);
  if (!showPopup)
  {
    fill(120);
    textAlign(CENTER);
    textFont(infoFont);
    text(creator,1+width/2,height-77);
  }
  stroke(255);
  noFill();

  // draw font buttons
  // 01
  if (fontNum==1) { stroke(255,128,0); }
  else { stroke(255); }
  rect(430,height-62,11,11);
  rect(435,height-57,1,1);
  // 02
  if (fontNum==2) { stroke(255,128,0); }
  else { stroke(255); }
  rect(448,height-62,11,11);
  rect(450,height-54,1,1);
  rect(456,height-60,1,1);
  // 03
  if (fontNum==3) { stroke(255,128,0); }
  else { stroke(255); }
  rect(466,height-62,11,11);
  rect(468,height-54,1,1);
  rect(471,height-57,1,1);
  rect(474,height-60,1,1);
  // 04
  if (fontNum==4) { stroke(255,128,0); }
  else { stroke(255); }
  rect(430,height-44,11,11);
  rect(432,height-42,1,1);
  rect(438,height-42,1,1);
  rect(432,height-36,1,1);
  rect(438,height-36,1,1);
  // 05
  if (fontNum==5) { stroke(255,128,0); }
  else { stroke(255); }
  rect(448,height-44,11,11);
  rect(450,height-42,1,1);
  rect(456,height-42,1,1);
  rect(453,height-39,1,1);
  rect(450,height-36,1,1);
  rect(456,height-36,1,1);
  // 06
  if (fontNum==6) { stroke(255,128,0); }
  else { stroke(255); }
  rect(466,height-44,11,11);
  rect(468,height-42,1,1);
  rect(474,height-42,1,1);
  rect(468,height-39,1,1);
  rect(474,height-39,1,1);
  rect(468,height-36,1,1);
  rect(474,height-36,1,1);
  // 07
  if (fontNum==7) { stroke(255,128,0); }
  else { stroke(255); }
  rect(430,height-26,11,11);
  rect(432,height-24,1,1);
  rect(438,height-24,1,1);
  rect(471,height-24,1,1);
  rect(432,height-21,1,1);
  rect(435,height-21,1,1);
  rect(438,height-21,1,1);
  rect(432,height-18,1,1);
  rect(438,height-18,1,1);
  // 08
  if (fontNum==8) { stroke(255,128,0); }
  else { stroke(255); }
  rect(448,height-26,11,11);
  rect(450,height-24,1,1);
  rect(453,height-24,1,1);
  rect(456,height-24,1,1);
  rect(450,height-21,1,1);
  rect(456,height-21,1,1);
  rect(450,height-18,1,1);
  rect(453,height-18,1,1);
  rect(456,height-18,1,1);
  // 09
  if (fontNum==9) { stroke(255,128,0); }
  else { stroke(255); }
  rect(466,height-26,11,11);
  rect(468,height-24,1,1);
  rect(471,height-24,1,1);
  rect(474,height-24,1,1);
  rect(468,height-21,1,1);
  rect(471,height-21,1,1);
  rect(474,height-21,1,1);
  rect(468,height-18,1,1);
  rect(471,height-18,1,1);
  rect(474,height-18,1,1);
  
  // draw text random button
  if (rndFont) { stroke(255,128,0); }
  else { stroke(255); }
  rect(486, height-62, 10, 47);
  //for(int i=1; i<36; i++) { rect(488+random(0,6),height-60+random(0,43),1,1); }
  line(491,height-56,491,height-21);

  // draw text kerning slider
  stroke(255);
  line(275,height-76,375,height-76);
  fill(255);
  float kx = map(kerning,1,3,275,375);
  ellipse(kx,height-76,6,6);
  fill(255);
  textFont(infoFont,10);
  textAlign(CENTER);
  text(nfs(kerning,1,1),kx,height-81);

  // draw text alpha slider
  stroke(255);
  line(275,height-26,410,height-26);
  fill(255,fontAlpha);
  float ax = map(fontAlpha,0,255,275.0,410.0);
  ellipse(ax,height-26,6,6);
  fill(255);
  textFont(infoFont,10);
  textAlign(CENTER);
  text(fontAlpha,ax,height-31);

  // draw text size slider
  if (newFontSize > 100)
  {
    stroke(255);
    line(275,height-51,275+68,height-51);
    stroke(255,0,0);
    line(275+69,height-51,410,height-51);
  }
  else
  {
    stroke(255);
    line(275,height-51,410,height-51);
  }
  fill(255);
  float sx = map(newFontSize,fontSizeMin,fontSizeMax,275,410);
  ellipse(sx,height-51,6,6);
  fill(255);
  textFont(infoFont,10);
  textAlign(CENTER);
  text(int(newFontSize),sx,height-56);

  // draw image move window and point inside
  noFill();
  stroke(255);
  rect(515, height-62, 47*width/(height-menuHEIGHT),47);
  //println(47*width/(height-menuHEIGHT));
  float ix = map(xIMG,0,width, 516, 515+47*width/(height-menuHEIGHT));
  float iy = map(yIMG,0,height-menuHEIGHT, height-62+1, height-62+47);
  if (showImage) { stroke(255,128,0); fill(255,128,0); }
  else { stroke(255); fill(255); }
  ellipse(ix,iy,4,4);
  // draw image coords
  fill(255);
  textFont(infoFont,10);
  text(xIMG+" - "+yIMG,(515+(47*width/(height-menuHEIGHT))/2),height-3);
  
  // draw open image button
  noFill();
  stroke(255);
  rect(605, height-13,21,10);
  rect(607, height-11, 2,2);
  rect(612, height-11, 2,2);  
  rect(617, height-11, 2,2);    
  rect(622, height-11, 2,2);      
  rect(607, height-7, 2,2);  
  rect(612, height-7, 2,2);  
  rect(617, height-7, 2,2);    
  rect(622, height-7, 2,2);    
  
  // draw INVERT image button
  rect(608, height-54,11,11);
  stroke(0);
  rect(609, height-53,9,9);  
  stroke(255);  
  rect(610, height-52,7,7);      
  stroke(0);  
  rect(611, height-51,5,5);        
  stroke(255);  
  rect(612, height-50,3,3);          
  stroke(0);  
  rect(613, height-49,1,1);          

  // draw GRAYSCALE image button
  stroke(255);
  rect(608, height-34,11,11);
  noStroke();
  fill(50);
  rect(609, height-33,5,5);
  fill(150);
  rect(614, height-33,5,5);  
  fill(200);
  rect(609, height-28,5,5);    
  fill(100);
  rect(614, height-28,5,5);      
  
  // draw open text file button
  noFill();
  stroke(255);
  rect(443, height-84,21,10);  
  line(446, height-84, 446, height-74);
  line(449, height-84, 449, height-74);  
  line(452, height-84, 452, height-74);  
  line(455, height-84, 455, height-74);  
  line(458, height-84, 458, height-74);    
  line(461, height-84, 461, height-74);        
  
  // draw alpha image slider
  line(635,height-26,770,height-26);  
  fill(255,imgAlpha);
  float aix = map(imgAlpha,1,255,635,770);
  if (showImage) { stroke(255,128,0); }  
  rect(aix-3,height-26-3,6,6);
  fill(255);
  textFont(infoFont,10);
  textAlign(CENTER);
  text(imgAlpha,aix,height-31);  

  // draw Threshold image slider
  stroke(255);
  line(635,height-51,770,height-51);
  float tix = map(imgTH,0,1,635,770);
  if (showImage) { stroke(255,128,0); }
  fill(255);  
  rect(tix-3,height-51-3,6,6);
  textFont(infoFont,10);
  textAlign(CENTER);
  text(nfs(imgTH,1,2),tix,height-56);  
  
  // draw zoom window
  stroke(180);  
  rect(width-365,height-menuHEIGHT+4,75,75);
  rect(width-366,height-menuHEIGHT+3,77,77);  
  int cx = width-365+38; 
  int cy = height-menuHEIGHT+5+37;
  stroke(180);
  line(cx-8,cy,cx+8,cy);
  line(cx,cy-8,cx,cy+8);  
  noStroke();
  fill(180);
//  noSmooth();
//  ellipse(cx,cy,3,3);  
//  smooth();
  rect(cx-1,cy-1,3,3);  
  stroke(255);

}


// *********************
// drawSpectrum FUNCTION
// *********************
void drawSpectrum()
{
  int palH=90;
  // draw color palette
  noStroke();
  colorMode(HSB, palH*2, palH, palH, 255);
  rectMode(CORNER);
  for (int i=15; i < (palH*2)+1; i+=15)
  {
    for (int j=30; j < palH+1; j+=15)
    {
      fill(i, j, 255);
      rect(width-200+i, height-menuHEIGHT-10+j, 15, 15);
    }
  }
  // draw grayscale palette
  colorMode(RGB, 200, 200, 200, 255);
  for (int i=0; i < 6; i+=1)
  {
    fill(i*40, i*40, i*40, 255);
    rect(width-200+15+i*30, height-menuHEIGHT+5, 30, 15);
  }
  // draw palette border
  colorMode(RGB,255,255,255,255);
  noFill();
  strokeWeight(1);
  stroke(0,0,0,255);
  rect(width-200+15,height-menuHEIGHT+4,2*palH,palH+1);
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
  uX = width-281;
  uY = height-menuHEIGHT+5;
  int k = 0;
  for (int j=0; j < 5; j++)
  {
    for (int i=0; i < 5; i++)    
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
  rect(uX-1,uY-1,76,76);
}