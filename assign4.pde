final int GAME_START = 0, GAME_RUN = 1, GAME_OVER =2;

PImage bg1,bg2,enemy,fighter,hp,treasure,start2,start1,end1,end2;
int bgX,treasureX,treasureY;
int blood;
int gameState;
int enemyState;
final int TOTAL_LIFE = 100;
int life;

float fighterX,fighterY;
float speedX = 4;
float speedY = 4;
float [] xenemy1 = new float [5];
float [] yenemy1 = new float [5];
float [] xenemy2 = new float [5];
float [] yenemy2 = new float [5];
float [] xenemy3 = new float [8]; 
float [] yenemy3 = new float [8];
float enemySpeed = 2;
float enemyFollow1, enemyFollow2, enemyFollow3;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean isPlaying = false;

PImage[] flame= new PImage [5];
int timer = 0;
int flamenum=0;
float flameX = 700;
float flameY = 700;

void setup () {
  size(640,480) ; 

  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start2 = loadImage("img/start2.png");
  start1 = loadImage("img/start1.png");
  end2 = loadImage("img/end2.png");
  end1 = loadImage("img/end1.png");
  
  bgX = 0;
  fighterX = 580;
  fighterY = 240;
  treasureX = floor(random(20,590));
  treasureY = floor(random(40,440));
  blood = 40;
  life = 20;
  gameState = GAME_START;
  
  for(int i=0; i<5; i++){
    xenemy1[i] = 0-i*enemy.width;
    xenemy2[i] = (0-640-enemy.width*5)-i*enemy.width;
  }

  for(int i=0; i<8; i++){
     if (0<=i && i<=4){
      xenemy3[i] = (0-640-enemy.width*5)*2-i*enemy.width;
    }else if(5<=i && i<=7){
      xenemy3[i] = (0-640-enemy.width*5)*2-(i-4)*enemy.width;
    }
  }
  
  enemyFollow1 = xenemy1[4];
  enemyFollow2 = xenemy2[4];
  enemyFollow3 = xenemy3[4];
 
    yenemy1[0] = random(40,420);
    yenemy2[0] = random(175);
    yenemy3[0] = random(125,290); 
  //Y, first & second
  for(int i=1; i<5; i++){
    yenemy1[i] = yenemy1[i-1];
    yenemy2[i] = yenemy2[i-1]+enemy.height;
  }
  //Y, third
  yenemy3[1]= yenemy3[0]-enemy.width*1;
  yenemy3[2]= yenemy3[0]-enemy.width*2;
  yenemy3[3]= yenemy3[0]-enemy.width*1;
  yenemy3[4]= yenemy3[0];
  yenemy3[5]= yenemy3[0]+enemy.width*1;
  yenemy3[6]= yenemy3[0]+enemy.width*2;
  yenemy3[7]= yenemy3[0]+enemy.width*1;
  
  for(int j=0; j<5; j++){
    flame[j]= loadImage("img/flame"+(j+1)+".png");
  }
}

