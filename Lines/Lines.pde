// Lines
// forked from https://github.com/jing-interactive/processing-portfolio/tree/master/ColorLines4M
// by cameyo 2016
// processing 3.x
//

final color[] ballColors =
{
    //color(220,50,47), // red
    color(211,54,130), // magenta
    color(108,113,196), // violet
    color(181,137,0), // yellow
    color(133,153,0), // green
    color(38,139,210), // blue
    color(42,161,152), // cyan
    color(203,75,22), // orange
    //color(22,22,22), // black    
};

final int kCellCount = 9;
final int kBallRadius = 48;
final int kSpacing = kBallRadius/2;
final int kCellSize = int(kBallRadius*1.4f);
final int kBoardSize = kCellSize * kCellCount;
final int kNewBallCount = 3;
final int kMinMatchBallCount = 5;

int score = 0;
int highScore = 0;

final int kEmptyCell = -1;
final int kInvalidIndex = -11;

int[][] cells = new int[kCellCount][kCellCount];
int[] newBallIndices = new int[kNewBallCount];
int[] newBallCols = new int[kNewBallCount];
int[] newBallRow = new int[kNewBallCount];

int currentCol, currentRow;
int targetCol, targetRow;

boolean pathNotFound;
boolean readyForNewBalls;
Pathfinder pathfinder;

PFont font;

void setup()
{
  size(720, 720);
  //size(720, 720);
  // APDE for Android
  //orientation(PORTRAIT);
  smooth();
  frameRate(30);
  font = createFont("Consolas Bold", 36);
  textFont(font);
  textAlign(LEFT);
  //textSize(20);
  try
  {
    String lines[] = loadStrings("score.txt");
    highScore = int(lines[0]);
  }
  catch (Exception err)
  {
    highScore = 0;
  }
  resetGame();
}

int mouseToCell(float mouseXY)
{
    float c = (mouseXY - kSpacing)/kCellSize;
    if (c >= 0 && c < kCellCount)
        return int(c);
    else
        return kInvalidIndex;
}

float cellToDraw(float cellXY)
{
    return cellXY*kCellSize + kSpacing;
}

void mouseReleased()
{
  int col = mouseToCell(mouseX);
  int row = mouseToCell(mouseY);
  pathNotFound = false;
  if (col >= 0 && row >= 0)
  {
    int hitCellIndex = cells[row][col];
    if (hitCellIndex != kEmptyCell)
    {
      // select
      currentCol = col;
      currentRow = row;
      pathfinder.setBot(0, currentRow, currentCol);
    }
    else
    {
      if (currentCol >= 0 && currentRow >= 0)
      {
        // move
        // 0.path finding
        pathfinder.setTarget(0, row, col);
        if (!pathfinder.findPath(0, 0, false))
        {
          pathNotFound = true;
          return;
        }

        // 1.swap
        setIndex(row, col, cells[currentRow][currentCol]);
        setIndex(currentRow, currentCol, kEmptyCell);

        // 2.invalidate
        currentCol = kInvalidIndex;
        currentRow = kInvalidIndex;

        // 3.add new balls
        if (checkFiveBalls())
            readyForNewBalls = false;
        else
            readyForNewBalls = true;
      }
    }
  }
}

void mousePressed()
{
   int mx = mouseX;
   int my = mouseY;
   if ( (mx > kSpacing) && (mx < kSpacing+2*kCellSize) && (my > kBoardSize+2*kSpacing) && (my < kBoardSize+2*kSpacing+2*kSpacing) )
   {  
      fill(147,161,161);
      rect(kSpacing,kBoardSize+2*kSpacing,2*kCellSize,2*kSpacing);   
      resetGame();
   }
}

void keyPressed()
{
  if (key == 'n') { resetGame(); }
  if (key == 's') { saveFrame("line-######.png"); }
}

