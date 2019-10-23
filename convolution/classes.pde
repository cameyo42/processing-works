// Button[] buttons = new Button[N];
// buttons[0] = new Button( 20, 20, 60, 30, "btn00Method", "btn_00", color(128), color(196), color(255) );
class Button 
{
  float x, y, w, h;
  String s, t;
  color c, k, q;
  color l; //highlight
  boolean status = false;
  boolean light = false;
  // constructor
  Button(float ix, float iy, float iw, float ih, String is, String it, color ic, color ik, color iq, color il) 
  {
    x=ix; // start x
    y=iy; // start y
    w=iw; // width
    h=ih; // height
    s=is; // method
    t=it; // text
    c=ic; // unactive color
    k=ik; // active color
    q=iq; // pressed color
    l=il; // highlight border color
  }
  boolean isOver() 
  {
    return(mouseX>=x&&mouseX<=x+w&&mouseY>=y&&mouseY<=y+h);
  }
  void onClick() 
  {
    if (isOver() && !s.equals("")) method(s);
  }
  void draw() 
  {
    pushStyle();
    if (light==true) stroke(l);
    else stroke(0);
    fill(isOver()?(mousePressed?q:k):c);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
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
  boolean status = false;
  Spinner(float ix, float iy, float iw, float ih, float iv, float is, color ic, color ik) 
  {
    x=ix; // start x
    y=iy; // start y
    w=iw; // width
    h=ih; // height
    v=iv; // start value
    s=is; // step value
    c=ic; // color standard
    k=ik; // color over
  }
  boolean isOver() 
  {
    return(mouseX>=x&&mouseX<=x+w&&mouseY>=y&&mouseY<=y+h);
  }
  void onClick() 
  {
    //if (isOver() && !s.equals("")) method(s);
    if (isOver())
    {
      if ((mouseX>x)&&(mouseX<x+w/4)&&(mouseY>=y)&&(mouseY<=y+h)) //left press
      {
        v=v-s;
        status=true;
      }
      if ((mouseX>x+3*w/4)&&(mouseX<x+w)&&(mouseY>=y)&&(mouseY<=y+h)) //right press
      {
        v=v+s;
        status=true;
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
  
  void draw() 
  {
    pushStyle();
    stroke(0);
    //fill(isOver()?(mousePressed?q:k):c);
    fill(isOver()?k:c);
    rect(x, y, w, h);
    line(x+w/4,y,x+w/4,y+h);
    line(x+3*w/4,y,x+3*w/4,y+h);
    fill(#eee8d5);
    fill(0);
    textAlign(CENTER, CENTER);
    text(nf(v,1,1),x+w/2.0,y+h/2.0-2);
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
    c=ic; // unactive color
    k=ik; // active color
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
  void draw() 
  {
    pushStyle();
    stroke(0);
    fill(isOver()?k:c);
    rect(x, y, w, h);
    if (s==true)
    {
      stroke(255,128,0);
      line(x+1,y+1,x+w-1,y+h-1);
      line(x+w-1,y+1,x+1,y+h-1);
    }
    //fill(0);
    fill(#eee8d5);
    textAlign(LEFT,CENTER);
    text(t,x+w+3,y+h/2-2);
    popStyle();
  }
}