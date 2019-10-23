// fluid.pde
// fluid simulation
// based on "Fluid Simulation", created by Felix Woitzel
// modified by cameyo 2015
// processing 3.x
 
NavierStokesSolver fluidSolver;
float visc, diff, vScale, velocityScale;
float  limitVelocity;
int oldMouseX = 1, oldMouseY = 1;
int numParticles;
Particle[] particles;
//Random rnd = new Random();
 
boolean vectors = false;
 
void setup() {
 
  size(800, 800);
  frameRate(160);
 
  fluidSolver = new NavierStokesSolver();
 
  numParticles = (int)pow(2, 18);
  particles = new Particle[numParticles];
  visc = 0.00025f;
  diff = 0.03f;
  vScale = 10;
  velocityScale = vScale;
  vectors = true;
 
  limitVelocity = 200;
 
  stroke(color(0));
  fill(color(0));
 
  initParticles();
} 
 
 
private void initParticles() {
  for (int i = 0; i < numParticles - 1; i++) {
    particles[i] = new Particle();
    particles[i].x = random(width);
    particles[i].y = random(height);
    if (particles[i].x > (width >> 1)) 
       particles[i].c = c1;
    else
       particles[i].c = c2;

  }
}
 
public void draw() {
 
  handleMouseMotion();
 
  //background(224);
  background(40);
 
  float dt = 1 / frameRate;
  fluidSolver.tick(dt, visc, diff);
 
  if (vectors)
    drawMotionVectorsImmediate( vScale * 4);
 
  vScale = velocityScale * 60. / frameRate;
  drawParticlesPixels();
 
  fill(225);
  textSize(20);
  
  text("fps: " + nf(frameRate, 2, 1), 10, 20);
}
 
  int c1 = color(0,96,192); // particle pixel color
  int c2 = color(192,96,0); // particle pixel color
 
 
private void drawParticlesPixels() {
 
  int n = NavierStokesSolver.N;
  float cellHeight = height / n;
  float cellWidth = width / n;
 
 
  for (int i = 0; i < numParticles - 1; i++) {
      Particle p =  particles[i];
    if (p != null) {
 
      int cellX = floor(p.x / cellWidth);
      int cellY = floor(p.y / cellHeight);
      float dx =  fluidSolver.getDx(cellX, cellY);
      float dy =  fluidSolver.getDy(cellX, cellY);
 
      float lX = p.x - cellX * cellWidth - cellWidth / 2;
      float lY = p.y - cellY * cellHeight - cellHeight / 2;
 
      int v, h, vf, hf;
 
      if (lX > 0) {
        v = Math.min(n, cellX + 1);
        vf = 1;
      }
      else {
        v = Math.max(0, cellX - 1);
        vf = -1;
      }
 
      if (lY > 0) {
        h = Math.min(n, cellY + 1);
        hf = 1;
      }
      else {
        h = Math.max(0, cellY - 1);
        hf = -1;
      }
 
      float dxv =  fluidSolver.getDx(v, cellY);
      float dxh =  fluidSolver.getDx(cellX, h);
      float dxvh =  fluidSolver.getDx(v, h);
 
      float dyv =  fluidSolver.getDy(v, cellY);
      float dyh =  fluidSolver.getDy(cellX, h);
      float dyvh =  fluidSolver.getDy(v, h);
 
      dx = lerp(lerp(dx, dxv, vf * lX / cellWidth),
      lerp(dxh, dxvh, vf * lX / cellWidth),
      hf * lY / cellHeight);
 
      dy = lerp(lerp(dy, dyv, vf * lX / cellWidth),
      lerp(dyh, dyvh, vf * lX / cellWidth),
      hf * lY / cellHeight);
 
      p.x += dx * vScale;
      p.y += dy * vScale;
 
      if (p.x < 0 || p.x >= width) {
        p.x = random(width);
      }
      if (p.y < 0 || p.y >= height) {
        p.y = random(height);
      }
      
      //set((int) p.x, (int) p.y, c1);
      set((int) p.x, (int) p.y, p.c);
    }
  }
}
 
private void drawMotionVectorsImmediate(float l) {
  int n = NavierStokesSolver.N;
  float cellHeight = height / n;
  float cellWidth = width / n;
  float dx, dy, x, y, x1, y1, x2, y2, x3, y3;
  int i, j;
 
  float thick = 0.1f;
 
  beginShape(TRIANGLES);
 
  noStroke();
  //fill(256, 128);
  fill(255,128);
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
 
      dx =  fluidSolver.getDx(i, j);
      dy =  fluidSolver.getDy(i, j);
 
      x = cellWidth / 2 + cellWidth * i;
      y = cellHeight / 2 + cellHeight * j;
 
      x1 = x + dx * l;
      y1 = y + dy * l;
 
      x2 = x + dy * l * thick;
      y2 = y - dx * l * thick;
 
      x3 = x - dy * l * thick;
      y3 = y + dx * l * thick;
 
      // normal(0, 0, 1f);
      vertex(x1, y1);
      vertex(x2, y2);
      vertex(x3, y3);
    }
  }
  endShape();
}
 
