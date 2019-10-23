void updateSpinners()
{
  spinners[0].setValue(matrix[0][0]);
  spinners[1].setValue(matrix[0][1]);
  spinners[2].setValue(matrix[0][2]);
  spinners[3].setValue(matrix[0][3]);
  spinners[4].setValue(matrix[0][4]);
  
  spinners[5].setValue(matrix[1][0]);
  spinners[6].setValue(matrix[1][1]);
  spinners[7].setValue(matrix[1][2]);
  spinners[8].setValue(matrix[1][3]);
  spinners[9].setValue(matrix[1][4]);
  
  spinners[10].setValue(matrix[2][0]);
  spinners[11].setValue(matrix[2][1]);
  spinners[12].setValue(matrix[2][2]);
  spinners[13].setValue(matrix[2][3]);
  spinners[14].setValue(matrix[2][4]);
  
  spinners[15].setValue(matrix[3][0]);
  spinners[16].setValue(matrix[3][1]);
  spinners[17].setValue(matrix[3][2]);
  spinners[18].setValue(matrix[3][3]);
  spinners[19].setValue(matrix[3][4]);
  
  spinners[20].setValue(matrix[4][0]);
  spinners[21].setValue(matrix[4][1]);
  spinners[22].setValue(matrix[4][2]);
  spinners[23].setValue(matrix[4][3]);
  spinners[24].setValue(matrix[4][4]);
}  

void updateMatrix()
{
  matrix[0][1]=spinners[1].getValue();
  matrix[0][0]=spinners[0].getValue();
  matrix[0][2]=spinners[2].getValue();
  matrix[0][3]=spinners[3].getValue();
  matrix[0][4]=spinners[4].getValue();
  
  matrix[1][0]=spinners[5].getValue();
  matrix[1][1]=spinners[6].getValue();
  matrix[1][2]=spinners[7].getValue();
  matrix[1][3]=spinners[8].getValue();
  matrix[1][4]=spinners[9].getValue();
  
  matrix[2][0]=spinners[10].getValue();
  matrix[2][1]=spinners[11].getValue();
  matrix[2][2]=spinners[12].getValue();
  matrix[2][3]=spinners[13].getValue();
  matrix[2][4]=spinners[14].getValue();
  
  matrix[3][0]=spinners[15].getValue();
  matrix[3][1]=spinners[16].getValue();
  matrix[3][2]=spinners[17].getValue();
  matrix[3][3]=spinners[18].getValue();
  matrix[3][4]=spinners[19].getValue();
  
  matrix[4][0]=spinners[20].getValue();
  matrix[4][1]=spinners[21].getValue();
  matrix[4][2]=spinners[22].getValue();
  matrix[4][3]=spinners[23].getValue();
  matrix[4][4]=spinners[24].getValue();
}  

void showMatrix(boolean c, boolean w)
{
  // print to console
  if (c)
  {
    for(int i=0; i<5; i++)
    {
      for(int j=0; j<5; j++)
      {
        print(nf(matrix[i][j],1,1)+" ");
      }  
      println("");
    }
    println("bias = " + bias);
    println("factor = " + factor);    
  }
  if(w)
  {
  // print to window  
    int xx = width-200;
    int yy = height-120;
    int xs = 40;
    int ys = 20;
    for(int i=0; i<5; i++)
    {
      for(int j=0; j<5; j++)
      {
        text(nf(matrix[i][j],1,1),xx + j*xs, yy + i*ys);
      }  
    }  
    text("bias: " + nf(bias,1,1), width-110, height-12);
    text("factor: " + nf(factor,1,2), width-200, height-12);    
  }  
}

void Neutral() // No filter
{ 
  println("Neutral");
  matrix[0][0]=0;  matrix[0][1]=0;  matrix[0][2]=0;  matrix[0][3]=0;  matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=0;  matrix[1][2]=0;  matrix[1][3]=0;  matrix[1][4]=0;
  matrix[2][0]=0;  matrix[2][1]=0;  matrix[2][2]=1;  matrix[2][3]=0;  matrix[2][4]=0;
  matrix[3][0]=0;  matrix[3][1]=0;  matrix[3][2]=0;  matrix[3][3]=0;  matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;  matrix[4][2]=0;  matrix[4][3]=0;  matrix[4][4]=0;
  factor = 1.0;
  bias = 0.0;
}

// This is a high-pass filter: it accentuates the edges. 
void Sharpen()
{ 
  println("Sharpen");
  matrix[0][0]=0;  matrix[0][1]=0;   matrix[0][2]=0;   matrix[0][3]=0;   matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=-1;  matrix[1][2]=-1;  matrix[1][3]=-1;  matrix[1][4]=0;
  matrix[2][0]=0;  matrix[2][1]=-1;  matrix[2][2]= 9;  matrix[2][3]=-1;  matrix[2][4]=0;
  matrix[3][0]=0;  matrix[3][1]=-1;  matrix[3][2]=-1;  matrix[3][3]=-1;  matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;   matrix[4][2]=0;   matrix[4][3]=0;   matrix[4][4]=0;
  factor = 1.0;
  bias = 0.0;
}

