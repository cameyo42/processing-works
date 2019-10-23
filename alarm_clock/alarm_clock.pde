// alarm clock
// by cameyo 2013
// for processing 1.5.1 & 2.x
// MIT license
import javax.swing.*;
import ddf.minim.*;
Minim minim;
AudioPlayer playerA, playerC;

String TITLE = "Alarm Clock";

PFont myFont, mFont, sFont, hFont;

int baseX = 84;
int baseY = 74;
int hRect = 66;
int wRect = 80;

int xCen, yCen;

String sTime, sDate;
int h, m, s;
int YY, MM, DD;
String monthName;
String[] monthsList = { "january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december" };
int[] monthsDays = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
String[] daysList = { "sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday" };
int dayNumber;
String dayName;
int currNumDay;
boolean leap=false;
int weeksGone, daysGone, hoursGone, minsGone, secsGone;

int hAlarm=0, mAlarm=0, sAlarm=0;
int repeatM=10; // minuter until repeat alarm
int hCount=0, mCount=5, sCount=0;
int hBase, mBase, sBase;
boolean alarm=false;
boolean countdown=false;

boolean showInfo=false;
boolean showPulse=false;

String callTip="";

float icoR,icoG,icoB;

float fast;
int i, k, code;

//***************
// SETUP
//***************
void setup()
{
  // remove window frame border
  // Warning: break mouse routine (changes the coordinates of window)
  //frame.removeNotify();
  //frame.setUndecorated(true);
  //frame.addNotify();
  //super.init();

  // set window dimension
  size(330, 342);
  // set window title
  surface.setTitle(TITLE);
  // set window icon image
  // changeAppIcon(); 
  // set backgrond color
  background(220);
  //load fonts
  myFont = loadFont("DS-Digital-72.vlw");
  mFont = loadFont("DS-Digital-48.vlw");
  sFont = loadFont("DS-Digital-24.vlw");
  //hFont = loadFont("BitstreamVeraSans-Roman-10.vlw");
  hFont = createFont("Consolas Bold", 10);
  textFont(myFont);
  // get center of window
  xCen=(width/2);
  yCen=(height/2);
  // audio section
  minim = new Minim(this);
  // load MP3 files, give the AudioPlayer buffers that are 2048 samples long
  playerA = minim.loadFile("alarm.mp3", 2048);
  playerC = minim.loadFile("timer.mp3", 2048);

  // slow refresh
  frameRate(10);

  // draw smooth
  smooth();
}