void draw()
{
  if (readyForNewBalls)
  {
    generateNewBalls(false);
    checkFiveBalls();
  }

  background(0, 43, 54);
  {
      // the board background
      fill(7, 54, 66);
      rectMode(CORNER);
      rect(kSpacing, kSpacing, kBoardSize, kBoardSize);
  }
  {
      // the board lines
      noFill();
      //base01
      stroke(88,110,117);
      for (int row=0;row<kCellCount+1;row++)
      {
          float y = cellToDraw(row);
          line(kSpacing, y, kSpacing+kBoardSize, y);
      }

      for (int col=0;col<kCellCount+1;col++)
      {
          float x = cellToDraw(col);
          line(x, kSpacing, x, kSpacing+kBoardSize);
      }
  }
  {
      // next three balls
      for (int ball=0; ball<kNewBallCount; ball++)
      {
          fill(ballColors[newBallIndices[ball]]);
          noStroke();
          strokeWeight(1);
          ellipse(cellToDraw(kCellCount+0.7f), cellToDraw(ball+1), // (cx,cy)
          kBallRadius*0.6f, kBallRadius*0.6f);// (w, h)
          // simulate 3D ball
          for(int i=0; i<(kBallRadius*0.6f)/2; i++)
          {
            fill(253,246,227,6);
            ellipse(cellToDraw(kCellCount+0.7f), cellToDraw(ball+1),(i+1)*2,(i+1)*2);
          }
          
      }
  }
  {
      // balls
      for (int col=0; col<kCellCount; col++)
      {
          for (int row=0; row<kCellCount; row++)
          {
              if (cells[row][col] != kEmptyCell)
              {
                  int colorIndex = cells[row][col];
                  color clr = ballColors[colorIndex];
                  ellipseMode(CENTER);

                  if (col == currentCol && row == currentRow)
                  {
                      // draw the selected ball
                      stroke(2, 83, 84);
                      stroke(147,161,161);
                      strokeWeight(3);
                      noFill();
                      ellipse(cellToDraw(col+0.5f), cellToDraw(row+0.5f), // (cx,cy)
                      kBallRadius*1.2f, kBallRadius*1.2f);// (w, h)
                  }
                  fill(clr);
                  noStroke();
                  strokeWeight(1);
                  ellipse(cellToDraw(col+0.5f), cellToDraw(row+0.5f), // (cx,cy)
                  kBallRadius, kBallRadius);// (w, h)
                  // simulate 3D ball
                  for(int i=0; i<kBallRadius/2; i++)
                  {
                    fill(253,246,227,4);
                    ellipse(cellToDraw(col+0.5f),cellToDraw(row+0.5f),(i+1)*2,(i+1)*2);
                  }
              }
          }
      }
  }

    // draw "LINES" text
    textSize(72);    
    textAlign(CENTER);    
    fill(147,161,161);
    text("L",cellToDraw(kCellCount+0.7f), cellToDraw(5));
    text("I",cellToDraw(kCellCount+0.7f), cellToDraw(6));
    text("N",cellToDraw(kCellCount+0.7f), cellToDraw(7));
    text("E",cellToDraw(kCellCount+0.7f), cellToDraw(8));
    text("S",cellToDraw(kCellCount+0.7f), cellToDraw(9));
    // 3D effect    
    fill(147,161,161,60);
    text("L",cellToDraw(kCellCount+0.7f)+3, cellToDraw(5)+3);    
    text("I",cellToDraw(kCellCount+0.7f)+3, cellToDraw(6)+3);
    text("N",cellToDraw(kCellCount+0.7f)+3, cellToDraw(7)+3);
    text("E",cellToDraw(kCellCount+0.7f)+3, cellToDraw(8)+3);
    text("S",cellToDraw(kCellCount+0.7f)+3, cellToDraw(9)+3);    
 
    // draw text "NEXT"
    textSize(24);    
    fill(147,161,161);
    text("NEXT",cellToDraw(kCellCount+0.7f), cellToDraw(0.25f));
    // 3d effect
    fill(147,161,161,60);        
    text("NEXT",cellToDraw(kCellCount+0.7f)+1, cellToDraw(0.25f)+1);
    
    // draw button "NEW GAME"
    stroke(88,110,117);
    strokeWeight(2);
    fill(7,54,66);
    rect(kSpacing,kBoardSize+2*kSpacing,2*kCellSize,2*kSpacing);
    strokeWeight(1);
    fill(147,161,161);
    textSize(26);
    text("NEW GAME",kSpacing+kCellSize+1,kBoardSize+kSpacing+kCellSize/1.2+1);
    fill(147,161,161,60);
    text("NEW GAME",kSpacing+kCellSize+2,kBoardSize+kSpacing+kCellSize/1.2+2);
    
    // draw text "SCORE" and "HIGH" score
    textAlign(LEFT);
    textSize(36);
    fill(147,161,161);
    text(" HIGH: "+ highScore, kSpacing+kCellSize*2.5,kBoardSize+2.5*kSpacing);
    text("SCORE: " + score, kSpacing+kCellSize*2.5,kBoardSize+4.3*kSpacing);        
    // 3D effect
    fill(147,161,161,60);    
    text(" HIGH: "+ highScore, kSpacing+kCellSize*2.5+2,kBoardSize+2.5*kSpacing+2);
    text("SCORE: " + score, kSpacing+kCellSize*2.5+2,kBoardSize+4.3*kSpacing+2);
    
    // draw "UNREACHABLE CELL" text
    if (pathNotFound)
    {
      textSize(24);
      fill(220,50,47);
      text("UNREACHABLE CELL", kSpacing+kCellSize*6.5,kBoardSize+3.3*kSpacing-1);
    }
}

