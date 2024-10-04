void setup()
{
  size(512, 512);
  noLoop();
}
void draw()
{
  background(color(#91dbe4));
  int padding = 6, numDice = 10, diceSize = Die.DIE_SIZE;
  int sidePadding = (512 - (numDice * (diceSize + padding))) / 2;
  for (int row = 0; row < numDice; row++) {
    for (int col = 0; col < numDice; col++) {
      new Die((row * (diceSize + padding)) + sidePadding, (col * (diceSize + padding)) + sidePadding)
        .roll()
        .show();
    }
  }
}
void mousePressed()
{
  redraw();
}

class Die //models one single dice cube
{
  //variable declarations here
  static final int DIE_SIZE = 40;
  int x, y;
  int sideShown;

  Die(int x, int y) //constructor
  {
    //variable initializations here
    this.x = x;
    this.y = y;
    this.sideShown = 1;
  }
  Die roll()
  {
    //your code here
    this.sideShown = (int) (Math.random() * 6) + 1;
    return this;
  }
  Die show()
  {
    //your code here
    push();
    translate(x, y);
    
    stroke(color(#3c2207));
    square(0, 0, Die.DIE_SIZE);
    
    fill(color(0, 0, 0));
    final int CIRCLE_SIZE = 6;
    
    switch(this.sideShown) {
      default:
        throw new RuntimeException("??");
       case 1:
        circle(Die.DIE_SIZE / 2, Die.DIE_SIZE / 2, CIRCLE_SIZE);
        break;
       case 2:
        circle(Die.DIE_SIZE / 8 * 2, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 6, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        break;
       case 3:
        circle(Die.DIE_SIZE / 8 * 2, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 2, Die.DIE_SIZE / 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 6, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        break;
       case 4:
        circle(Die.DIE_SIZE / 8 * 2, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 6, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 6, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 2, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        break;
       case 5:
        circle(Die.DIE_SIZE / 2, Die.DIE_SIZE / 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 2, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 6, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 6, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 2, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        break;
       case 6:
        circle(Die.DIE_SIZE / 8 * 2, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 4, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 6, Die.DIE_SIZE / 8 * 2, CIRCLE_SIZE);
        
        circle(Die.DIE_SIZE / 8 * 2, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 4, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        circle(Die.DIE_SIZE / 8 * 6, Die.DIE_SIZE / 8 * 6, CIRCLE_SIZE);
        break;
    }

    pop();
    return this;
  }
}
