// A Slider to control the playback of AudioPlayer objects

final class PlaybackSlider extends Slider {
  private AudioPlayer controlledSong;
  private boolean alreadyPaused;

  PlaybackSlider(PVector pos, PVector size, color progressCol, color emptyCol, AudioPlayer controlledSong) {
    super(pos, size, progressCol, emptyCol, 0, 0, controlledSong == null ? 0 : controlledSong.length());
    this.controlledSong = controlledSong;
  }
  
  AudioPlayer getControlledSong() {
    return controlledSong;
  }
  
  void setControlledSong(AudioPlayer controlledSong) {
    this.controlledSong = controlledSong;
    if (controlledSong != null) {
      maxValue = controlledSong.length();
      setCurrentValue(0); // Put our song playback at the start whenever we switch songs
    }
  }

  void onDragBegin() {
    super.onDragBegin();
    if (controlledSong != null) {
      if (!controlledSong.isPlaying()) {
        alreadyPaused = true;
      } else {
        controlledSong.pause();
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
        controlledSong.play(); // Only unpause the song when the slider has been dragged if the song wasn't already paused before
      }
    }
  }
  
  void update() {
    super.update();
    if (controlledSong != null && controlledSong.isPlaying()) {
      setCurrentValue(controlledSong.position());
    }
  }
}
