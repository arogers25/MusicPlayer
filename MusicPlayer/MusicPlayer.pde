import ddf.minim.*;
Minim minim;
AudioPlayer currentSong;
AudioMetaData metaData;
String songToPlay = "songs/Beat_Your_Competition.mp3";
float scrubBarWidth, scrubBarPosX, scrubBarPosY;
float SCRUB_BAR_HEIGHT = 10.0;
float SCRUB_KNOB_WIDTH = 10.0, SCRUB_KNOB_HEIGHT = 30.0;
float SCRUB_KNOB_OFFSET_X = SCRUB_KNOB_WIDTH / 2;
float SCRUB_KNOB_OFFSET_Y = SCRUB_KNOB_HEIGHT / 3;
PFont mainFont;
boolean isScrubbing = false; // If the playback is being adjusted by the mouse
Input input;

void setup() {
  fullScreen();
  //size(700, 700);
  minim = new Minim(this);
  setCurrentSong(songToPlay);
  currentSong.play();
  scrubBarWidth = width * 0.85;
  scrubBarPosX = (width - scrubBarWidth) / 2.0;
  scrubBarPosY = height * 0.80;
  mainFont = createFont("Arial", 32);
  textFont(mainFont);
  input = new Input();
}

void setCurrentSong(String songName) {
  currentSong = minim.loadFile(songName);
  metaData = currentSong.getMetaData();
  println(metaData.author(), metaData.title());
}

void drawScrubKnob() {
  float knobPos = 0;
  if (isScrubbing) {
    float adjustedMouseX = mouseX - scrubBarPosX;
    knobPos = constrain(adjustedMouseX, 0, scrubBarWidth);
  } else {
    knobPos = map(currentSong.position(), 0, currentSong.length(), 0, scrubBarWidth);
  }
  rect(scrubBarPosX + knobPos - SCRUB_KNOB_OFFSET_X, scrubBarPosY - SCRUB_KNOB_OFFSET_Y, SCRUB_KNOB_WIDTH, SCRUB_KNOB_HEIGHT);
}

void drawScrubBar() {
  rect(scrubBarPosX, scrubBarPosY, scrubBarWidth, SCRUB_BAR_HEIGHT);
  drawScrubKnob();
}

void togglePaused() {
  if (currentSong.isPlaying())
    currentSong.pause();
  else
    currentSong.play();
}

void drawMetaData() {
  String formattedTitle = metaData.title() + " (" + formatMilliseconds(currentSong.position()) + ")";
  text(formattedTitle, scrubBarPosX, scrubBarPosY - textAscent());
  text(metaData.author(), scrubBarPosX, scrubBarPosY - textAscent() * 2.0);
}

String formatMilliseconds(int milliseconds) {
  int seconds = milliseconds / 1000;
  int minutes = seconds / 60;
  int remainingSeconds = seconds % 60;
  return String.format("%d:%02d", minutes, remainingSeconds); // "%02d" adds leading zeroes if there is less than 2 digits in the decimal
}

boolean isHoveringScrubBar() {
  return mouseX >= scrubBarPosX && mouseX <= scrubBarPosX + scrubBarWidth && mouseY >= scrubBarPosY - SCRUB_KNOB_OFFSET_Y && mouseY <= scrubBarPosY + SCRUB_KNOB_OFFSET_Y * 2;
}

int getScrubbedTime() {
  return (int)map(mouseX - scrubBarPosX, 0, scrubBarWidth, 0, currentSong.length()); // The position in the song the scrub knob has been moved to
  // Minim already prevents songs from being cued to 0:00 or past their length, so no need to constrain this
}

void draw() {
  background(255);
  fill(0);
  drawScrubBar();
  drawMetaData();
  input.updateStates();
}

void keyPressed() {
  input.doKeyPressed();
  if (key == ' ') {
    togglePaused();
  }
}

void keyReleased() {
  input.doKeyReleased();
}

void mousePressed() {
  input.doMousePressed();
  if (!isScrubbing && isHoveringScrubBar()) {
    isScrubbing = true;
    currentSong.pause();
  }
}

void mouseReleased() {
  input.doMouseReleased();
  if (isScrubbing) {
    isScrubbing = false;
    currentSong.play(getScrubbedTime());
  }
}
