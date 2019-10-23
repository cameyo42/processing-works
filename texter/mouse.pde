// mouse.pde
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

//*********************
// MOUSE PRESSED
//*********************
void mousePressed()
{
//  undoIndex = drawItems.size();
//  println(undoIndex);
  canDraw=false;
  if (mouseY < (height-menuHEIGHT)) // click on canvas
  {
    canDraw=true;
    x = mouseX;
    y = mouseY;
    // remember click position
    //clickPosX = mouseX;
    //clickPosY = mouseY;
  }
  else // click on menu
  {
//    println("MENU");

    // pick main color palette
    if (mouseX > (width - 185) && mouseX < (width - 5) && mouseY > (height-95) && mouseY < (height-5))
    {
      fontColor = get(mouseX,mouseY);
      drawMenu();
    }

    // pick user color palette
    if (mouseX > (width - 281) && mouseX < (width - 205) && mouseY > (height-95) && mouseY < (height-19))
    {
      fontColor = get(mouseX,mouseY);
      drawMenu();
    }

    // pick "clear screen" button
    if (mouseX > 0 && mouseX < 12 && mouseY > (height-100) && mouseY < (height-100+12))
    {
      background(backColor);
      drawItems = new ArrayList();
      counter=0;
      drawMenu();
    }

    // pick + font size button
    if (mouseX > 1 && mouseX < 13 && mouseY > (height-47) && mouseY < (height-47+12))
    {
     newFontSize += 1;
     if (newFontSize > fontSizeMax) { newFontSize = fontSizeMax; }
     drawMenu();
    }
    // pick - font size button
    if (mouseX > 1 && mouseX < 13 && mouseY > (height-61) && mouseY < (height-61+12))
    {
     newFontSize -= 1;
     if (newFontSize < fontSizeMin) { newFontSize = fontSizeMin; }
     drawMenu();
    }

    // pick - font angle button
    if (mouseX > 49 && mouseX < 61 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      angleDistortion -= 0.1;
      drawMenu();
    }
    // pick reset font angle button
    if (mouseX > 65 && mouseX < 77 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      angleDistortion = 0;
      drawMenu();
    }
    // pick + font angle button
    if (mouseX > 81 && mouseX < 93 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      angleDistortion += 0.1;
      drawMenu();
    }

//  rect(150,height-13,10,10);
    // pick tablet button (on/off)
    if (mouseX > 149 && mouseX < 161 && mouseY > (height-14) && mouseY < (height-14+12))
    {
     wacom = !(wacom);
     if (wacom) { lastFontSize = newFontSize; }
     else { newFontSize = lastFontSize; }
     drawMenu();
    }
//  rect(170,height-13,10,10);
    // pick image button (show/hide)
    if (mouseX > 169 && mouseX < 181 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      showImage = !showImage;
      reDrawAllDrawItems();
      drawMenu();
    }
//  rect(190,height-13,20,10);
    // pick delete char button
    if (mouseX > 189 && mouseX < 211 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      undoDrawItem();
      reDrawAllDrawItems();
      drawMenu();
    }
//  rect(240,height-13,16,10);
    // pick save button (pdf)
    if (mouseX > 239 && mouseX < 257 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      savePDF=true;
    }

//  rect(265,height-13,16,10);
    // pick save button (png)
    if (mouseX > 264 && mouseX < 282 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      outIMG = get(0, 0, width, height-menuHEIGHT);
      outIMG.save(timestamp()+".png");
      saveFrame(timestamp()+"_##.png");
    }

//  rect(358,height-13,34,10);
    // pick help button
    if (mouseX > 357 && mouseX < 393 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      showHelp=!showHelp;
      if (showHelp==false) { eraseHelp=true; }
    }

//  rect(width-201,height-96,11,76);
    // pick background color button
    if (mouseX > (width-202) && mouseX < (width-202+13) && mouseY > (height-95) && mouseY < (height-95+76))
    {
      backColor=fontColor;
      reDrawAllDrawItems();
      drawMenu();
    }
    
//  rect(width-201,height-16,11,11);    
    // pick random font color
    if (mouseX > (width-202) && mouseX < (width-202+13) && mouseY > (height-15) && mouseY < (height-15+13))
    {
      rndCol=!rndCol;
      drawMenu();      
    }  
      
//  rect(width-282,height-16,76,11);      
    // pick load user palette button
    if (mouseX > (width-283) && mouseX < (width-283+78) && mouseY > (height-17) && mouseY < (height-17+13))
    {
      //loadUserPalette();    
      String pathFile;
      selectInput("select a palette file...","openPAL");
    }  


//  rect(width/2-85,height-90,170,16);
    // pick popup info button
    if (mouseX > (width/2-86) && mouseX < (width/2-86+172) && mouseY > (height-90-1) && mouseY < (height-90+18))
    {
      showPopup=(!showPopup);
      drawMenu();
    }

//  rect(430,height-62,11,11);
    // pick font 01 button
    if (mouseX > 429 && mouseX < 442 && mouseY > (height-62-1) && mouseY < (height-62+13))
    {
      fontNum=1;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }

//  rect(448,height-62,11,11);
    // pick font 02 button
    if (mouseX > 447 && mouseX < 460 && mouseY > (height-62-1) && mouseY < (height-62+13))
    {
      fontNum=2;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }

//  rect(466,height-62,11,11);
    // pick font 03 button
    if (mouseX > 465 && mouseX < 478 && mouseY > (height-62-1) && mouseY < (height-62+13))
    {
      fontNum=3;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }

//  rect(430,height-44,11,11);
    // pick font 04 button
    if (mouseX > 429 && mouseX < 442 && mouseY > (height-44-1) && mouseY < (height-44+13))
    {
      fontNum=4;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }

//  rect(448,height-44,11,11);
    // pick font 05 button
    if (mouseX > 447 && mouseX < 460 && mouseY > (height-44-1) && mouseY < (height-44+13))
    {
      fontNum=5;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }

//  rect(466,height-44,11,11);
    // pick font 06 button
    if (mouseX > 465 && mouseX < 478 && mouseY > (height-44-1) && mouseY < (height-44+13))
    {
      fontNum=6;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }

//  rect(430,height-26,11,11);
    // pick font 07 button
    if (mouseX > 429 && mouseX < 442 && mouseY > (height-26-1) && mouseY < (height-26+13))
    {
      fontNum=7;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }
//  rect(448,height-26,11,11);
    // pick font 08 button
    if (mouseX > 447 && mouseX < 460 && mouseY > (height-26-1) && mouseY < (height-26+13))
    {
      fontNum=8;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }
//  rect(466,height-26,11,11);
    // pick font 09 button
    if (mouseX > 465 && mouseX < 478 && mouseY > (height-26-1) && mouseY < (height-26+13))
    {
      fontNum=9;
      font = listfont[fontNum];
      drawMenu();
      println(font);
    }
    
//  rect(486, height-62, 10, 47);    
    // pick random font button
    if (mouseX > 485 && mouseX < 497 && mouseY > (height-62-1) && mouseY < (height-62+49))
    {
      rndFont=!rndFont;
      drawMenu();
    }
    
//  rect(605, height-13,21,10);    
    // pick load image button
    if (mouseX > 604 && mouseX < 627 && mouseY > (height-13-1) && mouseY < (height-13+12))
    {
      String pathFile;
      selectInput("select a background image...","openIMG");
    }    
    

//  rect(443, height-84,21,10);  
    // pick load text file button
    if (mouseX > 442 && mouseX < 465 && mouseY > (height-84-1) && mouseY < (height-84+12))
    {
      String pathFile;
      selectInput("select a text file...","openSTR");
    }
    
//  rect(608, height-54,11,11);    
  // pick INVERT image button
    if (mouseX > 607 && mouseX < 620 && mouseY > (height-54-1) && mouseY < (height-54+13))
    {  
      if (showImage)
      { 
        imgBase.filter(INVERT);
        img.filter(INVERT);
  //      imgBase.copy(img,0,0,img.width,img.height,0,0,img.width,img.height);       
        reDrawAllDrawItems();
        drawMenu();           
      }
    }        

//  rect(608, height-34,11,11);
    // pick GRAYSCALE image button
    if (mouseX > 607 && mouseX < 620 && mouseY > (height-34-1) && mouseY < (height-34+13))
    {  
      if (showImage)
      { 
        imgBase.filter(GRAY);
        img.filter(GRAY);
  //      imgBase.copy(img,0,0,img.width,img.height,0,0,img.width,img.height);       
        reDrawAllDrawItems();
        drawMenu();           
      }
    }        

//  rect(width-365,height-menuHEIGHT+4,75,75);
    // pick zoom window button
    if (mouseX > width-366 && mouseX < width-366+77 && mouseY > (height-menuHEIGHT+4-1) && mouseY < (height-menuHEIGHT+4-1+77))
    {
      zoom=!zoom;
      drawMenu();      
    }            
    
  }
}