void generateNewBalls(boolean firstTime)
{
    int currentBallCount = 0;
    for (int col=0; col<kCellCount; col++)
    {
        for (int row=0; row<kCellCount; row++)
        {
            if (cells[row][col] != kEmptyCell)
            {
                currentBallCount++;
            }
        }
    }
    if (currentBallCount >= kCellCount*kCellCount - 3)
    {
        resetGame();
        return;
    }

    int ballCount = firstTime ? kNewBallCount + 1 : kNewBallCount;
    for (int ball=0;ball<ballCount;ball++)
    {
        // random colors
        int index = int(random(ballColors.length));
        // random position
        while (true)
        {
            int row = (int)random(kCellCount);
            int col = (int)random(kCellCount);
            if (cells[row][col] == kEmptyCell)
            {
                if (firstTime)
                {
                    setIndex(row, col, index);
                }
                else
                {
                    setIndex(row, col, newBallIndices[ball]);
                }
                // print('('+row+","+col+")="+newBallIndices[ball]+"   ");
                // print(index+"   ");
                if (ball < 3)
                {
                    newBallIndices[ball] = index;
                }
                break;
            }
        }
    }
    // print("\n");
    readyForNewBalls = false;
}

int index(int row, int col)
{
    return cells[row][col];
}

void setIndex(int row, int col, int index)
{
    cells[row][col] = index;
    pathfinder.setGrid(row, col, index != kEmptyCell ? -1 : 0);
}

boolean checkFiveBalls()
{
    ArrayList<PVector>[] initials = new ArrayList[4];
    PVector[] deltas = new PVector[4];
    {
        // dir#0
        initials[0] = new ArrayList<PVector>();
        for (int row=0; row<kCellCount; row++)
        {
            initials[0].add(new PVector(row, 0));
        }
        deltas[0] = new PVector(0, 1);

        // dir#1
        initials[1] = new ArrayList<PVector>();
        for (int col=0; col<kCellCount; col++)
        {
            initials[1].add(new PVector(0, col));
        }
        deltas[1] = new PVector(1, 0);

        // dir#2
        initials[2] = new ArrayList<PVector>();
        for (int row=0; row<kCellCount; row++)
        {
            initials[2].add(new PVector(row, 0));
        }
        for (int col=0; col<kCellCount; col++)
        {
            initials[2].add(new PVector(0, col));
        }
        deltas[2] = new PVector(1, 1);

        // dir#3
        initials[3] = new ArrayList<PVector>();
        for (int row=0; row<kCellCount; row++)
        {
            initials[3].add(new PVector(row, 0));
        }
        for (int col=0; col<kCellCount; col++)
        {
            initials[3].add(new PVector(kCellCount-1, col));
        }
        deltas[3] = new PVector(-1, 1);
    }

    ArrayList<PVector> totalBallsToVanish = new ArrayList<PVector>();
    for (int dir=0;dir < 4;dir++)
    {
        for (PVector initial : initials[dir])
        {
            PVector head = initial.get();
            while (head.x >= 0 && head.x < kCellCount &&
                head.y >= 0 && head.y < kCellCount)
            {
                int idxForTest = index((int)head.x, (int)head.y);
                if (idxForTest != kEmptyCell)
                {
                    ArrayList<PVector> ballsToVanish = new ArrayList<PVector>();
                    PVector next = head.get();
                    ballsToVanish.add(head.get());
                    next.add(deltas[dir]);
                    while (next.x >= 0 && next.x < kCellCount &&
                        next.y >= 0 && next.y < kCellCount)
                    {
                        if (index((int)next.x, (int)next.y) != idxForTest)
                        {
                            head = next.get();
                            head.sub(deltas[dir]);// to save computation
                            break;
                        }
                        // println(head+"->"+next);
                        ballsToVanish.add(next.get());
                        next.add(deltas[dir]);
                    }
                    if (ballsToVanish.size() >= kMinMatchBallCount)
                    {
                        for (PVector p : ballsToVanish)
                            totalBallsToVanish.add(p);
                    }
                }
                head.add(deltas[dir]);
            }
        }
    }
    return testBalls(totalBallsToVanish);
}

boolean testBalls(ArrayList<PVector> ballsToVanish)
{
    if (ballsToVanish.isEmpty())
        return false;

    for (PVector pos : ballsToVanish)
    {
        // print(pos.x+","+pos.y+" ");
        setIndex((int)pos.x, (int)pos.y, kEmptyCell);
    }
    // println("");
    int size = ballsToVanish.size();
    score += size*10;
    if (size > kMinMatchBallCount)
        score += (size - kMinMatchBallCount)*(size - kMinMatchBallCount)*10;

    return true;
}

void resetGame()
{
    pathNotFound = false;
    if (score > highScore)
    {
        highScore = score;
        String[] list = {
            ""+highScore
        };

//        println(list);
        saveStrings("score.txt", list);
    }

    for (int col=0; col<kCellCount; col++)
    {
        for (int row=0; row<kCellCount; row++)
        {
            cells[row][col] = kEmptyCell;
        }
    }
    currentCol = currentRow = kInvalidIndex;
    targetCol = targetRow = kInvalidIndex;

    pathfinder = new Pathfinder(kCellCount, kCellCount, 1, 1);

    readyForNewBalls = false;
    generateNewBalls(true);
    score = 0;
}

