import java.lang.reflect.Method; // For element click events
Layout currentLayout;
PFont mainFont;

void setup() {
  fullScreen();
  Input.setAppInst(this);
  Music.setAppInst(this);
  Music.setCurrentSong("Beat_Your_Competition.mp3");
  //size(700, 700);
  //doOldSetup();
  currentLayout = new MainLayout();
  mainFont = createFont("Arial", 32);
  textFont(mainFont);
}

void draw() {
  background(255);
  fill(0);
  //drawScrubBar();
  //drawMetaData();
  currentLayout.update();
  Input.updateStates();
}

void keyPressed() {
  //doOldKeyPressed();
  Input.doKeyPressed();
}

void keyReleased() {
  Input.doKeyReleased();
}

void mousePressed() {
  //doOldMousePressed();
  Input.doMousePressed();
}

void mouseReleased() {
  //doOldMouseReleased();
  Input.doMouseReleased();
}