//*********************
// MOUSE DRAGGED
//*********************
void mouseDragged()
{
  if (mouseY > (height-menuHEIGHT)) // drag on menu
  {
    float mx = mouseX;
    float my = mouseY;

    // kerning font slider
    // line(275,height-76,375,height-76);
    if (mouseX>260 && mouseX<390 && mouseY > height-76-13 && mouseY < height-76+9)
    {
      float kern = map(mx,275,375,1,3);
      if (kern > 3) { kern=3; }
      if (kern < 1) { kern=1; }
      kern=(round(kern*10))/10.0;
      kerning=kern;
      drawMenu();
    }

    // alpha font slider
    // line(275,height-26,410,height-26);
    if (mouseX>260 && mouseX<425 && mouseY > height-26-13 && mouseY < height-26+9)
    {
      float alfa = map(mx,275,410,1,255);
      if (alfa > 255) { alfa=255; }
      if (alfa < 1) { alfa=1; }
      fontAlpha=int(alfa);
      drawMenu();
    }

    // size font slider
    // line(275,height-51,410,height-51);
    if (mouseX>260 && mouseX<425 && mouseY > height-51-13 && mouseY < height-51+9)
    {
      float corpo = map(mx,275,410,fontSizeMin,fontSizeMax);
      if (corpo > fontSizeMax) { corpo=fontSizeMax; }
      if (corpo < fontSizeMin) { corpo=fontSizeMin; }
      newFontSize=int(corpo);
      drawMenu();
    }
    
    // alpha image slider
    // line(625,height-26,760,height-26);
    if (showImage && mouseX>630 && mouseX<775 && mouseY > height-26-13 && mouseY < height-26+9)
    {
      float alfa = map(mx,635,770,1,255);
      if (alfa > 255) { alfa=255; }
      if (alfa < 1) { alfa=1; }
      imgAlpha=int(alfa);
      reDrawAllDrawItems();
      drawMenu();
    }

    // threshold image font slider
    // line(625,height-51,760,height-51);
    if (showImage && mouseX>630 && mouseX<775 && mouseY > height-51-13 && mouseY < height-51+9)
    {
      float th = map(mx,635,770,0,1);
      if (th > 1) { th=1; }
      if (th < 0) { th=0; }
      th=(round(th*100))/100.0;      
      imgTH=th;
      img.copy(imgBase,0,0,imgBase.width,imgBase.height,0,0,imgBase.width,imgBase.height);
      img.filter(THRESHOLD,imgTH);          
      reDrawAllDrawItems();
      drawMenu();
    }    

    // image window movers
    // rect(515, height-62, 47*width/(height-menuHEIGHT),47);
    if (showImage && mouseX>510 && mouseX<(520+47*width/(height-menuHEIGHT)) && mouseY > height-62-5 && mouseY < height-62+47+5)
    {
      float px,py;
      px = map(mx,515,(515+47*width/(height-menuHEIGHT)),0,width);
      if (px > width) { px = width; }
      if (px < 0) { px = 0; }
      py = map(my,height-62,height-62+47,0,height-menuHEIGHT);
      if (py > height-menuHEIGHT) { py = height-menuHEIGHT; }
      if (py < 0) { py = 0; }
      xIMG=int(px);
      yIMG=int(py);
      reDrawAllDrawItems();
      drawMenu();
    }


  }
}