// This file contains all necessary methods for Elements to display and be controlled properly
// This is intended to make new projects able to run almost instantly with the proper files copied
// There should be no modifications to this code, and all unique code for a project should be contained in its main file or in a different file 

import java.lang.reflect.Method; // For element click events

Style currentStyle;
Layout currentLayout;

void setupAppEngine() {
  Input.setAppInst(this);
  currentStyle = new Style();
  textFont(currentStyle.mainFont);
}

void setCurrentLayout(Layout currentLayout) {
  this.currentLayout = currentLayout;
}

// Default Processing method overrides

void draw() {
  if (currentLayout != null) {
    currentLayout.update();
  }
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