//***************
// DRAW
//***************
void draw()
{
  background(0);

  // get current time
  s = second();
  m = minute();
  h = hour();
  // create current time string
  sTime=nf(h, 2)+":"+nf(m, 2)+":"+nf(s, 2);

  // get current date
  YY = year();
  MM = month();
  DD = day();
  // calculate name of month
  monthName = monthsList[MM-1];
  // calculate day of week
  dayNumber = dayWeek(YY, MM, DD);
  dayName = daysList[dayNumber];
  // calculate if year is leap (february -> 29 days)
  if (isLeap(YY))
  {
    leap = true;
    monthsDays[2]=29;
  }
  //calculate current day number (0,365)
  currNumDay=0;
  for (i=0;i<MM;i++)
  {
    currNumDay = currNumDay + monthsDays[i];
  }
  currNumDay = currNumDay + DD;
  // create current date string
  sDate=dayName+", "+ DD + " " + monthName + " " + YY;

  // ----------
  // CLOCK
  // ----------
  // draw rect clock
  strokeWeight(1);
  stroke(60);
  fill(20);
  rectMode(CENTER);
  // hours rect
  rect(baseX, baseY, wRect, hRect);
  // minutes rect
  rect(baseX+wRect, baseY, wRect, hRect);
  // seconds rect
  rect(baseX+2*wRect, baseY, wRect, hRect);

  // write "CLOCK" text
  textAlign(CENTER);
  textFont(sFont);
  fill(0, 255, 0, 100);
  text("C", baseX-58, baseY-21);
  text("L", baseX-58, baseY-3);
  text("O", baseX-58, baseY+15);
  text("C", baseX-58, baseY+33);
  text("K", baseX-58, baseY+51);

  // write text (h,m,s) within rectangles
  textAlign(CENTER);
  textFont(myFont);
  fill(0, 255, 0);
  text(nf(h, 2), baseX, baseY+24);
  text(nf(m, 2), baseX+wRect, baseY+24);
  text(nf(s, 2), baseX+2*wRect, baseY+24);

  // ----------
  // ALARM
  // ----------
  // draw rect alarm
  strokeWeight(1);
  stroke(60);
  fill(20);
  rectMode(CENTER);
  // hours rect
  rect(baseX, baseY+100, wRect, hRect);
  // minutes rect
  rect(baseX+wRect, baseY+100, wRect, hRect);
  // seconds rect
  rect(baseX+2*wRect, baseY+100, wRect, hRect);

  // draw button (+ & -) for hours, minutes, seconds
  // hours -
  rect(baseX-20, baseY+144, wRect/2, hRect/3);
  // hours +
  rect(baseX+20, baseY+144, wRect/2, hRect/3);
  // minutes -
  rect(baseX-20+80, baseY+144, wRect/2, hRect/3);
  // minutes +
  rect(baseX+20+80, baseY+144, wRect/2, hRect/3);
  // seconds -
  rect(baseX-20+160, baseY+144, wRect/2, hRect/3);
  // seconds +
  rect(baseX+20+160, baseY+144, wRect/2, hRect/3);

  // write "ALARM" text
  textAlign(CENTER);
  textFont(sFont);
  if (alarm) {
    fill(255, 0, 0, 100);
  }
  else
  {
    fill(60);
  }
  text("A", baseX-58, baseY+83);
  text("L", baseX-58, baseY+101);
  text("A", baseX-58, baseY+119);
  text("R", baseX-58, baseY+137);
  text("M", baseX-58, baseY+155);

  // draw alarm start button
  if (alarm) {
    fill(255, 0, 0, 100);
  }
  else
  {
    fill(20);
  }
  rect(baseX+20+191, baseY+144, hRect/3, hRect/3);

  // write text (h,m,s alarm) within rectangles
  textAlign(CENTER);
  textFont(myFont);
  if (alarm) {
    fill(255, 0, 0, 100);
  }
  else
  {
    fill(60);
  }
  text(nf(hAlarm, 2), baseX, baseY+124);
  text(nf(mAlarm, 2), baseX+wRect, baseY+124);
  text(nf(sAlarm, 2), baseX+2*wRect, baseY+124);

  // write text button alarm (+,-)
  textFont(mFont);
  fill(60);
  text("-", baseX-20, baseY+124+36);
  text("+", baseX+20, baseY+124+36);
  text("-", baseX-20+80, baseY+124+36);
  text("+", baseX+20+80, baseY+124+36);
  text("-", baseX-20+160, baseY+124+36);
  text("+", baseX+20+160, baseY+124+36);

  // ----------
  // COUNTDOWN
  // ----------
  // draw rect countdown
  strokeWeight(1);
  stroke(60);
  fill(20);
  rectMode(CENTER);
  // hours rect
  rect(baseX, baseY+200, wRect, hRect);
  // minutes rect
  rect(baseX+wRect, baseY+200, wRect, hRect);
  // seconds rect
  rect(baseX+2*wRect, baseY+200, wRect, hRect);

  // draw button (+ & -) for hours, minutes, seconds
  // hours -
  rect(baseX-20, baseY+244, wRect/2, hRect/3);
  // hours +
  rect(baseX+20, baseY+244, wRect/2, hRect/3);
  // minutes -
  rect(baseX-20+80, baseY+244, wRect/2, hRect/3);
  // minutes +
  rect(baseX+20+80, baseY+244, wRect/2, hRect/3);
  // seconds -
  rect(baseX-20+160, baseY+244, wRect/2, hRect/3);
  // seconds +
  rect(baseX+20+160, baseY+244, wRect/2, hRect/3);

  // write "TIMER" text
  textAlign(CENTER);
  textFont(sFont);
  if (countdown) {
    fill(0, 255, 255, 100);
  }
  else
  {
    fill(60);
  }
  text("T", baseX-58, baseY+183);
  text("I", baseX-58, baseY+201);
  text("M", baseX-58, baseY+219);
  text("E", baseX-58, baseY+237);
  text("R", baseX-58, baseY+255);

  // draw countdown start button
  if (countdown)
  {
    fill(0, 255, 255, 100);
  }
  else
  {
    fill(20);
  }
  rect(baseX+20+191, baseY+244, hRect/3, hRect/3);

  // write text (h,m,s countdown) within rectangles
  textAlign(CENTER);
  textFont(myFont);
  if (countdown)
  {
    fill(0, 255, 255, 100);
  }
  else
  {
    fill(60);
  }

  // set countdown time
  if (countdown)
  {
    if (sBase!=s)
    {
      sBase=s;
      sCount=(sCount+59)%60;
      if (sCount==59)
      {
        mCount=(mCount+59)%60;
        if (mCount==59)
        {
          hCount=(hCount+99)%100;
        }
      }
    }
  }

  text(nf(hCount, 2), baseX, baseY+224);
  text(nf(mCount, 2), baseX+wRect, baseY+224);
  text(nf(sCount, 2), baseX+2*wRect, baseY+224);

  // write text button countdown (+,-)
  textFont(mFont);
  fill(60);
  text("-", baseX-20, baseY+224+36);
  text("+", baseX+20, baseY+224+36);
  text("-", baseX-20+80, baseY+224+36);
  text("+", baseX+20+80, baseY+224+36);
  text("-", baseX-20+160, baseY+224+36);
  text("+", baseX+20+160, baseY+224+36);

  // write current date
  textAlign(CENTER);
  textFont(sFont);
  fill(200);
  text(sDate, xCen, 26);

  // draw line of blinking seconds
  rectMode(CORNER);
  strokeWeight(1);
  noStroke();
  fill(20);
  for (i=0;i<60;i++)
  {
    if ((i==s) && (i!=0))
    {
      fill(0, 255, 0);
    }
    else
    {
      fill(60);
    }
    if (i!=0)
    {
      rect(42+4*i, 123, 4, 3);
    }
  }

  // draw info button
  rectMode(CORNER);
  strokeWeight(1);
  stroke(60);
  fill(20);
  rect(2,2,8,8);
  if (isLeap(YY)) { stroke(0,255,0,100); }
  rect(4,4,4,4);

  // show text info window
  if (showInfo)
  {
    // calculate infos
    daysGone = currNumDay;
    weeksGone = (currNumDay-1)/7 +1;
    hoursGone = (daysGone-1)*24 + h;
    minsGone  = (hoursGone)*60 + m;
    secsGone  = (minsGone)*60 + s;
    // draw info window
    rectMode(CORNER);
    stroke(160);
    strokeWeight(1);
    fill(20, 220);
    rect(20, 140, 288, 190);
    // write text on info window
    textFont(sFont);
    textAlign(LEFT);
    fill(220);
    text("ELAPSED TIME...",40,174);
    text("weeks: " + weeksGone,40,204);
    text("days: " + daysGone,40,224);
    text("hours: " + hoursGone,40,244);
    text("minutes: " + minsGone,40,264);
    text("seconds: " + secsGone,40,284);
    textFont(hFont);
    fill(icoR,icoG,icoB);
    text("Alarm Clock",242,154);
    text("by cameyo",244,166);
    // draw moving rect (decimal second)
    stroke(0,255,0);
    noFill();
    fast = map(frameCount%10,0,9,20,288);
    rect(4+fast,305,10,10);

  }

  // show pulse window
  if ((showPulse) && !(showInfo))
  {
    // draw info window
    rectMode(CENTER);
    stroke(160);
    strokeWeight(1);
//    fill(20);
//    rect(1,1, width-3, height-3);
//    fill(0);
    noFill();
    code = frameCount%10;
    rect(307, 74, 36-(code*4), 36-(code*4));
//    rect(307, 74, 36, 36);
//    rect(307, 74, 32, 32);
//    rect(307, 74, 28, 28);
//    rect(307, 74, 24, 24);
//    rect(307, 74, 20, 20);
//    rect(307, 74, 16, 16);
//    rect(307, 74, 12, 12);
//    rect(307, 74, 8, 8);
//    rect(307, 74, 4, 4);

//    if (code == 0) { rect(1,1, width-3, height-3); }
//    rect(1+(15*code),1+(15*code), width-3-(30*code), height-3-(30*code));
//    if (code == 1) { rect(5,5, width-11, height-11); }
//    if (code == 2) { rect(9,9, width-19, height-19); }
//    if (code == 3) { rect(13,13, width-27, height-27); }
//    if (code == 4) { rect(17,17, width-35, height-35); }
//    if (code == 5) { rect(21,21, width-43, height-43); }
  }

  // control alarm
  if (alarm) {
    alarmControl();
  }
  // control countdown
  if (countdown) {
    countControl();
  }

  // draw text tip at mouse position
  if (callTip != "")
  {
//    noFill();
//    stroke(255);
//    rectMode(CENTER);
//    rect(164,114,80,12);
    textFont(hFont);
    textAlign(CENTER);
    fill(255);
    text(callTip,164,119);
  }

}


