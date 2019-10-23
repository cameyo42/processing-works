// Random Army War
// WalkWar.pde
// cameyo 2005
// processing 3.x
//
// Rules:
// Soldiers Army Meet -> one die 
// Border Collision -> continue

int numWalkerA = 1000;
int numWalkerB = 1000;
int aliveA, aliveB;
int cxA, cyA;
int cxB, cyB;
int dX, dY;
Walker[] wA = new Walker[numWalkerA];
Walker[] wB = new Walker[numWalkerB];
int numMove;

// palette
color[] base = {#002b36, #073642, #586e75, #657b83, #839496, #93a1a1, #eee8d5, #fdf6e3};
color[] hues = {#b58900, #cb4b16, #dc322f, #d33682, #6c71c4, #268bd2, #2aa198, #859900};

void setup() {
  size(600,600);
  frameRate(1000);
  numMove=0;
  aliveA = numWalkerA;
  aliveB = numWalkerB;
  dX=0;
  dY=0;
  // Create walkerA objects
  color cc = color(hues[(int)random(0,7)]);  
  for (int i=0; i<numWalkerA; i++)
  { 
    wA[i] = new Walker((int) random(200,width/2 - 10), (int) random(0,height), cc, true);
    //wA[i] = new Walker((int) random(0,width), (int) random(0,height), #dc322f, true);
    //wA[i] = new Walker((int) random(0,width), (int) random(0,height), hues[(int)random(0,7)], true);
  }
  // Create walkerB objects
  cc = color(hues[(int)random(0,7)]);  
  for (int i=0; i<numWalkerB; i++)
  {
    wB[i] = new Walker((int) random(width/2 + 10,width-200), (int) random(0,height), cc, true);
    //wB[i] = new Walker((int) random(0,width), (int) random(0,height), #268bd2, true);
    //wB[i] = new Walker((int) random(0,width), (int) random(0,height), hues[(int)random(0,7)], true);
  }    
  background(#eee8d5);
}

void draw() 
{
  // calc mass center
  //cxA=0; cyA=0;
  //cxB=0; cyB=0;
  //int k = 0;
  //for (int i=0; i<numWalkerA; i++)
  //{
    
  //  if (wA[i].a)
  //  {
  //    k++;
  //    cxA += wA[i].x;
  //    cyA += wA[i].y;
  //  }
  //}
  //cxA=cxA/k;
  //cyA=cyA/k;

  //k = 0;
  //for (int i=0; i<numWalkerB; i++)
  //{
    
  //  if (wB[i].a)
  //  {
  //    k++;
  //    cxB += wB[i].x;
  //    cyB += wB[i].y;
  //  }
  //}
  //cxB=cxB/k;
  //cyB=cyB/k;
  //println(cxA,cyA,cxB,cyB);
     
  // Run all the walker objects
  // walkerA
  for (int i=0; i<numWalkerA; i++)
  {
    wA[i].move();
    wA[i].show();
  }
  //walkerB
  for (int i=0; i<numWalkerB; i++)
  {
    wB[i].move();
    wB[i].show();
  }
  numMove++;
  // check collision
  //noFill();
  //stroke(base[int((random(0,8)))],100);
  for (int i=0; i<numWalkerA; i++)
  {
    for (int j=0; j<numWalkerB; j++)
    {
      if(wA[i].a && wB[j].a)
      {
        if((wA[i].x==wB[j].x) && (wA[i].y==wB[j].y))
        {
          if(random(0,1) < 0.5) 
          { 
            wA[i].a=false;
            aliveA-=1;            
          }
          else 
          { 
            wB[j].a=false;
            aliveB-=1;            
          }
          //ellipse(w[j].x,w[j].y,10,10);
          //println(aliveA,aliveB,i,j);        
        }
      }  
    }
  }
  if (aliveA <= 10 || aliveB <= 10) 
  {
    info();
    println("stopped.");
    noLoop();
  }
  //noLoop();
}

void keyPressed()
{
  if (key==' ')
  {
    loop();
  }  
  
  if (key=='f'||key=='F')
  {
    info();
  }

  // save image and parameters
  if (key=='s'||key=='S') { saveIMG(); }
  
}

void info()
{
  String FM = "R="+aliveA+", "+"B="+aliveB+" --- framerate="; 
  FM = FM + nf(frameRate, 0, 0);
  surface.setTitle(FM);
}    

void saveIMG()
{
  String filename = newFilename();
  save(filename+".png");
}

String newFilename()
{
  int y, m, d;
  int hh, mm, ss;
  String name, out;
  y=year(); 
  m=month(); 
  d=day();
  hh=hour(); 
  mm=minute(); 
  ss=second();
  name=getClass().getSimpleName();
  out=name+"-"+y+"-"+nf(m, 2)+"-"+nf(d, 2)+"."+nf(hh, 2)+"-"+nf(mm, 2)+"-"+nf(ss, 2);
  return out;
}