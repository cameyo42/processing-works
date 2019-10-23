// Button[] buttons = new Button[N];
// buttons[0] = new Button( 20, 20, 60, 30, "btn00Method", "btn_00", color(128), color(255) );
class Button 
{
  float x, y, w, h;
  String s, t;
  color c1, c2;

  // constructor
  Button(float ix, float iy, float iw, float ih, String is, String it, color ic1, color ic2) 
  {
    x=ix; // start x
    y=iy; // start y
    w=iw; // width
    h=ih; // height
    s=is; // method
    t=it; // text
    c1=ic1; // fill color
    c2=ic2; // stroke color
  }
  boolean isOver() 
  {
    return(mouseX>=x&&mouseX<=x+w&&mouseY>=y&&mouseY<=y+h);
  }
  void onClick() 
  {
    if (isOver() && !s.equals("")) method(s);
  }
  void show() 
  {
    pushStyle();
    fill(c1);
    stroke(c2);
    rect(x, y, w, h);
    //fill(#eee8d5);
    fill(0);    
    textAlign(CENTER,CENTER);
    text(t,x+w/2.0,y+h/2.0-1);
    popStyle();
  }
}

// Spinner[] spinners = new Spinner[N];
class Spinner 
{
  float x, y, w, h;
  float v, s;
  color c, k, q;
  String m;

  Spinner(float ix, float iy, float iw, float ih, float iv, float is, color ic, String im) 
  {
    x=ix; // start x
    y=iy; // start y
    w=iw; // width
    h=ih; // height
    v=iv; // start value
    s=is; // step value
    c=ic; // color
    m=im; // method
  }
  
  boolean isOver() 
  {
    return(mouseX>=x&&mouseX<=x+w&&mouseY>=y&&mouseY<=y+h);
  }
  
  void onClick() 
  {
    //if (isOver() && !s.equals("")) method(s);
    if (isOver() && !m.equals(""))
    {
      if ((mouseX>x)&&(mouseX<x+w/4)&&(mouseY>=y)&&(mouseY<=y+h)) //left press
      {
        if(keyPressed && keyCode == SHIFT)
        {
          v=v-s/100.0; method(m);
        }
        else if(keyPressed && keyCode == CONTROL)
        {
          v=v-s/10.0; method(m);
        }
        else if(keyPressed && keyCode == ALT)
        {
          v=v-s*10.0; method(m);
        }                
        else
        {
          v=v-s; method(m);
        }
      }
      if ((mouseX>x+3*w/4)&&(mouseX<x+w)&&(mouseY>=y)&&(mouseY<=y+h)) //right press
      {
        if(keyPressed && keyCode == SHIFT)
        {
          v=v+s/100.0; method(m);
        }
        else if(keyPressed && keyCode == CONTROL)
        {
          v=v+s/10.0; method(m);
        }
        else if(keyPressed && keyCode == ALT)
        {
          v=v+s*10.0; method(m);
        }                
        else
        {
          v=v+s; method(m);
        }
      }        
    }
  }
  void setValue(float u)
  {
    v = u;
  }
  
  float getValue()
  {
    return(v);
  }  
  
  void show() 
  {
    pushStyle();
    stroke(0);
    fill(c);
    rect(x, y, w, h);
    line(x+w/4,y,x+w/4,y+h);
    line(x+3*w/4,y,x+3*w/4,y+h);
    fill(0);
    textAlign(CENTER, CENTER);
    //textSize(12);
    text(nf(v,0,0),x+w/2.0,y+h/2.0-1);
    fill(20);
    text("-",x+w/8.0,y+h/2.0-2);
    text("+",x+7*w/8.0,y+h/2.0-2);
    popStyle();
  }
}  
  

// SpinBound[] spinB = new SpinBound[N];
class SpinBound 
{
  float x, y, w, h;
  float v, s;
  float minv, maxv;
  color c, k, q;
  String m;

  SpinBound(float ix, float iy, float iw, float ih, float iv, float is, float imin, float imax, color ic, String im) 
  {
    x=ix; // start x
    y=iy; // start y
    w=iw; // width
    h=ih; // height
    v=iv; // start value
    s=is; // step value
    minv = imin; // min value
    maxv = imax; // max value
    c=ic; // color
    m=im; // method
  }
  boolean isOver() 
  {
    return(mouseX>=x&&mouseX<=x+w&&mouseY>=y&&mouseY<=y+h);
  }

  void onClick() 
  {
    //if (isOver() && !s.equals("")) method(s);
    if (isOver() && !m.equals(""))
    {
      if ((mouseX>x)&&(mouseX<x+w/4)&&(mouseY>=y)&&(mouseY<=y+h)) //left press
      {
        v = constrain(v-s, minv, maxv);
        method(m);
      }
      if ((mouseX>x+3*w/4)&&(mouseX<x+w)&&(mouseY>=y)&&(mouseY<=y+h)) //right press
      {
        v = constrain(v+s, minv, maxv);
        method(m);
      }        
    }
  }
 
  void setValue(float u)
  {
    v = u;
  }
  
  float getValue()
  {
    return(v);
  }  
  
  void show() 
  {
    pushStyle();
    stroke(0);
    fill(c);
    rect(x, y, w, h);
    line(x+w/4,y,x+w/4,y+h);
    line(x+3*w/4,y,x+3*w/4,y+h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(nf(v,0,0),x+w/2.0,y+h/2.0-1);
    fill(20);
    text("-",x+w/8.0,y+h/2.0-2);
    text("+",x+7*w/8.0,y+h/2.0-2);
    popStyle();
  }
}

class Checkbox
{
  float x, y, w, h;
  String t;  
  boolean s;
  color c, k;
  // constructor
  Checkbox(float ix, float iy, float iw, float ih, String it, boolean is, color ic, color ik) 
  {
    x=ix; // start x
    y=iy; // start y
    w=iw; // width
    h=ih; // height
    t=it; // text    
    s=is; // status
    c=ic; // border color
    k=ik; // fill color
  }
  boolean isOver() 
  {
    return(mouseX>=x&&mouseX<=x+w&&mouseY>=y&&mouseY<=y+h);
  }
  void onClick() 
  {
    if (isOver())
    {
       s=!(s);
    }   
  }
  void show() 
  {
    pushStyle();
    stroke(c);
    fill(k);
    rect(x, y, w, h);
    if (s==true)
    {
      noStroke();
      fill(#dc322f);
      rect(x+2, y+3, w-5, h-5);
    }
    fill(#eee8d5);
    textAlign(LEFT,CENTER);
    text(t,x+w+3,y+h/2-1);
    popStyle();
  }
}