/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/11147*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
// This Sketch was produced by Lee Dawson for the animation and multimedia  coursework.
// The Sketch uses music, picture in picture animation (of the stickman), Gravity effects (on the particles), and sound effects
// I also used creativity and a random element to make the sketch more entertaining.
// PVectors and ArrayLists are used a lot in this code, PVectors for locations and accelerations on the particles. And Arraylists for the bullets and the particles
// Using Arraylists allows for a very large number of bullets, and particles especially, to be stored.


// Sections of code are borrowed from the battle tank sketch by Giovanni Carlo Mingati. Specifically the Particle explosions. Though I have changed large sections of this code to fit my purpose 
// http://www.openprocessing.org/visuals/?visualID=968

// The original inspiration for this animation was the particle effects used in battle tank, but I have changed this significantly.

/* @pjs preload="processing/fan2013.jpg"; */

PImage img4;
int numParticles = 1000; //number of particles in explosion
int fr = 24;  //framerate
boolean bang = false;
ArrayList bullet = new ArrayList();  
ArrayList particles = new ArrayList(); 
float speedy;
float originx, originy;
float explRad = 2.6f; //exlposion radius
float theta = 0.0f;
float xoff = 0.0;
PVector origin;
PVector grav = new PVector (0.0, 0.02); //sets x gravity for use later, uses a vector as it is acting on a vector
int[] pix;

void setup() {
  frameRate(fr);
  size(640, 443);
  img4 = loadImage("processing/fan2013.jpg");
  speedy = 300/fr;  
  background(0);
  img4.loadPixels();
  pix = img4.pixels;
}

void draw() {
  //draw 2 rectangles, one partially transparent at the top, and one solid at the bottom
  noStroke();
  fill(0,20);
  rect(0,0,width,height);

  for (int i = bullet.size()-1;i>=0; i--) 
  {
    Bullet blt = (Bullet) bullet.get(i);
    blt.update();

    if (blt.boomtime()) {
      bang = true;
      originx = blt.xpos;
      originy = blt.ypos;
      origin = new PVector(blt.xpos, blt.ypos);
      bullet.remove(i);

      for (int z = 0; z < numParticles; z++) {  
        // circle-like initial position of explosion's Particles  
        float x = explRad * cos(theta);  
        float y = explRad * sin(theta);  
        x = noise(xoff) * x;  
        y = noise(xoff) * y;  
        x += originx; 
        y += originy;                             
        xoff = xoff + 0.5f;  
        theta += 0.1f;                             
        PVector a = new PVector();  
        PVector l = new PVector(x, y, 0);  
        PVector v = PVector.sub(l, origin);                            
        particles.add(new Particle(a, v, l, pix));
      }
    }
  }
  if (bang) { 


    explode();
  }
}

void explode() {  

  for (int i = particles.size()-1; i >= 0; i--) {  

    Particle prt = (Particle) particles.get(i);     

    prt.add_force(grav);  // applies gravity to the particles.

    prt.run(); 

    if (prt.dead()) {  

      particles.remove(i);
    }  //this removes particles from the arraylist when the timer expires, this is important as the number of particles slows down the framerate extensively.
  }
}

void mousePressed() 
{
  if (mouseButton==LEFT)
  { 
    int x = mouseX; //x position of mouse
    int y = (mouseY-(mouseY)+443); //y position at top of image
    int z = mouseY; //current y position of mouse
    bullet.add(new Bullet(x, y, z, pix));
  }
} 

void stop() {
  super.stop();
}

