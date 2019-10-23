// *************************************************
// Button (click)
class Button
{
  // parameters
  float x, y;
  PImage icon;
  String t;
  color ct;
  String m;
  String tt;

  // variables
  int ww; // icon width
  int hh; // icon height

  // constructor
  Button(float ix, float iy, PImage _icon, String it, color ict, String im, String itt)
  {
    x = ix; // start x (upper left)
    y = iy; // start y (upper left)
    icon = _icon; // icon tool
    t = it; // text string
    ct = ict; // text color
    m = im; // method (function)
    tt = itt; // tooltip text

    // variables
    ww = icon.width;
    hh = icon.height;
  }

  boolean isOver()
  {
    return(mouseX>=x&&mouseX<=x+ww&&mouseY>=y&&mouseY<=y+hh);
  }

  void onClick()
  {
    if (isOver() && !m.equals(""))
    {
      method(m);
    }
  }

  void show()
  {
    pushStyle();
    imageMode(CORNER);
    image(icon, x, y);
    if (t != "")
    {
      fill(ct);
      textAlign(CENTER);
      text(t,x+ww/2,y+hh+12);
    }
    popStyle();
  }

//  void toolTip()
//  {
//    if (isOver())
//    {
//      int lenTip = tt.length();
//      pushStyle();
//      fill(202);
//      stroke(0);
//      rectMode(CENTER);
//      rect(mouseX,mouseY-16,8*lenTip,16);
//      fill(0);
//      textSize(14);
//      textAlign(CENTER);
//      text(tt, mouseX+2, mouseY-12);
//      popStyle();
//    }
//  }

  void toolTip()
  {
    if (isOver())
    {
      int lenTip = tt.length();
      pushStyle();
      fill(202);
      stroke(0);
      rectMode(CENTER);
      //rect(mouseX,mouseY-16,8*lenTip,16);
      rect(mouseX+4*lenTip,mouseY+34,8*lenTip,16);
      fill(0);
      textSize(14);
      textAlign(CENTER);
      //text(tt, mouseX+2, mouseY-12);
      text(tt, mouseX+2+4*lenTip, mouseY+38);
      popStyle();
    }    
  }
}

// *************************************************
// Button ON/OFF
class ButtonIMG
{
  // parameters
  float x, y;
  PImage iconON, iconOFF;
  boolean s;
  String t;
  color ct;
  String m;
  String tt;

  // variables
  int ww; // icon width
  int hh; // icon height

  // constructor
  ButtonIMG(float ix, float iy, PImage _iconON, PImage _iconOFF, boolean is, String it, color ict, String im, String itt)
  {
    x = ix; // start x (upper left)
    y = iy; // start y (upper left)
    iconOFF = _iconOFF; // icon tool OFF
    iconON = _iconON; // icon tool ON
    s = is; // status on-true/off-false
    t = it; // text string
    ct = ict; // text color
    m = im; // method (function)
    tt = itt; // tooltip text

    ww = iconOFF.width;
    hh = iconOFF.height;
  }

  boolean isOver()
  {
    return(mouseX>=x&&mouseX<=x+ww&&mouseY>=y&&mouseY<=y+hh);
  }

  void onClick()
  {
    if (isOver() && !m.equals(""))
    {
      s = !s;
      method(m);
    }
  }

  void show()
  {
    pushStyle();
    imageMode(CORNER);
    if (s) { image(iconON,x,y); }
    else   { image(iconOFF,x,y); }
    if (t != "")
    {
      fill(ct);
      textAlign(CENTER);
      text(t,x+ww/2,y+hh+12);
    }
    popStyle();
  }

//  void toolTip()
//  {
//    if (isOver())
//    {
//      int lenTip = tt.length();
//      pushStyle();
//      fill(202);
//      stroke(0);
//      rectMode(CENTER);
//      rect(mouseX,mouseY-16,8*lenTip,16);
//      fill(0);
//      textSize(14);
//      textAlign(CENTER);
//      text(tt, mouseX+2, mouseY-12);
//      popStyle();
//    }
    
  void toolTip()
  {
    if (isOver())
    {
      int lenTip = tt.length();
      pushStyle();
      fill(202);
      stroke(0);
      rectMode(CENTER);
      //rect(mouseX,mouseY-16,8*lenTip,16);
      rect(mouseX+4*lenTip,mouseY+34,8*lenTip,16);
      fill(0);
      textSize(14);
      textAlign(CENTER);
      //text(tt, mouseX+2, mouseY-12);
      text(tt, mouseX+2+4*lenTip, mouseY+38);
      popStyle();
    }    
  }
}

