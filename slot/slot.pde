// **************************************************
// * slotmachine.pde
// * by cameyo 2016
// *
// * Slot machine with three reels and nine symbols
// *
// * Processing 3.x
// **************************************************
//
// NB: For any combination to win, 
//     the reels MUST have at least two identical symbols one after another, 
//     and the first one MUST occur on the first reel. 
//     Otherwise the combination doesn’t pay out.

PImage slot;
PImage reel;
String[] sym = {"UVA", "ARANCIO", "BAR", "CAMPANELLO", "SETTE", "LIMONE", "CILIEGE", "ANGURIA", "PRUGNA"};
int[] tic = {0, 137, 274, 411, 547, 685, 822, 959, 1096};
int[] posY = new int[3];
int[] speed = new int[3];
int[] res = new int[3];
int[] who = new int[3];
String result;
int base;
boolean start;
boolean initSpeed;
int rolltime;
int timer; 
 
void setup() 
{
  size(720, 685);
  //fullScreen();
  background(0);  
  slot = loadImage("slot.png");
  reel = loadImage("reel.png");
  base=0;
  start = false;
  initSpeed = true;
  timer = 0;
  rolltime = 300;
  posY[0] = base;
  posY[1] = base;
  posY[2] = base;
}
 
void draw() 
{
  background(0);
  // display reels (each reel -> 2 image)
  // reel 1
  image(reel, width/2 - reel.width/2 - reel.width, posY[0]);
  image(reel, width/2 - reel.width/2 - reel.width, posY[0]-reel.height);  
  // reel 2
  image(reel, width/2-reel.width/2, posY[1]);
  image(reel, width/2-reel.width/2, posY[1]-reel.height);
  // reel 3
  image(reel, width/2 - reel.width/2 + reel.width, posY[2]);
  image(reel, width/2 - reel.width/2 + reel.width, posY[2]-reel.height);
  // start rolling
  if (start)
  {
    if (initSpeed) //set initial rolling speed
    {
      initSpeed=false;
      for(int i=0; i<3; i++)
      {
        // for a given rolltime: [min speed, max speed] --> [sym1, sym2, ..., sym9]
        speed[i] = int(random(100,114));
        who[i] = int(random(0,9));
        //speed[i]=112;
      }  
      println(speed[0],speed[1],speed[2]);      
      println(sym[who[0]],sym[who[1]],sym[who[2]]);        
      // start timer
      timer = millis();
    }
    // rolling at initial random speed
    if (rolltime > millis() - timer)
    {
      for(int i=0; i<3; i++)
      {
        posY[i] = posY[i] + speed[i];
      }
    }
    else // rolling at decreasing speed until next symbols
    {
      
      for(int i=0; i<3; i++)
      {
        if (speed[i] != 0 ) 
        { 
          speed[i] = speed[i] - 1; 
          if (speed[i] < 1) 
          {
            speed[i] = 1;
            // check if posY[i] is on one symbols (tic values)            
            for(int k=0; k<9; k++)
            {
              if (posY[i] == tic[k] ) 
              { 
                speed[i] = 0; 
                res[i] = k;
                //println(k); 
              }
            }
          }
        }        
      }
      // update reels position
      posY[0] = posY[0] + speed[0];
      posY[1] = posY[1] + speed[1];
      posY[2] = posY[2] + speed[2];
    }  
      
    // check if reset position of reels
    if (posY[0] >=  base + reel.height)
    {
      posY[0]=base;
    }
    if (posY[1] >= base + reel.height)
    {
      posY[1]=base;
    }  
      if (posY[2] >= base + reel.height)
    {
      posY[2]=base;
    }
  }

  //show slot image
  image(slot,width/2-slot.width/2,0);
  
  // draw center line of symbols outcome
  stroke(0,160);
  line(0,342,width,342);
  
  // check end of rolling
  if ((speed[0] == 0) && (speed[1] == 0) && (speed[2] == 0) && (start))
  {
    //println("stopped");
    println(posY[0], posY[1], posY[2]);
    println(sym[res[0]], sym[res[1]], sym[res[2]]);    
    start = false;
    initSpeed= true;
    checkResult();
  }  

}

void checkResult()
{ 
   result = "";
  // check for tris
  if(res[0]==res[1]&&res[1]==res[2])
  {
    result = "tris";
    println("TRIS: " + sym[res[0]]);
    // three SEVEN ?
    if(res[0]==4) 
    { 
      result = "jack";
      println("JACKPOT"); 
    }
    return;
  }  
  //check for pair
  if (res[0]==res[1])
  {
    result = "pair";
    println("PAIR: " + sym[res[0]]);
  }  
  if (res[1]==res[2])
  {
    result = "pair";
    println("PAIR: " + sym[res[1]]);
  }    
  if (res[2]==res[0])
  {
    result = "pair";
    println("PAIR: " + sym[res[2]]);
  }      

 }

void mousePressed()
{
  // push ROLL button
  if ((mouseX > 480) && (mouseX < 678) && (mouseY > 679) && (mouseY < 789))
  {
    start = (!start);
    result = "";
    posY[0] = base; 
    posY[1] = base; 
    posY[2] = base;
  }
}
//*********************************
void keyPressed()
{
  // start/stop rolling
  if (key==' ')
  {
    start = (!start);
    initSpeed = true;
    result = "";
    
    posY[0] = base; 
    posY[1] = base; 
    posY[2] = base;
  }
  // roll UP 
  if (keyCode==UP)
  {
    posY[0] += -1;
    posY[1] += -1;
    posY[2] += -1;
    if (posY[0] >=  base + reel.height)
    {
      posY[0]=base;
    }
    if (posY[1] >= base + reel.height)
    {
      posY[1]=base;
    }  
      if (posY[2] >= base + reel.height)
    {
      posY[2]=base;
    }    
    println(posY[0], posY[1], posY[2]);
  }  
  // roll DOWN 
  if (keyCode==DOWN)
  {
    posY[0] += 1;
    posY[1] += 1;
    posY[2] += 1;
    if (posY[0] >=  base + reel.height)
    {
      posY[0]=base;
    }
    if (posY[1] >= base + reel.height)
    {
      posY[1]=base;
    }  
      if (posY[2] >= base + reel.height)
    {
      posY[2]=base;
    }    
    println(posY[0], posY[1], posY[2]);
  }    
  // save image
  if (key=='s'||key=='S')
  {
    saveImage();
  }  
}
//*********************************
void saveImage()
{
  String filename = newFilename();
  save(filename+".png");
}

//*********************************
String newFilename()
{
  int y, m, d;
  int hh, mm, ss;
  String name, out;
  y=year();   m=month();    d=day();
  hh=hour();  mm=minute();  ss=second();
  name = getClass().getSimpleName();
  out=name+"_"+y+"-"+nf(m, 2)+"-"+nf(d, 2)+"_"+nf(hh, 2)+"."+nf(mm, 2)+"."+nf(ss, 2);
  return out;
}