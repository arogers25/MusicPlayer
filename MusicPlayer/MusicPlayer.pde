import java.lang.reflect.Method; // For element click events
Layout currentLayout;
Style currentStyle;

void setup() {
  fullScreen();
  Input.setAppInst(this);
  Music.createMinim(this);
  currentStyle = new Style();
  currentLayout = new PlayListLayout();
  textFont(currentStyle.mainFont);
}

void draw() {
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