// *************************************************
class Checkbox
{
  float x, y, w, h;
  String t;
  boolean s;
  color c0, c1, c2, c3 ,ct;
  String m;

  // constructor
  Checkbox(float ix, float iy, float iw, float ih, String it, boolean is, color ic0, color ic1, color ic2, color ic3, color ict, String im)
  {
    x=ix; // start x
    y=iy; // start y
    w=iw; // width
    h=ih; // height
    t=it; // text
    s=is; // status
    c0=ic0; // stroke color
    c1=ic1; // fill color
    c2=ic2; // fill color on
    c3=ic3; // fill color off
    ct=ict; // text color
    m=im; // method
  }
  boolean isOver()
  {
    return(mouseX>=x&&mouseX<=x+w&&mouseY>=y&&mouseY<=y+h);
  }
  void onClick()
  {
    if (isOver() && !m.equals(""))
    {
       s=!(s);
       method(m);
    }
  }
  void show()
  {
    pushStyle();
    stroke(c0);
    fill(c1);
    rect(x, y, w, h);
    noStroke();
    if (s==true) { fill(c2); }//253,246,227); }
    else { fill(c3); };
    rect(x+3, y+3, w-5, h-5);
    fill(ct);
    textAlign(LEFT,CENTER);
    text(t,x+w+5,y+h/2-1);
    popStyle();
  }
}

// *************************************************
// Slider
class Slider
{
  float x1, y1, x2, y2;
  int p;
  String t;
  float v, v1, v2;
  color c0, c1, cl, ct;
  String m;
  int type;

  boolean locked;

  // constructor
  Slider(float ix1, float iy1, float ix2, float iy2, int ip, String it, float iv1, float iv2, float iv, color ic0, color ic1, color icl, color ict, String im, int itype)
  {
    x1=ix1; // start x
    y1=iy1; // start y
    x2=ix2; // end x
    y2=iy2; // end y
    p=ip;   // pad space
    t=it;   // text
    v1=iv1; // min value
    v2=iv2; // max value
    v=iv;   // value
    c0=ic0; // stroke color
    c1=ic1; // fill color
    cl=icl; // line color
    ct=ict; // text color
    m=im;   // method name
    type = itype;

    locked = false;
  }

  boolean isOver()
  {
    return(mouseX>=x1-p && mouseX<=x2+p && mouseY>=y1-p && mouseY<=y2+p);
  }

  void onClick()
  {
    if (isOver())
    {
       locked = true;
       v = constrain(int(map(mouseX,x1,x2,v1,v2)),v1,v2);
       method(m);
    }
  }

  void onDrag()
  {
    if (isOver() || locked)
    {
       v = constrain(int(map(mouseX,x1,x2,v1,v2)),v1,v2);
       method(m);
    }
  }

  void show()
  {
    pushStyle();
    if (type == 1)
    {
      stroke(cl);
      line(x1,y1,x2,y2);
      line(x1,y1+1,x2,y2+1);
      textAlign(LEFT);
      fill(ct);
      text(t, x1+4, y1-18);
      int pos = int(map(v,v1,v2,x1,x2));
      stroke(c0);
      fill(c1);
      rectMode(CENTER);
      rect(pos, y2, 40, 21);
      textAlign(CENTER);
      fill(ct);
      text(nf(v,0,0), pos, y1+6);
      //textAlign(RIGHT);
      //text(t, (x1+x2)/2, y1-6);
    }
    else if (type == 2)
    {
      stroke(cl);
      fill(cl);
      triangle(x1,y1,x2,y2,x2,y2-16);
      textAlign(LEFT);
      fill(ct);
      text(t, x1+4, y1-26);
      int pos = int(map(v,v1,v2,x1,x2));
      stroke(c0);
      fill(c1);
      rectMode(CENTER);
      rect(pos, y2-8, 6, 22);
      //textAlign(CENTER);
      //fill(ct);
      //text(nf(v,0,0), pos, y1+6);
      //textAlign(RIGHT);
      //text(t, (x1+x2)/2, y1-6);
    }
    popStyle();
  }
}