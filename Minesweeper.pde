

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final int NUM_ROWS=20;
private final int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private int numBomb = 100;
private boolean over = false;
private boolean win = false;
private boolean lose = false;


void setup ()
{
    size(400, 600);
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
    int f = (int)((Math.random()*100)+50);
    for(int n = 0; n<f; n++){
       int i = (int)(Math.random()*NUM_ROWS);
       int j = (int)(Math.random()*NUM_COLS);
       if (!bombs.contains(buttons[i][j])) {
        
          bombs.add(buttons[i][j]);
          
       } 
   }

}

public void draw ()
{
    background( 0 );
    textSize(20);
    fill(255);
    text("Num of Bombs:"+bombs.size(), 200,550);
    textSize(10);
    if(isWon())
        displayWinningMessage();

    if(over&&win){
        textSize(20);
        text("You Win",200,500);
        textSize(10);
    }else if(over&&lose){
        textSize(20);
        text("You lose",200,500);
        textSize(10);
    }
}
public boolean isWon()
{
    //your code here
    for (int r = 0; r < NUM_ROWS; r ++) {
        for (int c = 0; c < NUM_COLS; c ++) {
            if (!bombs.contains(buttons[r][c]) && !buttons[r][c].isClicked()) {
                return false;
               
            }
        }
     }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    over = true;
    lose = true;
    fill(255);
    textSize(20);
    text("You Lose",200,500);
    textSize(10);
    //noLoop();

}
public void displayWinningMessage()
{
    //your code here
    over = true;
    win = true;
    fill(255);
    textSize(20);
    text("You Win",200,500);
    textSize(10);
    //noLoop();
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
        if(over==false){
        clicked = true;
        //your code here
        if(keyPressed==true||(mousePressed&&(mouseButton==RIGHT))){
            marked=!marked;
            if(marked==false)
            clicked = false;
        }else if(bombs.contains(this)){
            for(int i = 0; i<bombs.size(); i++){
                bombs.get(i).clicked = true;
            }
            displayLosingMessage();
            //noLoop();
        }else if(countBombs(r,c)>0){
            setLabel(""+countBombs(r,c));
        }else{
            if(isValid(r,c-1) && buttons[r][c-1].clicked==false)
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && buttons[r][c+1].clicked==false)
                buttons[r][c+1].mousePressed();
            if(isValid(r-1,c) && buttons[r-1][c].clicked==false)
                buttons[r-1][c].mousePressed();
            if(isValid(r+1,c) && buttons[r+1][c].clicked==false)
                buttons[r+1][c].mousePressed();
            if(isValid(r+1,c+1) && buttons[r+1][c+1].clicked==false)
                buttons[r+1][c+1].mousePressed();
            if(isValid(r+1,c-1) && buttons[r+1][c-1].clicked==false)
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c+1) && buttons[r-1][c+1].clicked==false)
                buttons[r-1][c+1].mousePressed();
            if(isValid(r-1,c-1) && buttons[r-1][c-1].clicked==false)
                buttons[r-1][c-1].mousePressed();
          //3 more recursive calls
        }
    }
        
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
        if(r>=0&&r<=19&&c>=0&&c<=19){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row-1,col)&&bombs.contains(buttons[row-1][col])){
            numBombs++;
        }
        if(isValid(row+1,col)&&bombs.contains(buttons[row+1][col])){
            numBombs++;
        }
        if(isValid(row,col+1)&&bombs.contains(buttons[row][col+1])){
            numBombs++;
        }
        if(isValid(row,col-1)&&bombs.contains(buttons[row][col-1])){
            numBombs++;
        }
        if(isValid(row-1,col-1)&&bombs.contains(buttons[row-1][col-1])){
            numBombs++;
        }
        if(isValid(row+1,col+1)&&bombs.contains(buttons[row+1][col+1])){
            numBombs++;
        }
        if(isValid(row+1,col-1)&&bombs.contains(buttons[row+1][col-1])){
            numBombs++;
        }
        if(isValid(row-1,col+1)&&bombs.contains(buttons[row-1][col+1])){
            numBombs++;
        }
        
        return numBombs;
    }
}



