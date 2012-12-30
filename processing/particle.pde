//particle class, makes extensive use of PVectors to set positions and accelerations of individual particles. Also applies gravity to the particles.

//much of this code is referenced from the battle tank sketch by Giovanni Carlo Mingati. Specifically the Particle explosions. Though I have changed large sections of this code to fit my purpose 
// http://www.openprocessing.org/visuals/?visualID=968

class Particle {  
  PVector loc;  
  PVector vel;  
  PVector acc;  
  float timer;  
  int[] pix;

  Particle(PVector a, PVector v, PVector l, int[] pix_) {  
    acc = a;  
    vel = v;  
    loc = l;   
    pix = pix_; 
    
    timer = 50.0;
  }  

  void run() {  
    update();  
    render();
  }  

  void update() {  
    vel.add(acc);  
    loc.add(vel);  
    acc = new PVector();  
    timer -= 0.5f;   //increments timer down
  }  

  void render() {   

    //sets the colour of the firework blast, for individual particles. Roughly one quarter of particles will be set to Gold.    

    int p = constrain(int(loc.x), 0, 639) + constrain(int(loc.y), 0, 442)*640;
    color c = pix[p];
    stroke(c);
    point(loc.x, loc.y);
  }  


  void add_force(PVector force) {   
    acc.add(force);
  }    
  //removes particles after a number of frames.

  boolean dead() {  
    if (timer <= 0.0) {  
      return true;
    } 
    else {  
      return false;
    }
  }
}

