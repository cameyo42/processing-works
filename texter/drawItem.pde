// drawItem.pde
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

class drawItem
{
  float x = 0, y = 0;
  float angle = 0;
  float fontSize = 0;
  char letter = ' ';
  color dcolor = color(0);
  PFont dfont = font;
  int dalpha = 255;
  //menuHEIGHT -> space for bottom menu

  void draw()
  {
    pushMatrix();
    translate(x,y);
    rotate(angle);
    textFont(dfont,fontSize);
    textAlign(LEFT);
    fill(dcolor,dalpha);
    if (y < height-menuHEIGHT) { text(letter, 0, 0); }
    popMatrix();
  }
}

