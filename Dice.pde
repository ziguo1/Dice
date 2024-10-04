// --- BEGIN SHIM; REMOVE TO RUN ON DESKTOP ---
// (jump to line 58 for project code)

void circle(float x, float y, float extent) {
  ellipse(x, y, extent, extent);
}

void square(float x, float y, float extent) {
  rect(x, y, extent, extent)
}

void delay(int length) {
  long blockTill = Date.now() + length;
  while (Date.now() <= blockTill) {}
}

String __errBuff = "";
String __outBuff = "";

var System = {};
System.out = {};
System.err = {};

System.err.print = function (chars) {
  __errBuff += chars;
  String[] newlines = __errBuff.split("\n");
  if (newlines.length > 0) {
    String[] linesToPrint = newlines.slice(0, newlines.length - 1);
    linesToPrint.forEach(function (line) {
      console.error(line);
    })
    __errBuff = newlines[newlines.length - 1];
  }
};

System.err.println = function (chars) {
  System.err.print(chars + "\n");
};

System.out.print = function (chars) {
  __outBuff += chars;
  String[] newlines = __outBuff.split("\n");
  if (newlines.length > 0) {
    String[] linesToPrint = newlines.slice(0, newlines.length - 1);
    linesToPrint.forEach(function (line) {
      console.log(line);
    })
    __outBuff = newlines[newlines.length - 1];
  }
};

System.out.println = function (chars) {
  System.out.print(chars + "\n");
};
// --- END SHIM; REMOVE TO RUN ON DEKTOP ---


void setup()
{
  size(512, 512);
  textSize(16);
  textAlign(CENTER);
  frameRate(15);
  init();
}

ArrayList dices = new ArrayList();
float rollD = 0;
long pauseTill = 0;

void init()
{
  background(color(145, 219, 228));
  int padding = 6, numDice = 10, diceSize = Die.DIE_SIZE;
  int sidePadding = (512 - (numDice * (diceSize + padding))) / 2;
  
  for (int row = 0; row < numDice; row++) {
    for (int col = 0; col < numDice; col++) {
      dices.add(new Die((row * (diceSize + padding)) + sidePadding, (col * (diceSize + padding)) + sidePadding).roll());
    }
  } 
}

void redrawDice() {
  clear();
  for (Die die : dices) {
    die.roll();
  }
}

void update(boolean restore) {
  redrawDice();
  for (Die die : dices) {
    die.show();
  }
  
  if (!restore) background(color((int) (Math.random() * 128) + 64, (int) (Math.random() * 128) + 64, (int) (Math.random() * 128) + 64));
  else background(color(145, 219, 228));
}

void draw() {
  if (rollD != 0) {
    if (rollD < 1.1 && System.currentTimeMillis() >= pauseTill) {
      update(false);
      
      rollD *= 1.2;
      if (rollD > 1.1) {
        rollD = 0;
        pauseTill = 0;
        update(true);
      } else pauseTill = System.currentTimeMillis() + (long) (rollD * 1000); 
    }
  }
  
    int total = 0;
  for (Die die : dices) { total += die.sideShown; }
  String str = "Dice: " + dices.size() + "; sum: " + total;
  text(str, 512 / 2, 16);
  
  for (Die die : dices) {
    die.show();
  }
}


void mousePressed()
{
  if (rollD == 0) rollD = 0.1;
}

class Die //models one single dice cube
{
  //variable declarations here
  static final int DIE_SIZE = 40;
  int x, y;
  int sideShown;
  color centerColor;

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
    this.centerColor = color((int) (Math.random() * 192), (int) (Math.random() * 192), (int) (Math.random() * 192));
    return this;
  }
  Die show()
  {
    //your code here
    pushMatrix();
    translate(x, y);
    
    stroke(color(60, 34, 7));
    rect(0, 0, Die.DIE_SIZE, Die.DIE_SIZE, Die.DIE_SIZE / 6);
    
    fill(this.centerColor);
    final int CIRCLE_SIZE = 6;
    
    switch(this.sideShown) { // what da sigma
      default:
        throw new RuntimeException("?? bad code L");
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

    popMatrix();
    return this;
  }
}
