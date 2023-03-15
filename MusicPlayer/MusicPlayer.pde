import java.lang.reflect.Method; // For element click events
import ddf.minim.*;
//Minim minim;
//AudioPlayer currentSong;
Music music;
Layout currentLayout;
Input input;

void setup() {
  fullScreen();
  music = new Music(new Minim(this));
  music.setCurrentSong("Beat_Your_Competition.mp3");
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
