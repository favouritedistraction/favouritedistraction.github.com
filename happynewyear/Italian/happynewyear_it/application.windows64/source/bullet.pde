// This class draws the bullets from the stickman gun, and sets the height that each bullet will explode

class Bullet
{

float xpos; 
float ypos; 
float exypos;
int[] pix;

Bullet(float xpos, float ypos, float exypos, int[] pix)

{
  this.xpos = xpos;
  this.ypos = ypos;
  this.exypos = exypos;
  this.pix = pix;
}

void update()

{ ypos = ypos - speedy;
  
  drawagain();
}

boolean boomtime() {
  if (ypos <=exypos) {
  return true;
  }
  else return false;
}

void drawagain()

{ 
  int p = constrain(int(xpos),0,639) + constrain(int(ypos),0,442)*639;
  color c = pix[p];
  stroke(c);
  fill(c);
  ellipse(xpos,ypos,5,5); 
}
}