void draw() {
  // your code
  background(0);
  
  switch (gameState){
    case GAME_START:
    image(start2,0,0);
    if(mouseX > 205 && mouseX <455 && mouseY >380 && mouseY < 410){
      image(start1,0,0);
      if(mousePressed){
        gameState = GAME_RUN;
      }
    }
    break;
    
    case GAME_RUN:
    image(bg1,bgX,0);
    image(bg2,bgX-bg1.width,0);
    image(bg1,bgX-bg1.width-bg2.width,0);
    bgX++;
    bgX%=(bg1.width+bg2.width);
    
    fill(255,0,0);
    rect(30,24,blood,20);
    blood = 2*life;
    image(hp,20,20);
    
    image(treasure,treasureX,treasureY);
    
    image(fighter,fighterX,fighterY);
    
    if (upPressed) {
        fighterY -= speedY;
      }
      if (downPressed) {
        fighterY += speedY;
      }
      if (leftPressed) {
        fighterX -= speedX;
      }
      if (rightPressed) {
        fighterX += speedX;
      }
      
      if(fighterX > 590){
        fighterX = 590;
      }
      if(fighterX < 0){
        fighterX = 0;
      }
      if(fighterY > 430){
        fighterY = 430;
      }
      if(fighterY < 0){
        fighterY = 0;
      }
    
    
    enemyFollow1 += enemySpeed; 
     if(enemyFollow1>=640){
        yenemy1[0] = random(40,420);
        for(int i=1;i<5;i++){
        yenemy1[i]=yenemy1[i-1];
        }
       } 

     //first
     for(int i=0; i<5; i++){
       image(enemy, xenemy1[i], yenemy1[i]);
       xenemy1[i] += enemySpeed;   
       if(xenemy1[i]>=640){
          xenemy1[i]=0-640*2-enemy.width*5*3; 
       }   
       if(enemyFollow1 >=640){
         enemyFollow1 = 0-640*2-enemy.width*5*3;
       }
     } 
         
      //second
     enemyFollow2 += enemySpeed;  
     if(enemyFollow2>=640){
        yenemy2[0] = random(175);
        for(int i=1;i<5;i++){
        yenemy2[i]=yenemy2[i-1]+enemy.width;
        }
       }   
          
     for(int i=0; i<5; i++){
       image(enemy, xenemy2[i], yenemy2[i]);     
       xenemy2[i] += enemySpeed; 
       if(xenemy2[i]>=640){
         xenemy2[i]=0-640*2-enemy.width*5*3;
       }
       if( enemyFollow2 >= 640){
        enemyFollow2 = 0-640*2-enemy.width*5*3;
       }
     }

     
     //third
     enemyFollow3 += enemySpeed;
     if(enemyFollow3>=640){
       yenemy3[0] = random(125, 295);
       yenemy3[1]= yenemy3[0]-enemy.width*1;
       yenemy3[2]= yenemy3[0]-enemy.width*2;
       yenemy3[3]= yenemy3[0]-enemy.width*1;
       yenemy3[4]= yenemy3[0];
       yenemy3[5]= yenemy3[0]+enemy.width*1;
       yenemy3[6]= yenemy3[0]+enemy.width*2;
       yenemy3[7]= yenemy3[0]+enemy.width*1; 
     } 
              
     for(int i=0; i<8; i++){
       image(enemy, xenemy3[i], yenemy3[i]);
       xenemy3[i] += enemySpeed;
       if(xenemy3[i]>=640){   
         xenemy3[i] = 0-640*2-enemy.width*5*3;
       }
       if(enemyFollow3 >= 640){
         enemyFollow3 = 0-640*2-enemy.width*5*3;
       }
     }  
      
   //enemy detection
   //first
   for(int i=0; i<5 ; i++){ 
         if ( fighterX >= xenemy1[i]-enemy.width && fighterX <= xenemy1[i]+enemy.width){
           if(fighterY >= yenemy1[i]-enemy.height &&  fighterY <= yenemy1[i]+enemy.height){
              life -= 20; 
              flameX = xenemy1[i];
              flameY = yenemy1[i];
              flamenum = 0; 
              xenemy1[i] = (0-640*2-enemy.width*5*3) - (640-xenemy1[i]);
           }
         }
         image(flame[flamenum],flameX,flameY);
         timer++;
         if(timer>10){
           flamenum++;
           timer = 0;
         }
         if(flamenum>=flame.length){
           flameX=700;
           flameY=700;
           flamenum=0;
         }
         
         //Second
         if ( fighterX >= xenemy2[i]-enemy.width && fighterX <= xenemy2[i]+enemy.width){
           if(fighterY >= yenemy2[i]-enemy.height &&  fighterY <= yenemy2[i]+enemy.height){
              life -= 20;
              flameX = xenemy2[i];
              flameY = yenemy2[i];
              flamenum = 0; 
              xenemy2[i] = (0-640*2-enemy.width*5*3) - (640-xenemy2[i]);
         }
       }
   }
         image(flame[flamenum],flameX,flameY);
         timer++;
         if(timer>10){
           flamenum++;
           timer = 0;
         }
         if(flamenum>=flame.length){
           flameX=700;
           flameY=700;
           flamenum=0;
         }
       
       //Third
       for(int i=0; i<8 ; i++){
         if ( fighterX >= xenemy3[i]-enemy.width && fighterX <= xenemy3[i]+enemy.width){
           if(fighterY >= yenemy3[i]-enemy.height &&  fighterY <= yenemy3[i]+enemy.height){
              life -= 20;
              flameX = xenemy3[i];
              flameY = yenemy3[i];
              flamenum = 0; 
              xenemy3[i] = (0-640*2-enemy.width*5*3) - (640-xenemy3[i]);
           }
         }
       }
         image(flame[flamenum],flameX,flameY);
         timer++;
         if(timer>10){
           flamenum++;
           timer = 0;
         }
         if(flamenum>=flame.length){
           flameX=700;
           flameY=700;
           flamenum=0;
         }
      
      
      
      //score detection
    if(fighterX >= treasureX-treasure.width && fighterX <= treasureX+treasure.width){
      if(fighterY >= treasureY-treasure.height && fighterY <= treasureY+treasure.height ){
        life += 10;
        treasureX = floor(random(20,590));
        treasureY = floor(random(40,440));
        if(life >= 100){
          life = 100;
        }
      }
    }
    
    if(life <= 0){
     gameState = GAME_OVER;
     for(int i=0; i<5; i++){
    xenemy1[i] = 0-i*enemy.width;
    xenemy2[i] = (0-640-enemy.width*5)-i*enemy.width;
  }

  for(int i=0; i<8; i++){
     if (0<=i && i<=4){
      xenemy3[i] = (0-640-enemy.width*5)*2-i*enemy.width;
    }else if(5<=i && i<=7){
      xenemy3[i] = (0-640-enemy.width*5)*2-(i-4)*enemy.width;
    }
  }
  
  enemyFollow1 = xenemy1[4];
  enemyFollow2 = xenemy2[4];
  enemyFollow3 = xenemy3[4];
 
    yenemy1[0] = random(40,420);
    yenemy2[0] = random(175);
    yenemy3[0] = random(125,290); 
  //Y, first & second
  for(int i=1; i<5; i++){
    yenemy1[i] = yenemy1[i-1];
    yenemy2[i] = yenemy2[i-1]+enemy.height;
  }
  //Y, third
  yenemy3[1]= yenemy3[0]-enemy.width*1;
  yenemy3[2]= yenemy3[0]-enemy.width*2;
  yenemy3[3]= yenemy3[0]-enemy.width*1;
  yenemy3[4]= yenemy3[0];
  yenemy3[5]= yenemy3[0]+enemy.width*1;
  yenemy3[6]= yenemy3[0]+enemy.width*2;
  yenemy3[7]= yenemy3[0]+enemy.width*1;
    }
    break;
    
     case GAME_OVER:
    image(end2,0,0);
    if(mouseX > 200 && mouseX <440 && mouseY >300 && mouseY < 360){
      if(mousePressed){
        gameState = GAME_RUN;
        life = 20;
        fighterX = 580;
        fighterY = 240;
        flameX=700;
        flameY=700;
      }else{
        image(end1,0,0);
      }
    break;
    }
  }
}

void keyPressed(){
  if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}


void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