// ***************************
// keyPressed()
// ***************************
void keyPressed()
{
  if (key == 'z' || key == 'Z')
  {
  println("z");
     frame.setState(JFrame.ICONIFIED);  // Minimize window
  }

  // pulse ON/OFF
  if (key == 'p' || key == 'P')
  {
    showPulse = !(showPulse);
  }

  // info ON/OFF
  if (key == 'i' || key == 'I')
  {
    showInfo = !(showInfo);
  }

  // alarm ON/OFF
  if (key == 'a' || key == 'A')
  {
    alarm = !(alarm);
    //countdown=false;
  }

  // countdown ON/OFF
  if (key == 't' || key == 'T')
  {
    countdown = !(countdown);
    //alarm=false;
    hBase=h;
    mBase=m;
    sBase=s;
  }

  // save window
  if (key == 's' || key == 'S')
  {
    saveFrame("alarmclock-####.png");
  }

  // alarm hours down
  if (key == '1') {
    hAlarm=(hAlarm+23)%24;
  }
  // alarm hours up
  if (key == '2') {
    hAlarm=(hAlarm+25)%24;
  }
  // alarm minutes down
  if (key == '3') {
    mAlarm=(mAlarm+59)%60;
  }
  // alarm minutes up
  if (key == '4') {
    mAlarm=(mAlarm+61)%60;
  }
  // alarm seconds down
  if (key == '5') {
    sAlarm=(sAlarm+59)%60;
  }
  // alarm seconds up
  if (key == '6') {
    sAlarm=(sAlarm+61)%60;
  }
}

