import ddf.minim.*;
Layout currentLayout;
Input input;

void setup() {
  fullScreen();
  //size(700, 700);
  //doOldSetup();
  currentLayout = new MainLayout();
  input = new Input();
}

void draw() {
  background(255);
  fill(0);
  //drawScrubBar();
  //drawMetaData();
  currentLayout.update();
  input.updateStates();
}

void keyPressed() {
  //doOldKeyPressed();
  input.doKeyPressed();
}

void keyReleased() {
  input.doKeyReleased();
}

void mousePressed() {
  //doOldMousePressed();
  input.doMousePressed();
}

void mouseReleased() {
  //doOldMouseReleased();
  input.doMouseReleased();
}
