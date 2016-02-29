/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/81905*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
import java.awt.event.KeyEvent;

PointCloud pc;
PImage [] imglist;
PImage testImg;
boolean doPause = false;
static final int FPS = 30, MORPH_DURATION = 131, POINTCOUNT = 16000, RND_MODE = 1, MORPH_MODE = 0, OPACITY_MAX = 30;

int currentImageIndex = 0;

void setup ()
{
  size (720, 480, P3D);
  frameRate (FPS);

  imglist = new PImage [0];
 



  imglist = (PImage []) append (imglist, loadImage ("1flower.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("bamboo.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("hierogl.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("fuji.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("chasen.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("profile.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("buttf.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("tatahier.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("fish.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("ho.jpg")); 
  imglist = (PImage []) append (imglist, loadImage ("close.jpg"));
  imglist = (PImage []) append (imglist, loadImage ("hbtu.jpg"));

  testImg = imglist [currentImageIndex];
  pc = new PointCloud (POINTCOUNT);

  float cx, cy;
  while (pc.p.length <= pc.length)
  {
    float [] [] target = (float[] []) findTargets (1, testImg);
    
    cx = random (width);
    cy = random (height);
    pc.addPatricel (new Particle(cx, cy, target[0][0], target[0][1]));
  }

  background (225, 232, 191);
  stroke (71, 121, 79, 80);
}

void FadeIn (PImage img)
{
  final int fc = frameCount % MORPH_DURATION;
  final float opacity = map(fc, 0, MORPH_DURATION, 0, OPACITY_MAX);
  tint(-1, opacity);
  image(img, 0, 0);
  //surface.setTitle("Alpha: " + fc + "\t\tTime: " + fc/FPS);  
}

void draw ()
{
    FadeIn(testImg);
  
    noStroke();
    fill (236, 255, 213, 80);
    rect (0, 0, width, height);
    stroke (71, 121, 79, 80);

    pc.draw();
    if (pc.paused)
    {
      testImg = imglist [currentImageIndex];
      updatePointCloud (testImg, MORPH_MODE);
    }
    
    //saveFrame("frames\\line-######.png");
}


void updatePointCloud (PImage img, int mode)
{
  currentImageIndex++;
  if (currentImageIndex == imglist.length) currentImageIndex = 0;
  float [] [] target = (float[] []) findTargets (pc.p.length, img);
  if (mode == 0) pc.update (target);
  else pc.updateSimple (target);
}

void keyPressed ()
{
  if (keyCode == KeyEvent.VK_P) {
    doPause = !doPause;
    if (doPause) noLoop();
    else loop();
  }
}