// ***************************
// mousePressed()
// ***************************
void mousePressed()
{
  //println(mouseX+ " - " + mouseY);

  if ((mouseX>0 && mouseX<11 && mouseY>0 && mouseY<11))
  {
    showInfo = !(showInfo);
  }

  if (showInfo==false)
  {
    // ALARM hours buttons (-,+)
    if (mouseX>44 && mouseX<84 && mouseY>207 && mouseY<227)
    {
      hAlarm=(hAlarm+23)%24;
    }
    if (mouseX>44+40*1 && mouseX<84+40*1 && mouseY>207 && mouseY<227)
    {
      hAlarm=(hAlarm+25)%24;
    }
    // ALARM minutes buttons (-,+)
    if (mouseX>44+40*2 && mouseX<84+40*2 && mouseY>207 && mouseY<227)
    {
      mAlarm=(mAlarm+59)%60;
    }
    if (mouseX>44+40*3 && mouseX<84+40*3 && mouseY>207 && mouseY<227)
    {
      mAlarm=(mAlarm+61)%60;
    }
    // ALARM seconds buttons (-,+)
    if (mouseX>44+40*4 && mouseX<84+40*4 && mouseY>207 && mouseY<227)
    {
      sAlarm=(sAlarm+59)%60;
    }
    if (mouseX>44+40*5 && mouseX<84+40*5 && mouseY>207 && mouseY<227)
    {
      sAlarm=(sAlarm+61)%60;
    }

    // ALARM ON/OFF button
    if (mouseX>44+40*6 && mouseX<64+40*6 && mouseY>207 && mouseY<227)
    {
      alarm = !(alarm);
      //countdown=false;
    }

    // COUNTDOWN hours buttons (-,+)
    if (mouseX>44 && mouseX<84 && mouseY>307 && mouseY<327)
    {
      hCount=(hCount+99)%100;
    }
    if (mouseX>44+40*1 && mouseX<84+40*1 && mouseY>307 && mouseY<327)
    {
      hCount=(hCount+101)%100;
    }
    // COUNTDOWN minutes buttons (-,+)
    if (mouseX>44+40*2 && mouseX<84+40*2 && mouseY>307 && mouseY<327)
    {
      mCount=(mCount+59)%60;
    }
    if (mouseX>44+40*3 && mouseX<84+40*3 && mouseY>307 && mouseY<327)
    {
      mCount=(mCount+61)%60;
    }
    // COUNTDOWN seconds buttons (-,+)
    if (mouseX>44+40*4 && mouseX<84+40*4 && mouseY>307 && mouseY<327)
    {
      sCount=(sCount+59)%60;
    }
    if (mouseX>44+40*5 && mouseX<84+40*5 && mouseY>307 && mouseY<327)
    {
      sCount=(sCount+61)%60;
    }

    // COUNTDOWN ON/OFF button
    if (mouseX>44+40*6 && mouseX<64+40*6 && mouseY>307 && mouseY<327)
    {
      countdown = !(countdown);
      //alarm=false;
      hBase=h;
      mBase=m;
      sBase=s;
    }
  }
}


