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

void setup() {
  fullScreen();
  minim = new Minim(this);
  setCurrentSong(songToPlay);
  currentSong.play();
  scrubBarWidth = width * 0.85;
  scrubBarPosX = (width - scrubBarWidth) / 2.0;
  scrubBarPosY = height * 0.80;
}

void setCurrentSong(String songName) {
  currentSong = minim.loadFile(songName);
  metaData = currentSong.getMetaData();
  println(metaData.author(), metaData.title());
}

void drawScrubKnob() {
  float knobPos = map(currentSong.position(), 0, currentSong.length(), 0, scrubBarWidth);
  rect(scrubBarPosX + knobPos - SCRUB_KNOB_OFFSET_X, scrubBarPosY - SCRUB_KNOB_OFFSET_Y, SCRUB_KNOB_WIDTH, SCRUB_KNOB_HEIGHT);
}

void drawScrubBar() {
  rect(scrubBarPosX, scrubBarPosY, scrubBarWidth, SCRUB_BAR_HEIGHT);
  drawScrubKnob();
}

void draw() {
  background(255);
  fill(0);
  drawScrubBar();
}