// This is a high-pass filter: it accentuates the edges. 
void Blur()
{ 
  println("Blur");
  matrix[0][0]=0;  matrix[0][1]=0;    matrix[0][2]=0;    matrix[0][3]=0;    matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=0;    matrix[1][2]=0.2;  matrix[1][3]=0;    matrix[1][4]=0;
  matrix[2][0]=0;  matrix[2][1]=0.2;  matrix[2][2]=0.2;  matrix[2][3]=0.2;  matrix[2][4]=0;
  matrix[3][0]=0;  matrix[3][1]=0;    matrix[3][2]=0.2;  matrix[3][3]=0;    matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;    matrix[4][2]=0;    matrix[4][3]=0;    matrix[4][4]=0;
  factor = 1.0;
  bias = 0.0;
}

void Motion()
{ 
  println("Motion");
  matrix[0][0]=1;  matrix[0][1]=0;   matrix[0][2]=0;   matrix[0][3]=0;   matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=1;   matrix[1][2]=0;   matrix[1][3]=0;   matrix[1][4]=0;
  matrix[2][0]=0;  matrix[2][1]=0;   matrix[2][2]=1;   matrix[2][3]=0;   matrix[2][4]=0;
  matrix[3][0]=0;  matrix[3][1]=0;   matrix[3][2]=0;   matrix[3][3]=1;   matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;   matrix[4][2]=0;   matrix[4][3]=0;   matrix[4][4]=1;
  factor = 0.2;
  bias = 0.0;
}

void Emboss()
{ 
  println("Emboss");
  matrix[0][0]=0;  matrix[0][1]=0;   matrix[0][2]=0;   matrix[0][3]=0;   matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=-1;  matrix[1][2]=-1;  matrix[1][3]=0;   matrix[1][4]=0;
  matrix[2][0]=0;  matrix[2][1]=-1;  matrix[2][2]=0;   matrix[2][3]=1;   matrix[2][4]=0;
  matrix[3][0]=0;  matrix[3][1]=0;   matrix[3][2]=1;   matrix[3][3]=1;   matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;   matrix[4][2]=0;   matrix[4][3]=0;   matrix[4][4]=1;
  factor = 1.0;
  bias = 0.0;
}

void Blur2()
{ 
  println("Blur2");
  matrix[0][0]=0;  matrix[0][1]=0;   matrix[0][2]=1;   matrix[0][3]=0;   matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=1;   matrix[1][2]=1;   matrix[1][3]=1;   matrix[1][4]=0;
  matrix[2][0]=1;  matrix[2][1]=1;   matrix[2][2]=1;   matrix[2][3]=1;   matrix[2][4]=1;
  matrix[3][0]=0;  matrix[3][1]=1;   matrix[3][2]=1;   matrix[3][3]=1;   matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;   matrix[4][2]=1;   matrix[4][3]=0;   matrix[4][4]=0;
  factor = 0.08;
  bias = 0.0;
}

void Boost()
{ 
  println("Boost");
  matrix[0][0]=0;  matrix[0][1]=0;   matrix[0][2]=0;   matrix[0][3]=0;   matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=0;   matrix[1][2]=0;   matrix[1][3]=0;   matrix[1][4]=0;
  matrix[2][0]=0;  matrix[2][1]=-1;  matrix[2][2]=1;  matrix[2][3]=0;   matrix[2][4]=0;
  matrix[3][0]=0;  matrix[3][1]=0;   matrix[3][2]=0;   matrix[3][3]=0;   matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;   matrix[4][2]=0;   matrix[4][3]=0;   matrix[4][4]=0;
  factor = 1.0;
  bias = 0.0;
}

void Tabita()
{ 
  println("Tabita");
  matrix[0][0]=3;  matrix[0][1]=3;   matrix[0][2]=4;   matrix[0][3]=5;   matrix[0][4]=6;
  matrix[1][0]=3;  matrix[1][1]=4;   matrix[1][2]=3;   matrix[1][3]=6;   matrix[1][4]=7;
  matrix[2][0]=3;  matrix[2][1]=3;   matrix[2][2]=4;   matrix[2][3]=8;   matrix[2][4]=3;
  matrix[3][0]=9;  matrix[3][1]=2;   matrix[3][2]=3;   matrix[3][3]=2;   matrix[3][4]=1;
  matrix[4][0]=8;  matrix[4][1]=5;   matrix[4][2]=3;   matrix[4][3]=2;   matrix[4][4]=6;
  factor = 0.01;
  bias = 0.0;
}

