// photoGIF.pde
// create a movie from photo
// processing 3.x

float CELL_SIZE = 10.0;
boolean DEBUG = false;
PImage img;
ParticleSystem particles;
boolean RECORD = true;

void setup() 
{
  size(500, 500);  
  img = loadImage("data.jpg");
  particles = new ParticleSystem(this, img);
}

void draw() 
{
  background(255);
  particles.add(this.width * 0.5 + random(-2.0, 2.0), 
                this.height * 0.5 + random(-2.0, 2.0));
  particles.add(this.width * 0.5 + random(-1.0, 1.0), 
                this.height * 0.5 + random(-1.0, 1.0));                
  particles.plan();  
  particles.move();
  particles.draw();
  if (RECORD) {
    if (frameCount % 8 == 0) {
      int n_frames = frameCount / 8;
      if (n_frames > 180) {
        return;
      }
      String fname = nf((n_frames), 3) + ".png";
      println(fname);
      save(fname);
    }
  }
}