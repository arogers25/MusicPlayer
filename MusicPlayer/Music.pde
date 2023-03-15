class Music {
  private Minim minim;
  private AudioPlayer currentSong;
  private boolean updated = false;
  
  Music(Minim minim) {
    this.minim = minim;
  }
  
  AudioPlayer loadSong(String name) {
    return minim.loadFile("songs/" + name);
  }
  
  AudioPlayer getCurrentSong() {
    return currentSong;
  }
  
  void setCurrentSong(AudioPlayer newSong) {
    if (currentSong == newSong) {
      return;
    }
    boolean wasPlaying = isPlaying();
    if (currentSong != null) {
      currentSong.close(); // Allow old song to be garbage collected
    }
    currentSong = newSong;
    if (currentSong != null) {
      setPlaying(wasPlaying); // Restore play/pause state from previous song so playlists can continue without user input
    }
    setUpdated(true);
  }
  
  void setCurrentSong(String name) {
    setCurrentSong(loadSong(name));
  }
  
  boolean wasUpdated() {
    return updated;
  }
  
  void setUpdated(boolean updated) {
    this.updated = updated;
  }
  
  boolean isPlaying() {
    if (currentSong == null) {
      return false;
    }
    return currentSong.isPlaying();
  }
  
  void setPlaying(boolean playing) {
    if (currentSong != null) {
      if (playing) {
        currentSong.play();
      } else {
        currentSong.pause();
      }
    }
  }
  
  void togglePlaying() {
    if (currentSong == null) {
      return;
    }
    boolean statusToSet = !isPlaying();
    setPlaying(statusToSet);
  }
}
