// keyboard.pde
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
// KEY RELEASED
//*********************
  void openIMG(File selection)
  {
    println(selection);
    if (selection != null)
    { 
      img = loadImage(selection.getAbsolutePath());
      showImage = true;
      opened=true;
      //reDrawAllDrawItems();
      //drawMenu();
      println(selection.getAbsolutePath());      
    }  
    loop();
  }

  void updateWINDOW()
  {
      showImage = true;
      reDrawAllDrawItems();
      drawMenu();  
  }
  
  void openSTR(File selection)
  {
    if (selection != null)
    { 
      txt = loadStrings(selection.getAbsolutePath());
      println(txt.length);
      for (int i=0; i < txt.length; i++)
      { println(txt[i]); }
 
      // concatenate lines
      letters="";
      for (int i=0; i < txt.length; i++)
      { letters=letters+txt[i]+" "; }
      //println(letters);
      counter=0;
      //reDrawAllDrawItems();
      //drawMenu();
    }  
    loop();
  }

  void openPAL(File selection)  
  {
    println(selection);    
    if (selection != null)
    {
      opened=true;
      txt = loadStrings(selection.getAbsolutePath());
      String colori[] = loadStrings(selection.getAbsolutePath());
      for (int i=0; i < colori.length; i++)
      {
        userPal[i] = color(unhex(colori[i])|0xff000000);
      }
//      reDrawAllDrawItems();
//      drawMenu();
      println(selection.getAbsolutePath());      
    }  
    loop();
  }      

  void openUSER(File selection)  
  {
      if (selection != null)
      { 
        String colori[] = loadStrings(selection.getAbsolutePath());
        for (int i=0; i < colori.length; i++)
        {
          userPal[i] = color(unhex(colori[i])|0xff000000);
        }
        reDrawAllDrawItems();
        drawMenu();
      }  
  }    
  
void keyReleased()
{
// save canvas image  (PNG)
  if (key == 's' || key == 'S')
  {
    outIMG = get(0, 0, width, height-menuHEIGHT);
    outIMG.save(timestamp()+".png");
    saveFrame(timestamp()+"_##.png");
  }

// save canvas vector (PDF)
  if (key == 'p' || key == 'P') savePDF = true;

// clear canvas
  if (key == DELETE)
  {
    background(backColor);
    drawItems = new ArrayList();
    reDrawAllDrawItems();
    counter=0;
    drawMenu();
  }

// load image for background
  if (key == 'l' || key == 'L')
  {
    String pathFile;
    selectInput("select a background image...", "openIMG");
  }
  
// load text for draw
  if (key == 'x' || key == 'X')
  {
    String pathFile;
    selectInput("select a text file...", "openSTR");
  }  
  
// show/hide image
  if (key == 'i' || key == 'I')
  {
    showImage = !showImage;
    reDrawAllDrawItems();
    drawMenu();
  }

// change background color
  if (key == 'b' || key == 'B')
  {
    backColor=fontColor;
    reDrawAllDrawItems();
    drawMenu();
  }

// window help (show/hide)
  if (key == 'h' || key == 'H')
  {
    showHelp=!showHelp;
    if (showHelp==false) { eraseHelp=true; }
  }

// UNDO
  if (key == BACKSPACE)
  {
    undoDrawItem();
    reDrawAllDrawItems();
    drawMenu();
  }

// tablet on/off controls
  if (key == 't' || key == 'T')
  {
     wacom = !(wacom);
     if (wacom) { lastFontSize = newFontSize; }
     else { newFontSize = lastFontSize; }
     drawMenu();
  }

// font selectors
  if ((key=='1')||(key=='2')||(key=='3')||(key=='4')||(key=='5')||(key=='6')||(key=='7')||(key=='8')||(key=='9'))
  {
    fontNum=int(key)-48;
    font = listfont[fontNum];
    drawMenu();
  }

// load user palette
  if (key == 'c' || key == 'C')
  {
    //loadUserPalette();    
    String pathFile;
    selectInput("select a palette file...", "openPAL");
  }
  
// random font type on/off
  if (key == 'r' || key == 'R')
  {
    rndFont=!rndFont;
    drawMenu();
  }  
  
// random font color on/off
  if (key == 'e' || key == 'E')
  {
    rndCol=!rndCol;
    drawMenu();
  }    

// turn off SHIFT led button
  if (keyCode == SHIFT)
  {
    fill(60);
    rect(310,height-13,6,10);
  }

// turn off CONTROL button
  if (keyCode == CONTROL)
  {
    fill(60);
    rect(322,height-13,6,10);
  }

// show/hide popup text
  if (key == 'u' || key == 'U')
  {
    showPopup = !showPopup;
    drawMenu();
  }

// zoom on/off
  if (key == 'z' || key == 'Z')
  {
    zoom=!zoom;
    drawMenu();
  }

}

