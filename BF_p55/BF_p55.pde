// BF_p55.pde
// Simple brainfuck interpreter
// The program MUST be valid (no error check)
// processing 3.x
// cameyo 2016 - MIT license
// http://unnikked.ga/how-to-build-a-brainfuck-interpreter/

// Input dialog
import javax.swing.JOptionPane;
// System eol (end of line)
public static String newline = System.getProperty("line.separator");

// font
PFont font;
// Brainfuck interpreter
Brainfuck bf = new Brainfuck();
// brainfuck program file
String filename;
// brainfuck program lines
String lines[];
// program code
String program="";
// data input
String dataIn;
// data output
String dataOut;
// boolean state
boolean isHelping;
boolean isLoading;
boolean isRunning;

//*********************************
void setup()
{
  size(800, 600);
  smooth();
  surface.setTitle("Brainfuck Interpreter - [F1] help  :  [F2] open file  :  [F3] run  :  [F4] save screen");
  background(#002b36);  
  //background(0);
  // set font
  font = createFont("Consolas Bold", 14);
  textFont(font);
  // load bf program
  filename="hello.bf";  
  lines = loadStrings(filename);
  program = "";
  for (int i = 0 ; i < lines.length; i++) 
  {
    program = program + lines[i];
  }
  dataIn = "";
  dataOut = "";
  // initialize variables
  init();
}
//*********************************
void init()
{
  isHelping = false;
  isLoading = true;
  isRunning = false;
}
//*********************************
void draw()
{
  if (isLoading)
  {
    noStroke();
    fill(#002b36);
    rect(0,0,width,height-100);  // clear screen
    fill(#b58900);
    text(filename,10,20); // write program file name
    fill(#93a1a1);
    for (int i = 0 ; i < lines.length; i++) // write program lines
    {
      textAlign(RIGHT);
      fill(#657b83);      
      text((i + 1) + ": ", 40, 40+(14*i));
      textAlign(LEFT);
      fill(#93a1a1);      
      text(lines[i], 40, 40+(14*i));
    }
    fill(#073642);
    rect(0, height-80, width, height); // clear output
    fill(#fdf6e3);
    text(":", 2, height - 66);
    fill(#fdf6e3);
    int nRow = 0;
    int nChar = 0;
    for(int i = 0; i < dataOut.length(); i++) // write output
    {
      text(dataOut.charAt(i), 20 + (8*nChar), height - 66 + (10*nRow));
      nChar++;
      if (nChar > 94)
      {  
        nChar = 0;
        nRow++;
      }
    }  
    fill(0);
    rect(0, height-100, width, 20); // clear input
    fill(#cb4b16); // write input data
    text(":", 2, height - 86); //<>//
    text(dataIn, 20, height - 86);
    isLoading = false;
  }
  
  if (isRunning)
  {
    fill(#073642);
    rect(0, height-80, width, height); // clear output
    fill(#fdf6e3);
    text(":", 2, height - 66);    
    fill(0);
    rect(0, height-100, width, 20); // clear input
    fill(#cb4b16); // write input data
    text(":", 2, height - 86);    
    text(dataIn, 20, height - 86);
    // run interpreter
    println("");
    bf.reset();
    bf.interpret(program, dataIn);
    isRunning = false;
  }
   
  if (isHelping)
  {
    stroke(0);
    fill(#586e75);
    fill(30);
    rectMode(CENTER);
    rect(width/2, height/2, 500, 390);
    rectMode(CORNER);
    fill(#268bd2);
    textAlign(CENTER);
    text("BRAINFUCK INTERPRETER by cameyo (2016)", width/2, height/2 - 180);
    textAlign(LEFT);
    textSize(11);
    fill(#eee8d5);
    text("Any character not ><+-.,[] is ignored.", 160, height/2 - 160);
    text("Brainfuck is represented by an array with 65,535 cells initialized to zero and ", 160, height/2 - 146); 
    text("a data pointer pointing at the current cell.", 160, height/2 - 132);
    text("There are eight commands:", 160, height/2 - 118);
    text("[1] + : Increments the value at the current cell by one", 160, height/2 - 104);
    text("[2] - : Decrements the value at the current cell by one", 160, height/2 - 90);
    text("[3] > : Moves the data pointer to the next cell (cell on the right)", 160, height/2 - 76);
    text("[4] < : Moves the data pointer to the previous cell (cell on the left)", 160, height/2 - 62);
    text("[5] . : Prints the ASCII value at the current cell (i.e. 65 = 'A')", 160, height/2 - 48);
    text("[6] , : Reads a single input character into the current cell", 160, height/2 - 34);
    text("[7] [ : If the value at the current cell is zero, skips to the corresponding ]", 160, height/2 - 20);
    text("        Otherwise, move to the next instruction", 160, height/2 - 4);
    text("[8] ] : If the value at the current cell is zero, move to the next instruction", 160, height/2 + 10);
    text("        Otherwise, move backwards in the instructions to the corresponding [", 160, height/2 + 24);
    text("[ and ] form a while loop. Obviously, they must be balanced.", 160, height/2 + 38);
    text("Shortcut keys:", 160, height/2 + 56);
    text("[F1]: Help (show/hide)", 160, height/2 + 70);
    text("[F2]: Open brainfuck program (text file)", 160, height/2 + 84);
    text("[F3]: Run program", 160, height/2 + 98);
    text("[F4]: Save screen image", 160, height/2 + 112);
    text("An optional input is asked before the program run.", 160, height/2 + 130);
    text("WARNING: The brainfuck file must be a VALID program.", 160, height/2 + 150);
    text("         No syntax errors check. No runtime errors check.", 160, height/2 + 164);
    textSize(14);    
    textAlign(LEFT);
    noStroke();
  }  
}  
//*********************************
void keyPressed()
{
  // help file [F1]
  if (keyCode==112)  { isHelping = !isHelping; isLoading = true;}
  // open file [F2]
  if (keyCode==113)  { showLoadDialog(); }
  // run program [F3]
  if (keyCode==114)
  {
    String input = JOptionPane.showInputDialog("Enter data...");
    if (input != null) // Not cancel
    {
      dataIn = input;
      dataOut = "";
      isRunning = true;      
    }
  }
  // save image [F4]
  if (keyCode==115)  { saveImage(); }  
}
//*********************************
void showLoadDialog()
{
  noLoop();
  selectInput("Select a valid brainfuck program...", "loadFile");
}
//*********************************
void loadFile(File selection)
{
  if (selection == null)
  {
    //println("No file selected.");
  }
  else
  {
    filename=selection.getAbsolutePath();
    lines = loadStrings(filename);
    program ="";
    for (int i = 0 ; i < lines.length; i++) 
    {
      program = program + lines[i];
    }
    dataIn = "";
    dataOut = "";
    isLoading = true;
  }
  loop();
}
//*********************************
void saveImage()
{
  save(newFilename() + ".png");
}
//*********************************
String newFilename()
{
  int y = year();
  int m = month();
  int d = day();
  int hh = hour();
  int mm = minute();
  int ss = second();
  String name = getClass().getSimpleName();
  String fname = name+"_"+y+"-"+nf(m, 2)+"-"+nf(d, 2)+"_"+nf(hh, 2)+"."+nf(mm, 2)+"."+nf(ss, 2);
  return fname;
}