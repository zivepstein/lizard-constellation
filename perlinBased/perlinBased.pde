/**
 * Slight hack from DomeProjection example (found I do not know where)
 * 
 * This sketch uses use environmental mapping to render the output 
 * on a full spherical dome.
 * 
 * Based on the FullDomeTemplate code from Christopher Warnow: 
 * https://github.com/mphasize/FullDome
 * 
 */

import java.nio.IntBuffer;

PShader cubemapShader;
PShape domeSphere;

IntBuffer fbo;
IntBuffer rbo;
IntBuffer envMapTextureID;

float x = 0;
float y = 0;
int envMapSize = 1024;   
float p = 0.0;
float q = 0.0;


PImage img;

void setup() {
  size(640, 640, P3D);
  initCubeMap();
  img = loadImage("/Users/ziv/Desktop/ss.png");
}

void draw() {
  background(0);
  drawCubeMap();
  //saveFrame("/home/ian/Desktop/output/frames####.png");
}

void drawScene() {  
  background(0);

  stroke(255, 0, 0);
  strokeWeight(2);
  for (int i = -width; i < 2 * width; i += 50) {
    line(i, -height, -100, i, 2 *height, -100);
  }
  for (int i = -height; i < 2 * height; i += 50) {
    line(-width, i, -100, 2 * width, i, -100);
  }

  lights();
  noStroke();
  
  p += .001;
  q += .001;
  
  x = 640*noise(0,p);
  y = 640*noise(q,0);
  
  translate(x, y, 200);
  
  //  rotateX(frameCount * 0.01);
  //  rotateY(frameCount * 0.01);  
  //  box(100);
  float a = 320 - x;
  float b = 320 - y;
  float ratio = a/b;
  float theta = atan(ratio);
  println(theta);

scale(.2);

  //rotateZ(3.1416/2);
  if (mouseY>320)
    rotateZ(-theta);
  else
    rotateZ(3.1614-theta);

  image(img, -img.width/2, -img.height/2);
}