private void handleMouseMotion() {
  if(mousePressed)
  {
  mouseX = max(1, mouseX);
  mouseY = max(1, mouseY);
 
  int n = NavierStokesSolver.N;
  float cellHeight = height / n;
  float cellWidth = width / n;
 
  float mouseDx = mouseX - oldMouseX;
  float mouseDy = mouseY - oldMouseY;
  int cellX = floor(mouseX / cellWidth);
  int cellY = floor(mouseY / cellHeight);
 
  mouseDx = (abs(mouseDx) > limitVelocity) ? Math.signum(mouseDx) * limitVelocity : mouseDx;
  mouseDy = (abs(mouseDy) > limitVelocity) ? Math.signum(mouseDy) * limitVelocity : mouseDy;
 
  fluidSolver.applyForce(cellX, cellY, mouseDx, mouseDy);
 
  oldMouseX = mouseX;
  oldMouseY = mouseY;
  }
}
 
public class Particle {
  public float x;
  public float y;
  public color c;
}
 
/**
 * Java implementation of the Navier-Stokes-Solver from
 * http://www.dgp.toronto.edu/people/stam/reality/Research/pdf/GDC03.pdf
 */
public class NavierStokesSolver {
  final static int N = 16;
  final static int SIZE = (N + 2) * (N + 2);
  float[] u = new float[SIZE];
  float[] v = new float[SIZE];
  float[] u_prev = new float[SIZE];
  float[] v_prev = new float[SIZE];
  //    float[] dense = new float[SIZE];
  //    float[] dense_prev = new float[SIZE];
 
  public NavierStokesSolver() {
  }
 
  public float getDx(int x, int y) {
    return u[INDEX(x + 1, y + 1)];
  }
 
  public float getDy(int x, int y) {
    return v[INDEX(x + 1, y + 1)];
  }
 
  public void applyForce(int cellX, int cellY, float vx, float vy) {
    cellX += 1;
    cellY += 1;
    float dx = u[INDEX(cellX, cellY)];
    float dy = v[INDEX(cellX, cellY)];
 
    u[INDEX(cellX, cellY)] = (vx != 0) ? lerp( vx,
     dx, 0.85f) : dx;
    v[INDEX(cellX, cellY)] = (vy != 0) ? lerp( vy,
     dy, 0.85f) : dy;
  }
 
  void tick(float dt, float visc, float diff) {
    vel_step(u, v, u_prev, v_prev, visc, dt);
    //      dens_step(dense, dense_prev, u, v, diff, dt);
  }
 
  final int INDEX(int i, int j) {
    return i + (N + 2) * j;
  }
 
  float[] tmp = new float[SIZE];
 
  final void SWAP(float[] x0, float[] x) { // not longer used anyway
    System.arraycopy(x0, 0, tmp, 0, SIZE);
    System.arraycopy(x, 0, x0, 0, SIZE);
    System.arraycopy(tmp, 0, x, 0, SIZE);
  }
 
  void add_source(float[] x, float[] s, float dt) {
    int i, size = (N + 2) * (N + 2);
    for (i = 0; i < size; i++)
      x[i] += dt * s[i];
  }
 
  void diffuse(int b, float[] x, float[] x0, float diff, float dt) {
    int i, j, k;
    float a = dt * diff * N * N;
    for (k = 0; k < 20; k++) {
      for (i = 1; i <= N; i++) {
        for (j = 1; j <= N; j++) {
          x[INDEX(i, j)] = (x0[INDEX(i, j)] + a
            * (x[INDEX(i - 1, j)] + x[INDEX(i + 1, j)]
            + x[INDEX(i, j - 1)] + x[INDEX(i, j + 1)]))
            / (1 + 4 * a);
        }
      }
      set_bnd(b, x);
    }
  }
 
