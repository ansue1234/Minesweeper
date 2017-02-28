

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final int NUM_ROWS=20;
private final int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private int numBomb = 100;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
     buttons= new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS; r++){
        for(int c = 0; c<NUM_COLS; c++){
            buttons[r][c]= new MSButton(r,c); 
        }
    }   
    setBombs();
}
public void setBombs()
{
    //your code
    bombs = new ArrayList <MSButton>(); 
    int f = (int)(Math.random()*100);
    for(int n = 0; n<f; n++){
       int i = (int)(Math.random()*NUM_ROWS);
       int j = (int)(Math.random()*NUM_COLS);
       if (!bombs.contains(buttons[i][j])) {
          bombs.add(buttons[i][j]);
          //System.out.println(bombs.size());
       } 
   }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed==true){
            marked=!marked;
        }
        if(marked==false){
            clicked = false;
        }else if(bombs.contains(this)){
            displayLosingMessage();
        }else if(countBombs(r,c)>0){
            setLabel(""+countBombs(r,c));
        }
          if(isValid(r,c-1) && buttons[r][c-1].clicked==false)
            buttons[r][c-1].mousePressed();
          if(isValid(r,c+1) && buttons[r][c+1].clicked==false)
            buttons[r][c+1].mousePressed();
          if(isValid(r-1,c) && buttons[r-1][c].clicked==false)
            buttons[r-1][c].mousePressed();
          if(isValid(r+1,c) && buttons[r+1][c].clicked==false)
            buttons[r+1][c].mousePressed();
          //3 more recursive calls
        
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r>=0&&r<19&&c>=0&&c<19&&!bombs.contains(this)){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(buttons[row-1][col].isValid(row-1,col)&&bombs.contains(buttons[row-1][col])){
            numBombs++;
        }
        if(buttons[row+1][col].isValid(row+1,col)&&bombs.contains(buttons[row+1][col])){
            numBombs++;
        }
        if(buttons[row][col+1].isValid(row,col+1)&&bombs.contains(buttons[row][col+1])){
            numBombs++;
        }
        if(buttons[row][col-1].isValid(row,col-1)&&bombs.contains(buttons[row][col-1])){
            numBombs++;
        }
        if(buttons[row-1][col-1].isValid(row-1,col-1)&&bombs.contains(buttons[row-1][col-1])){
            numBombs++;
        }
        if(buttons[row+1][col+1].isValid(row+1,col+1)&&bombs.contains(buttons[row+1][col+1])){
            numBombs++;
        }
        if(buttons[row+1][col-1].isValid(row+1,col-1)&&bombs.contains(buttons[row+1][col-1])){
            numBombs++;
        }
        if(buttons[row-1][col+1].isValid(row-1,col+1)&&bombs.contains(buttons[row-1][col+1])){
            numBombs++;
        }
        System.out.println(numBombs);
        return numBombs;
    }
}