void Sharpen2()
{ 
  println("Sharpen2");
  matrix[0][0]=0;   matrix[0][1]=-1;  matrix[0][2]=-1;   matrix[0][3]=-1;   matrix[0][4]=0;
  matrix[1][0]=-1;  matrix[1][1]=2;   matrix[1][2]=-4;   matrix[1][3]=2;    matrix[1][4]=-1;
  matrix[2][0]=-1;  matrix[2][1]=-4;  matrix[2][2]=13;   matrix[2][3]=-4;   matrix[2][4]=-1;
  matrix[3][0]=-1;  matrix[3][1]=2;   matrix[3][2]=-4;   matrix[3][3]=2;    matrix[3][4]=-1;
  matrix[4][0]=0;   matrix[4][1]=-1;  matrix[4][2]=-1;   matrix[4][3]=-1;   matrix[4][4]=0;
  factor = 100.0;
  bias = 0.0;
}

void Laplace()
{ 
  println("Laplace");
  matrix[0][0]=1;  matrix[0][1]=1;   matrix[0][2]=1;   matrix[0][3]=1;   matrix[0][4]=1;
  matrix[1][0]=1;  matrix[1][1]=1;   matrix[1][2]=1;   matrix[1][3]=1;   matrix[1][4]=1;
  matrix[2][0]=1;  matrix[2][1]=1;   matrix[2][2]=24;  matrix[2][3]=1;   matrix[2][4]=1;
  matrix[3][0]=1;  matrix[3][1]=1;   matrix[3][2]=1;   matrix[3][3]=1;   matrix[3][4]=1;
  matrix[4][0]=1;  matrix[4][1]=1;   matrix[4][2]=1;   matrix[4][3]=1;   matrix[4][4]=1;
  factor = 0.02;
  bias = 0.0;
}

void Enhance()
{ 
  println("Enhance");
  matrix[0][0]=0;  matrix[0][1]=0;   matrix[0][2]=0;   matrix[0][3]=0;   matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=-1;  matrix[1][2]=-1;  matrix[1][3]=-1;  matrix[1][4]=0;
  matrix[2][0]=0;  matrix[2][1]=-1;  matrix[2][2]=24;  matrix[2][3]=-1;  matrix[2][4]=0;
  matrix[3][0]=0;  matrix[3][1]=-1;  matrix[3][2]=-1;  matrix[3][3]=-1;  matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;   matrix[4][2]=0;   matrix[4][3]=0;   matrix[4][4]=1;
  factor = 0.06;
  bias = 0.0;
}

void rndMatrix()
{ 
  int maxVal=5;
  println("Random");
  matrix[0][0]=int(random(-maxVal,maxVal));  
  matrix[0][1]=int(random(-maxVal,maxVal));
  matrix[0][2]=int(random(-maxVal,maxVal));
  matrix[0][3]=int(random(-maxVal,maxVal));
  matrix[0][4]=int(random(-maxVal,maxVal));
  
  matrix[1][0]=int(random(-maxVal,maxVal));
  matrix[1][1]=int(random(-maxVal,maxVal));   
  matrix[1][2]=int(random(-maxVal,maxVal));
  matrix[1][3]=int(random(-maxVal,maxVal));
  matrix[1][4]=int(random(-maxVal,maxVal));
  
  matrix[2][0]=int(random(-maxVal,maxVal));  
  matrix[2][1]=int(random(-maxVal,maxVal));   
  matrix[2][2]=int(random(-maxVal,maxVal));
  matrix[2][3]=int(random(-maxVal,maxVal));
  matrix[2][4]=int(random(-maxVal,maxVal));
  
  matrix[3][0]=int(random(-maxVal,maxVal));
  matrix[3][1]=int(random(-maxVal,maxVal));   
  matrix[3][2]=int(random(-maxVal,maxVal));
  matrix[3][3]=int(random(-maxVal,maxVal));
  matrix[3][4]=int(random(-maxVal,maxVal));
  
  matrix[4][0]=int(random(-maxVal,maxVal));
  matrix[4][1]=int(random(-maxVal,maxVal));
  matrix[4][2]=int(random(-maxVal,maxVal));
  matrix[4][3]=int(random(-maxVal,maxVal));
  matrix[4][4]=int(random(-maxVal,maxVal));
  
  factor = 1.0;
  bias = 0.0;
  
  float central=0;
  for(int i=0; i<5; i++)
  {
    for(int j=0; j<5; j++)
    {
      central=central+matrix[i][j];
    }  
  }
  //matrix[2][2]=(central-matrix[2][2])*(-1);
}

void demo()
{ 
  println("demo");
  matrix[0][0]=1;  matrix[0][1]=0;   matrix[0][2]=0;   matrix[0][3]=0;   matrix[0][4]=0;
  matrix[1][0]=0;  matrix[1][1]=1;   matrix[1][2]=0;   matrix[1][3]=0;   matrix[1][4]=0;
  matrix[2][0]=0;  matrix[2][1]=0;   matrix[2][2]=1;   matrix[2][3]=0;   matrix[2][4]=0;
  matrix[3][0]=0;  matrix[3][1]=0;   matrix[3][2]=0;   matrix[3][3]=1;   matrix[3][4]=0;
  matrix[4][0]=0;  matrix[4][1]=0;   matrix[4][2]=0;   matrix[4][3]=0;   matrix[4][4]=1;
  factor = 1.0;
  bias = 0.0;
}