  void advect(int b, float[] d, float[] d0, float[] u, float[] v,
  float dt) {
    int i, j, i0, j0, i1, j1;
    float x, y, s0, t0, s1, t1, dt0;
    dt0 = dt * N;
    for (i = 1; i <= N; i++) {
      for (j = 1; j <= N; j++) {
        x = i - dt0 * u[INDEX(i, j)];
        y = j - dt0 * v[INDEX(i, j)];
        if (x < 0.5)
          x = 0.5;
        if (x > N + 0.5)
          x = N + 0.5;
        i0 = (int) x;
        i1 = i0 + 1;
        if (y < 0.5)
          y = 0.5;
        if (y > N + 0.5)
          y = N + 0.5;
        j0 = (int) y;
        j1 = j0 + 1;
        s1 = x - i0;
        s0 = 1 - s1;
        t1 = y - j0;
        t0 = 1 - t1;
        d[INDEX(i, j)] = s0
          * (t0 * d0[INDEX(i0, j0)] + t1 * d0[INDEX(i0, j1)])
          + s1
            * (t0 * d0[INDEX(i1, j0)] + t1 * d0[INDEX(i1, j1)]);
      }
    }
    set_bnd(b, d);
  }
 
  void set_bnd(int b, float[] x) {
    int i;
    for (i = 1; i <= N; i++) {
      x[INDEX(0, i)] = (b == 1) ? -x[INDEX(1, i)] : x[INDEX(1, i)];
      x[INDEX(N + 1, i)] = b == 1 ? -x[INDEX(N, i)] : x[INDEX(N, i)];
      x[INDEX(i, 0)] = b == 2 ? -x[INDEX(i, 1)] : x[INDEX(i, 1)];
      x[INDEX(i, N + 1)] = b == 2 ? -x[INDEX(i, N)] : x[INDEX(i, N)];
    }
    x[INDEX(0, 0)] = 0.5 * (x[INDEX(1, 0)] + x[INDEX(0, 1)]);
    x[INDEX(0, N + 1)] = 0.5 * (x[INDEX(1, N + 1)] + x[INDEX(0, N)]);
    x[INDEX(N + 1, 0)] = 0.5 * (x[INDEX(N, 0)] + x[INDEX(N + 1, 1)]);
    x[INDEX(N + 1, N + 1)] = 0.5 * (x[INDEX(N, N + 1)] + x[INDEX(N + 1, N)]);
  }
 
  void dens_step(float[] x, float[] x0, float[] u, float[] v,
  float diff, float dt) {
    add_source(x, x0, dt);
    SWAP(x0, x);
    diffuse(0, x, x0, diff, dt);
    SWAP(x0, x);
    advect(0, x, x0, u, v, dt);
  }
 
  void vel_step(float[] u, float[] v, float[] u0, float[] v0,
  float visc, float dt) {
    //      add_source(u, u0, dt);
    //      add_source(v, v0, dt);
    //      SWAP(u0, u);
    //      diffuse(1, u, u0, visc, dt);
    //      SWAP(v0, v);
    //      diffuse(2, v, v0, visc, dt);
    //      project(u, v, u0, v0);
    //      SWAP(u0, u);
    //      SWAP(v0, v);
    //      advect(1, u, u0, u0, v0, dt);
    //      advect(2, v, v0, u0, v0, dt);
    //      project(u, v, u0, v0);
 
    diffuse(1, u, u, visc, dt);
    diffuse(2, v, v, visc, dt);
    project(u, v, u0, v0);
  }
 
  void project(float[] u, float[] v, float[] p, float[] div) {
    int i, j, k;
    float h;
    h = 1.0 / N;
    for (i = 1; i <= N; i++) {
      for (j = 1; j <= N; j++) {
        div[INDEX(i, j)] = -0.5
          * h
          * (u[INDEX(i + 1, j)] - u[INDEX(i - 1, j)]
          + v[INDEX(i, j + 1)] - v[INDEX(i, j - 1)]);
        p[INDEX(i, j)] = 0;
      }
    }
    set_bnd(0, div);
    set_bnd(0, p);
    for (k = 0; k < 20; k++) {
      for (i = 1; i <= N; i++) {
        for (j = 1; j <= N; j++) {
          p[INDEX(i, j)] = (div[INDEX(i, j)] + p[INDEX(i - 1, j)]
            + p[INDEX(i + 1, j)] + p[INDEX(i, j - 1)] + p[INDEX(
          i, j + 1)]) / 4;
        }
      }
      set_bnd(0, p);
    }
    for (i = 1; i <= N; i++) {
      for (j = 1; j <= N; j++) {
        u[INDEX(i, j)] -= 0.5
          * (p[INDEX(i + 1, j)] - p[INDEX(i - 1, j)]) / h;
        v[INDEX(i, j)] -= 0.5
          * (p[INDEX(i, j + 1)] - p[INDEX(i, j - 1)]) / h;
      }
    }
    set_bnd(1, u);
    set_bnd(2, v);
  }
}

void keyPressed()
//help by Felix Woitzel
{
  if (key == 'i') {initParticles();}
}
