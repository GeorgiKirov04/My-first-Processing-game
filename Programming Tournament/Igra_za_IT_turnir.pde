
int Xbullet=100;
int Ybullet=100;

int Xheart;
int Yheart;
int Xheart1=150;
int Yheart1=0;
int Xheart2=300;
int Yheart2=0;
int Xzbar =600;
int Yzbar =600;
int Xzbar2 =600;
int Yzbar2 =600;
int Xzbar3 =600;
int Yzbar3 =600;

int screen = 0;
//Set up the window for the sketch

int dylyg=20;
int debel=5;

Bullet[] bullet;
final int bulletSize= 9;



float Xspeed = 5;

final int mravkaSize =25;
PImage[] mravka = new PImage[mravkaSize];

final int zombieSize =19;
PImage[] zombie = new PImage[zombieSize];

final int tetiSize= 25;
PImage[] teti = new PImage[tetiSize];

final int kotioSize = 19;
PImage[] kotio = new PImage[kotioSize];

PImage background1;
PImage heart;
PImage heart1;
PImage heart2;
PImage zbar;


boolean[] keys = {
  false, false , false,false
};


enum Direction{
  Left,Right
}

class Character{
  Direction direction;
  int xpoz = 100;
  int ypoz = 100;
  int posX   = 900;
  int posY   = 805;
  int life   = 255;
  int speed  = 3;
  
   public void move(){
    
    this.posX += (direction == Direction.Left ? -speed : speed );
  }
}

class Shooter extends Character{
  
  public Shooter( final int speed){
    this.speed = speed;
  }
  
  public void display(){
    
    if( !keyPressed ) {
      if( direction == Direction.Left )
        image( teti[frameCount%1], posX, posY, xpoz, ypoz);
      else
       image( mravka[frameCount%1], posX, posY, xpoz, ypoz );
    }
  
    if(keyPressed && key == 'a' || key == 'A'){
      image(teti[frameCount%tetiSize], posX, posY, xpoz, ypoz );
      this.direction = Direction.Left;
    }
  
    if(keyPressed && key == 'd' || key == 'D'){ 
      image(mravka[frameCount%mravkaSize], posX, posY, xpoz, ypoz );
      this.direction = Direction.Right;
    }
   
  }
  
  public void move(){
    
    
    if( !keyPressed )
      return;
    
     super.move();
    
    if(this.posX < -15)
      this.posX = -15;
    
    if(this.posX > 1804)
      this.posX = 1804;
  }
}

class Zombie extends Character{
   
  public Zombie( final int speed, final Direction direction ){
    this.speed = speed;
    this.xpoz = 150;
    this.ypoz = 100;
    this.direction = direction;
      
    if( this.direction == Direction.Left) {
      posX =1784;
      posY = 815;
    }
    else{
      posX =0;
      posY = 815;
    }
     
  }

  
  public void display(){
    
    if( direction == Direction.Left )
      image(kotio[frameCount%kotioSize], this.posX, this.posY, this.xpoz,this.ypoz );
    else
      image(zombie[frameCount%zombieSize], this.posX, this.posY, this.xpoz,this.ypoz );
      image(zbar,posX+45,posY);
    
  }
  
  
  public void move(){
    
     super.move();
     
     if( direction == Direction.Left && posX< -120 )
       posX = 1784;
       
    if( direction == Direction.Right && posX> 1824 )
      posX = -160;
  }
  
}

// Bullet - Simple class for bullets   
class Bullet {
  
  float x;
  float y;
  float speedX ;
  float speedY;
  float w;
  boolean bulletVisible = false ;
  Direction direction;
  //
  Bullet(float tempX, float tempY, // new2
  float tempSpeedX, float tempSpeedY,
  float tempW) {
    x = tempX;
    y = tempY;
    w = tempW;
    speedX = tempSpeedX;
    speedY = tempSpeedY;
  }
  
  void move() {
    // Add speed to location
    x = x + (direction == Direction.Left ? -speedX : speedX );
    y = y + (direction == Direction.Left ? -speedY : speedY );
    // kill bullet when outside screen
    if (x<4 || y<4 || x>width-4 || y>width-4)
      bulletVisible = false ;
  } // method
  //
  void display() {
    // Display the rect
    fill(255);
    noStroke();
    fill(0);
    rect(x , shooter.posY + 55, dylyg,debel);
  }
} // class


Shooter shooter;
Zombie [] zombies;
int numberZombies =2;


