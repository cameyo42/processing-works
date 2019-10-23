// popup.pde
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
// MOUSE MOVED
//*********************
void mouseMoved()
{
  cursor(CROSS);
  popup = creator;
  if (mouseY > (height-menuHEIGHT)) // move on MENU
  {
    //println("MENU");
    // over main color palette
    if (mouseX > (width - 185) && mouseX < (width - 5) && mouseY > (height-95) && mouseY < (height-5))
    {
      popup="pick color...";
      cursor(HAND);
    }

    // over user color palette
    if (mouseX > (width - 281) && mouseX < (width - 205) && mouseY > (height-95) && mouseY < (height-19))
    {
      popup="pick color...";
      cursor(HAND);
    }

    // over "clear screen" button
    if (mouseX > 0 && mouseX < 12 && mouseY > (height-100) && mouseY < (height-100+12))
    {
      popup="clear screen (del)";
      cursor(HAND);
    }

    // over + font size button
    if (mouseX > 1 && mouseX < 13 && mouseY > (height-47) && mouseY < (height-47+12))
    {
      popup="font size +1 (+)";
      cursor(HAND);
    }

    // over - font size button
    if (mouseX > 1 && mouseX < 13 && mouseY > (height-61) && mouseY < (height-61+12))
    {
      popup="font size -1 (-)";
      cursor(HAND);
    }


    // over - font angle button
    if (mouseX > 49 && mouseX < 61 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="font angle -0.1 (a)";
      cursor(HAND);
    }

    // over reset font angle button
    if (mouseX > 65 && mouseX < 77 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="font angle reset (0)";
      cursor(HAND);
    }

    // over + font angle button
    if (mouseX > 81 && mouseX < 93 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="font angle +0.1 (q)";
      cursor(HAND);
    }

//  rect(150,height-13,10,10);
    // over tablet button (on/off)
    if (mouseX > 149 && mouseX < 161 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="tablet on / off (t)";
      cursor(HAND);
    }

//  rect(170,height-13,10,10);
    // over image button (show/hide)
    if (mouseX > 169 && mouseX < 181 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="image show / hide (i)";
      cursor(HAND);
    }

//  rect(190,height-13,20,10);
    // over delete char button
    if (mouseX > 189 && mouseX < 211 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="delete char (backspace)";
      cursor(HAND);
    }

//  rect(240,height-13,16,10);
    // over save button (pdf)
    if (mouseX > 239 && mouseX < 257 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="save PDF (p)";
      cursor(HAND);
    }

//  rect(265,height-13,16,10);
    // over save button (png)
    if (mouseX > 264 && mouseX < 282 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="save PNG (s)";
      cursor(HAND);
    }

//  rect(310,height-13,6,10);
    // over shift button
    if (mouseX > 309 && mouseX < 317 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="hor/vert text (shift)";
      //cursor(HAND);
    }

//  rect(322,height-13,6,10);
    // over shift button
    if (mouseX > 321 && mouseX < 329 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="diagonal text (ctrl)";
      //cursor(HAND);
    }

//  rect(358,height-13,34,10);
    // over help button
    if (mouseX > 357 && mouseX < 393 && mouseY > (height-14) && mouseY < (height-14+12))
    {
      popup="help show / hide (h)";
      cursor(HAND);
    }

    // over background color button
    if (mouseX > (width-202) && mouseX < (width-202+13) && mouseY > (height-95) && mouseY < (height-95+76))
    {
      popup="change background (b)";
      cursor(HAND);
    }
    
//  rect(width-282,height-16,76,11);    
    // over load user palette button
    if (mouseX > (width-283) && mouseX < (width-283+78) && mouseY > (height-17) && mouseY < (height-17+13))
    {    
      popup="load palette file (c)";
      cursor(HAND);
    }      

    // over load user palette button
    if (mouseX > (width-283) && mouseX < (width-283+78) && mouseY > (height-17) && mouseY < (height-17+13))
    {
      popup="load palette (c)";
      cursor(HAND);
    }

//  rect(width/2-85,height-90,170,16);
    // over popup info window
    if (mouseX > (width/2-86) && mouseX < (width/2-86+172) && mouseY > (height-90-1) && mouseY < (height-90+18))
    {
      popup="popup info on / off (u)";
      cursor(HAND);
    }

//  rect(430,height-62,11,11);
    // pick font 01 button
    if (mouseX > 429 && mouseX < 442 && mouseY > (height-62-1) && mouseY < (height-62+13))
    {
      popup=("font 1: "+namefont[1]+ " (1)");
      cursor(HAND);
    }

//  rect(448,height-62,11,11);
    // pick font 02 button
    if (mouseX > 447 && mouseX < 460 && mouseY > (height-62-1) && mouseY < (height-62+13))
    {
      popup=("font 2: "+namefont[2]+ " (2)");
      cursor(HAND);
    }

//  rect(466,height-62,11,11);
    // pick font 03 button
    if (mouseX > 465 && mouseX < 478 && mouseY > (height-62-1) && mouseY < (height-62+13))
    {
      popup=("font 3: "+namefont[3]+ " (3)");
      cursor(HAND);
    }

//  rect(430,height-44,11,11);
    // pick font 04 button
    if (mouseX > 429 && mouseX < 442 && mouseY > (height-44-1) && mouseY < (height-44+13))
    {
      popup=("font 4: "+namefont[4]+ " (4)");
      cursor(HAND);
    }

//  rect(448,height-44,11,11);
    // pick font 05 button
    if (mouseX > 447 && mouseX < 460 && mouseY > (height-44-1) && mouseY < (height-44+13))
    {
      popup=("font 5: "+namefont[5]+ " (5)");
      cursor(HAND);
    }

//  rect(466,height-44,11,11);
    // pick font 06 button
    if (mouseX > 465 && mouseX < 478 && mouseY > (height-44-1) && mouseY < (height-44+13))
    {
      popup=("font 6: "+namefont[6]+ " (6)");
      cursor(HAND);
    }

//  rect(430,height-26,11,11);
    // pick font 07 button
    if (mouseX > 429 && mouseX < 442 && mouseY > (height-26-1) && mouseY < (height-26+13))
    {
      popup=("font 7: "+namefont[7]+ " (7)");
      cursor(HAND);
    }
//  rect(448,height-26,11,11);
    // pick font 08 button
    if (mouseX > 447 && mouseX < 460 && mouseY > (height-26-1) && mouseY < (height-26+13))
    {
      popup=("font 8: "+namefont[8]+ " (8)");
      cursor(HAND);
    }
//  rect(466,height-26,11,11);
    // pick font 09 button
    if (mouseX > 465 && mouseX < 478 && mouseY > (height-26-1) && mouseY < (height-26+13))
    {
      popup=("font 9: "+namefont[9]+ " (9)");
      cursor(HAND);
    }
    
//  rect(486, height-62, 10, 47);    
    // over random font button
    if (mouseX > 485 && mouseX < 497 && mouseY > (height-62-1) && mouseY < (height-62+49))
    {
      popup=("random font on / off (r)");
      cursor(HAND);
    }    

    // over kerning font slider
//  line(275,height-76,375,height-76);
    if (mouseX>260 && mouseX<390 && mouseY > height-76-13 && mouseY < height-76+9)
    {
      popup=("font kerning (j) (k)");
      cursor(HAND);      
    }  

    // over alpha font slider
//  line(275,height-26,410,height-26);
    if (mouseX>260 && mouseX<425 && mouseY > height-26-13 && mouseY < height-26+9)
    {
      popup=("font alpha (,) (.)");
      cursor(HAND);
    }

    // over size font slider
//  line(275,height-51,410,height-51);
    if (mouseX>260 && mouseX<425 && mouseY > height-51-13 && mouseY < height-51+9)
    {
      popup=("font size (-) (+)");
      cursor(HAND);
    }

    // over image window movers
//  rect(515, height-62, 47*width/(height-menuHEIGHT),47);
    if (mouseX>514 && mouseX<(516+47*width/(height-menuHEIGHT)) && mouseY > height-62-1 && mouseY < height-62+47)
    {
      popup=("move image");
      cursor(HAND);
    }
    
    // over load image button    
//  rect(605, height-13,21,10);    
    if (mouseX > 604 && mouseX < 627 && mouseY > (height-13-1) && mouseY < (height-13+12))
    {
      popup=("load image (l)");
      cursor(HAND);
    }  

    // over load text file button
//  rect(443, height-84,21,10);  
    if (mouseX > 442 && mouseX < 465 && mouseY > (height-84-1) && mouseY < (height-84+12))
    {
      popup=("load text file (x)");
      cursor(HAND);
    }        

  // pick INVERT image button
//  rect(608, height-54,11,11);      
    if (mouseX > 607 && mouseX < 620 && mouseY > (height-54-1) && mouseY < (height-54+13))
    {  
      popup=("Invert image (v)");
      cursor(HAND);
    }        

  // over GRAYSCALE image button
//  rect(608, height-34,11,11);  
    if (mouseX > 607 && mouseX < 620 && mouseY > (height-34-1) && mouseY < (height-34+13))
    {  
      popup=("Grayscale image (g)");
      cursor(HAND);
    } 

    // over threshold image font slider
//  line(625,height-51,760,height-51);
    if (mouseX>630 && mouseX<775 && mouseY > height-51-13 && mouseY < height-51+9)
    {
      popup=("image threshold (n) (m)");
      cursor(HAND);
    }              

    // over alpha image slider
//  line(625,height-26,760,height-26);
    if (mouseX>630 && mouseX<775 && mouseY > height-26-13 && mouseY < height-26+9)
    {
      popup=("image alpha (;) (:)");
      cursor(HAND);
    }                    

    // over zoom window button
//  rect(width-365,height-menuHEIGHT+4,75,75);    
    if (mouseX > width-366 && mouseX < width-366+77 && mouseY > (height-menuHEIGHT+4-1) && mouseY < (height-menuHEIGHT+4-1+77))
    {
      popup=("zoom on / off (z)");
      cursor(HAND);      
    }  
    
  }

}
