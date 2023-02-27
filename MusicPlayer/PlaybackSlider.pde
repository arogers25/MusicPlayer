// A Slider to control the playback of AudioPlayer objects

final class PlaybackSlider extends Slider {
  private AudioPlayer controlledSong;
  private boolean alreadyPaused;

  PlaybackSlider(PVector pos, PVector size, color progressCol, color emptyCol, AudioPlayer controlledSong) {
    super(pos, size, progressCol, emptyCol, 0, 0, controlledSong.length());
    this.controlledSong = controlledSong;
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
}
