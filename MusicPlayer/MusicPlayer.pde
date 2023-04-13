import java.lang.reflect.Method; // For element click events
Layout currentLayout;
PFont mainFont;

void setup() {
  fullScreen();
  Input.setAppInst(this);
  Music.setAppInst(this);
  //Music.setCurrentSong("Beat_Your_Competition.mp3");
  //size(700, 700);
  currentLayout = new PlayListController(new PlayList(false));
  mainFont = createFont("Arial", 32);
  textFont(mainFont);
}

void draw() {
  background(255);
  fill(0);
  currentLayout.update();
  Input.updateStates();
}

void keyPressed() {
  Input.doKeyPressed();
}

void keyReleased() {
  Input.doKeyReleased();
}

void mousePressed() {
  Input.doMousePressed();
}

void mouseReleased() {
  Input.doMouseReleased();
}
