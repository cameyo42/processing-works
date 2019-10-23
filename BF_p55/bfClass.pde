public class Brainfuck
{
    //private Scanner sc = new Scanner(System.in);
    private final int LENGTH = 65535;
    private byte[] mem = new byte[LENGTH];
    private int dataPointer;
    private int numChar;
    private int numRow;
    
    public void reset()
    {
      for(int i = 0; i < LENGTH; i++)
      {
        mem[i] = 0;
      }
      dataPointer = 0;
      numChar = 0;
      numRow = 0;
    }  

    public void interpret(String code, String input) 
    {
        int l = 0;
        int idx = 0;
        for(int i = 0; i < code.length(); i++) 
        {
            if(code.charAt(i) == '>') 
            {
                dataPointer = (dataPointer == LENGTH-1) ? 0 : dataPointer + 1;
            } 
            else if(code.charAt(i) == '<') 
            {
                dataPointer = (dataPointer == 0) ? LENGTH-1 : dataPointer - 1;
            } 
            else if(code.charAt(i) == '+') 
            {
                mem[dataPointer]++;
            } 
            else if(code.charAt(i) == '-') 
            {
                mem[dataPointer]--;
            } 
            else if(code.charAt(i) == '.') 
            {
                //System.out.print((char) mem[dataPointer]);
                print((char) mem[dataPointer]);
                fill(#fdf6e3);
                text((char) mem[dataPointer], 20 + (8*numChar), height - 66 + (10*numRow));
                dataOut = dataOut + (char) mem[dataPointer];  
                numChar++;
                if (numChar > 94)
                {  
                  numChar = 0;
                  numRow++;
                  println("");
                }  
            } 
            else if(code.charAt(i) == ',') 
            {
                //mem[dataPointer] = (byte) sc.next().charAt(0);              
                if (idx < input.length())
                {
                  mem[dataPointer] = (byte) input.charAt(idx);
                  idx ++;
                }  
            } 
            else if(code.charAt(i) == '[') 
            {
                if(mem[dataPointer] == 0) 
                {
                    i++;
                    while(l > 0 || code.charAt(i) != ']') 
                    {
                        if(code.charAt(i) == '[') l++;
                        if(code.charAt(i) == ']') l--;
                        i++;
                    }
                }
            } 
            else if(code.charAt(i) == ']') 
            {
                if(mem[dataPointer] != 0) 
                {
                    i--;
                    while(l > 0 || code.charAt(i) != '[') 
                    {
                        if(code.charAt(i) == ']') l++;
                        if(code.charAt(i) == '[') l--;
                        i--;
                    }
                    i--;
                }
            }
        }
    }
}