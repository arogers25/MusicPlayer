// A Slider to control the playback of AudioPlayer objects

// Minim cannot perfectly determine song length, so multiplying the song length by LENGTH_FIX_PERCENTAGE gives a decent estimate that does not leave out too much of the song
final float LENGTH_FIX_PERCENTAGE = 0.998;

final class PlaybackSlider extends Slider {
  private AudioPlayer controlledSong;
  private boolean alreadyPaused;

  PlaybackSlider(PVector pos, PVector size, color progressCol, color emptyCol, AudioPlayer controlledSong) {
    super(pos, size, progressCol, emptyCol, 0, 0, controlledSong == null ? 0 : (controlledSong.length() * LENGTH_FIX_PERCENTAGE));
    this.controlledSong = controlledSong;
  }
  
  AudioPlayer getControlledSong() {
    return controlledSong;
  }
  
  void setControlledSong(AudioPlayer controlledSong) {
    this.controlledSong = controlledSong;
    if (controlledSong != null) {
      maxValue = controlledSong.length() * LENGTH_FIX_PERCENTAGE;
      float fixedSongPosition = constrain(controlledSong.position(), 0, maxValue); // Since maximum slider value is different from song length, position must be constrained
      setCurrentValue(Music.wasUpdated() ? 0 : fixedSongPosition); // Put our song playback at the start whenever we switch songs, or at the current position if a song is already playing
    }
  }

  void onDragBegin() {
    super.onDragBegin();
    if (controlledSong != null) {
      if (!controlledSong.isPlaying()) {
        alreadyPaused = true;
      } else {
        Music.setPlaying(false);
      }
    }
  }

  void doDragEvent() {
    super.doDragEvent();
  }

  void onDragEnd() {
    super.onDragEnd();
    if (controlledSong != null) {
      controlledSong.cue((int)currentValue);
      if (!alreadyPaused) {
        Music.setPlaying(true); // Only unpause the song when the slider has been dragged if the song wasn't already paused before
      }
    }
    alreadyPaused = false;
  }
  
  void update() {
    super.update();
    if (controlledSong != null) {
      if (controlledSong.isPlaying()) {
        setCurrentValue(controlledSong.position());
      }
    } else {
      setCurrentValue(0);
    }
  }
}
