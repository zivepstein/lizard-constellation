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

int envMapSize = 1024;   

PImage img;

void setup() {
  size(640, 640, P3D);
  initCubeMap();
  img = loadImage("/home/ian/Desktop/test.jpg");
}

void draw() {
  background(0);
  drawCubeMap();
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
  translate(mouseX, mouseY, 200);
  //  rotateX(frameCount * 0.01);
  //  rotateY(frameCount * 0.01);  
  //  box(100);
  int a = 320 - mouseX;
  int b = 320 - mouseY;
  float ratio = float(a)/float(b);
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

