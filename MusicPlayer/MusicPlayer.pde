import ddf.minim.*;
Minim minim;
AudioPlayer currentSong;
AudioMetaData metaData;
String songToPlay = "songs/Beat_Your_Competition.mp3";


void setup() {
  minim = new Minim(this);
  setCurrentSong(songToPlay);
  currentSong.play();
}

void setCurrentSong(String songName) {
  currentSong = minim.loadFile(songName);
  metaData = currentSong.getMetaData();
  println(metaData.author(), metaData.title());
}

void draw() {
}