void setup(){

  size(1784,976);
  frameRate(49);
   
  bullet = new Bullet[bulletSize];
  
  for (int i=0; i<bulletSize; i++) {    
    bullet[i]= new Bullet(Xbullet, Ybullet, 8, -4, 3); //Display the bullets at the position where the character was when shooting
  }
 
 
  background1=loadImage("background1.jpg");
  heart2=loadImage("heart2.png");
  heart1=loadImage("heart1.png");
  heart=loadImage("heart.png");
  zbar=loadImage("zbar.png");
  mravka[0]=loadImage("mravka1.png");
  
  
  for (int i=1; i<mravkaSize; i++) {
    mravka[i]=loadImage("mravka"+(i+1)+".gif");
  }
  
  teti[0]=loadImage("teti1.png");
  for (int i=1; i<tetiSize; i++) {
    teti[i]=loadImage("teti"+(i+1)+".gif");
  }
                      
  for (int i=0; i<kotioSize; i++) {
    kotio[i]=loadImage("kotio"+(i+1)+".gif");
  } 
  
  for (int i=0; i<zombieSize; i++) {
    zombie[i]=loadImage("zombie"+(i+1)+".gif");
  } 
  
  shooter = new Shooter( 6 );
  
  zombies = new Zombie[numberZombies];
  for( int i=0; i<numberZombies; i++)
    zombies[i] = new Zombie( 3, (i%2 == 1) ? Direction.Right: Direction.Left ); 
  
}


void draw(){
  
  background(background1);

  if(screen == 0) {
    //take action to do whatever you want to do on screen 0
    
    
    text("START THE GAME!!!", 200, 500);
  }
  if(screen == 1) {
    text("your on level 1", 20, 50);
  }
  if(screen == 2) {
    text("Ooh man onto level 2", 20, 50);
  }
  if(screen == 3) {
    text("YOU HAVE WON!!! Gratz", 20, 50);
  }
image(heart,Xheart,Yheart);
image(heart1,Xheart1,Yheart1);
image(heart2,Xheart2,Yheart2);


   for (int i=0; i<9; i++) {
     if (bullet[i].bulletVisible==true) {
          bullet[i].display();
          bullet[i].move();
     }
  }
  
  
  //image(kotio[frameCount%19],xposzombie2,yposzombie2,Xzombie2,Yzombie2);
  //image(zombie[frameCount%19],xposzombie,yposzombie,Xzombie,Yzombie);
  for( int i=0; i<numberZombies; i++){
     zombies[i].display();
     zombies[i].move();
  }

  fill(0);
  //xposzombie=xposzombie+3;
  //xposzombie2=xposzombie2-3;
  
  //
  for (int i=0; i<2; i++) {
    if (bullet[i].bulletVisible==true) {
      bullet[i].display();
      bullet[i].move();
    }
  }
  
  shooter.display();
  shooter.move();
  /*
  if(!keyPressed) {
    image(mravka[frameCount%1],xpos,ypos,xMravka,yMravka);
  }
  if(keyPressed && key == 'a' || key == 'A'){
    image(teti[frameCount%25],xpos,ypos,xMravka,yMravka);
    xpos-=6;
  }
  if(keyPressed && key == 'd' || key == 'D'){ 
    image(mravka[frameCount%25],xpos,ypos,xMravka,yMravka);
    xpos+=6;
  }
  if(xpos < -15){
    xpos = -15;
  }
  if(xpos > 1840){
    xpos = 1840;
  }
  */

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// IF bulet hits a zombie, zombie should go to start position and points should incremented
// IF zombie reaches shooter, live of shooter shoult decrement, zombie goes to start position

// IF life of shooter ends, game is over - display points
// IF points of shooter reach level one limit, shooter goes to level 2, speed of bulets, zombies and number of zombies increases, and so on
// IF points reach level 3 limit, shooter win the game.
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!

}//end draw



 void keyPressed(){

  if(key == 'a' || key == 'A') keys[2] = true;
  if(key == 'd' || key == 'D') keys[3] = true;
  
}
 
void keyReleased(){
 
  if(key == 'a' || key == 'A') keys[2] = false;
  if(key == 'd' || key == 'D') keys[3] = false;

}

void mousePressed() {
  //Set the screen when whatever happens that you want to happen
  
  //!Screen must be changed when number of zombies are killed
  //screen = min(screen + 1, 3);
  //!Screen must be changed when number of zombies are killed
  
      if (mousePressed==true) {
        // search empty slot
        for (int i=0; i<2; i++) {
          if (!bullet[i].bulletVisible) {
            // start new bullet 
            bullet[i].bulletVisible  = true;
            bullet[i].x              = shooter.posX+50;
            bullet[i].y              = shooter.posY;
            bullet[i].direction      = shooter.direction;
            
            if( shooter.direction == Direction.Right )
              bullet[i].x += 50;
              
            break;
            // return;
          } // if
        } // for
      } // if
    } // func
    //
    // ===============================================================
    