// ***************************
// mouseMoved()
// ***************************
void mouseMoved()
{
  // reset callTip string
  callTip="";
  // Set mouse cursor
  cursor(ARROW);

  // mouse over info button
  if ((mouseX>0 && mouseX<11 && mouseY>0 && mouseY<11))
  {
    cursor(HAND);
    callTip="show / hide Info [I]";
  }

  if (showInfo==false)
  {
    // mouse over alarm buttons (+,-)
    if (((mouseX>44 && mouseX<84+40*5 && mouseY>207 && mouseY<227)))
    {
      cursor(HAND);
      callTip="set Alarm hh-mm-ss [1..6]";
    }

    // mouse over alarm button (ON/OFF)
    if (((mouseX>44+40*6 && mouseX<64+40*6 && mouseY>207 && mouseY<227)))
    {
      cursor(HAND);
      callTip="alarm ON/OFF [A]";
    }

    // mouse over countdown buttons (+,-)
    if (((mouseX>44 && mouseX<84+40*5 && mouseY>307 && mouseY<327)))
    {
      cursor(HAND);
      callTip="set Timer hh-mm-ss";
    }

    // mouse over countdown button (ON/OFF)
    if (((mouseX>44+40*6 && mouseX<64+40*6 && mouseY>307 && mouseY<327)))
    {
      cursor(HAND);
      callTip="timer ON/OFF [T]";
    }
  }
}

// check if year is leap
boolean isLeap(int years)
{
  return(((years % 4 == 0) && (years % 100 != 0)) || (years % 400 == 0));
}

// calculate day of week (0=sunday)
int dayWeek(int YYY, int MMM, int DDD)
{
  int a, y, m, d;
  a=(14-MMM)/12;
  y = YYY - a;
  m = MMM + 12*a - 2;
  d = (DDD+y+y/4 - y/100 + y/400 +(31*m/12))%7;
  return(d);
}

// control alarm time
void alarmControl()
{
  if ((h==hAlarm)&&(m==mAlarm)&&(s==sAlarm))
  {
    //alarm=false;
    //println(frame.getExtendedState());
    //// If I get minimized, expand again
    //  frame.toFront();
    //  println("tofrontOUT");    
    //if (frame.getExtendedState()==1)
    //{
    //  frame.setExtendedState(0);
    //  frame.toFront();
    //  println("tofront");
    //}
    // player to beginning
    playerA.rewind();
    // play the file
    playerA.play();
    //repeat alarm after 5 minutes
    mAlarm=(mAlarm+60+repeatM)%60;
  }
}

// control countdown time
void countControl()
{
  if ((hCount==0)&&(mCount==0)&&(sCount==0))
  {
    countdown=false;
    mCount=5;
    //println(frame.getExtendedState());
    //frame.toFront();
    //println("tofrontOUT");         
    //// if minimized, then maximized
    //if (frame.getExtendedState()==1)
    //{
    //  frame.setExtendedState(0);
    //}
    // player to beginning
    playerC.rewind();
    // play the file
    playerC.play();
  }
}

// stop audio class
void stop()
{
  // Close Minim audio classes when done
  playerA.close();
  playerC.close();
  // Always stop Minim before exiting
  minim.stop();
  // secure stop
  super.stop();
}

// create icon for application
void changeAppIcon()
{
  PGraphics icon = createGraphics(16, 16, JAVA2D);
  icoR=random(255);
  icoG=random(255);
  icoB=random(255);
  // draw icon (rect with random color)
  icon.beginDraw();
  icon.noStroke();
  icon.fill(icoR,icoG,icoB);
  icon.rect(3, 3, 10, 10);
  icon.endDraw();
  // set icon
  frame.setIconImage(icon.image);
}