//*********************
// KEY PRESSED
//*********************
void keyPressed()
{
  // image filters
  //if (key == 'f' || key == 'F')
  //{
    //img.copy(imgBase,0,0,imgBase.width,imgBase.height,0,0,imgBase.width,imgBase.height);
    // img.filter(GRAY);
    //img.filter(POSTERIZE,2);
    //img.filter(THRESHOLD,imgTH);    
    //img.filter(ERODE);    
    //img.filter(DILATE);
    //println(imgTH);
    //reDrawAllDrawItems();
    //drawMenu();    
  //}    
  
  // image modify: alpha value -1
  if (key == ';')
  {
    if (showImage)
    {    
      imgAlpha -= 1;
      if (imgAlpha < 10) { imgAlpha=10; }
      reDrawAllDrawItems();
      drawMenu();
      //println(imgAlpha);
    }
  }  
  // image modify: alpha value +1  
  if (key == ':')
  {
    if (showImage)
    {    
      imgAlpha += 1;
      if (imgAlpha > 255) { imgTH=255; }    
      reDrawAllDrawItems();      
      drawMenu();
      //println(imgAlpha);
    }
  }      
  
  // image filter: INVERT
  if (key == 'v' || key == 'V')
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
  
  // image filter: GRAYSCALE
  if (key == 'g' || key == 'G')
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
  
  // image modify: THRESHOLD value -0.05
  if (key == 'n' || key == 'N')
  {
    if (showImage)
    {      
      imgTH -= 0.05;
      if (imgTH < 0) { imgTH=0; }
      img.copy(imgBase,0,0,imgBase.width,imgBase.height,0,0,imgBase.width,imgBase.height);
      img.filter(THRESHOLD,imgTH);                
      reDrawAllDrawItems();    
      drawMenu();
      //println(imgTH);
    }
  }  
  // image modify: THRESHOLD value +0.05  
  if (key == 'm' || key == 'M')
  {
    if (showImage)
    {      
      imgTH += 0.05;
      if (imgTH > 1) { imgTH=1; } 
      img.copy(imgBase,0,0,imgBase.width,imgBase.height,0,0,imgBase.width,imgBase.height);
      img.filter(THRESHOLD,imgTH);          
      reDrawAllDrawItems();    
      drawMenu();
      //println(imgTH);
    }
  }    
  
// image move controls
  if (keyCode == UP)
  {
    if (showImage)
    {          
      yIMG-=1;
      reDrawAllDrawItems();
      drawMenu();
    }  
  }
  if (keyCode == DOWN)
  {
    if (showImage)
    {    
      yIMG+=1;
      reDrawAllDrawItems();
      drawMenu();
    }
  }
  if (keyCode == LEFT)
  {
    if (showImage)
    {    
      xIMG-=1;
      reDrawAllDrawItems();
      drawMenu();
    }
  }
  if (keyCode == RIGHT)
  {
    if (showImage)
    {    
      xIMG+=1;
      reDrawAllDrawItems();
      drawMenu();
    }
  }

// angle text distorsion
  if (key == '0')
  {
    angleDistortion = 0;
    drawMenu();
  }

  if (key == 'q' || key == 'Q')
  {
    angleDistortion += 0.1;
    drawMenu();
  }

  if (key == 'a' || key == 'A')
  {
    angleDistortion -= 0.1;
    drawMenu();
  }

// kerning text -0.1  
  if (key == 'j' || key == 'J')
  {
    kerning -= 0.1;
    if (kerning < 1) { kerning = 1; }        
    drawMenu();
  }  
  
// kerning text +0.1  
  if (key == 'k' || key == 'K')
  {
    kerning += 0.1;
    if (kerning > 3) { kerning = 3; }    
    drawMenu();
  }    

// text size +1
  if (key == '+')
  {
     newFontSize += 1;
     if (newFontSize > fontSizeMax) { newFontSize = fontSizeMax; }
     drawMenu();
  }
// text size -1
  if (key == '-')
  {
     newFontSize -= 1;
     if (newFontSize < fontSizeMin) { newFontSize = fontSizeMin; }
     drawMenu();
  }

// alpha text +1
  if (key == '.')
  {
     fontAlpha += 1;
     if (fontAlpha > 255) { fontAlpha=255; }
     drawMenu();
  }
// alpha text -1
  if (key == ',')
  {
     fontAlpha -= 1;
     if (fontAlpha < 1) { fontAlpha=1; }
     drawMenu();
  }

  // intercept ESC key
  if (keyCode==ESC)
  {
    key=0;
  }

  // turn on led SHIFT button
  if (keyCode == SHIFT)
  {
    stroke(255);
    fill(40,150,10);
    rect(310,height-13,6,10);
  }

  // turn on led CTRL button
  if (keyCode == CONTROL)
  {
    stroke(255);
    fill(255,128,0);
    rect(322,height-13,6,10);
  }

}