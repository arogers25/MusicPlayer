class PlayListController extends Layout {
  private PlayList controllingPlayList;
  private PVector songListPos, songListSize;
  private ListBox songList;
  private ShapeButton playButton;
  
  PlayListController(PlayList controllingPlayList) {
    super();
    this.controllingPlayList = controllingPlayList;
    songListPos = new PVector(width * 0.10, height * 0.15);
    songListSize = new PVector(width * 0.80, height * 0.60);
    PVector controlButtonSize = new PVector(height * 0.10, height * 0.10);
    updateSongListBox();
    PShape playShape = loadShape("icons/playCircle.svg");
    playButton = new ShapeButton(playShape, new PVector(songListPos.x, songListPos.y - controlButtonSize.y), controlButtonSize, color(0), "onPlayButtonPressed");
    addElement(playButton);
    addElement(new SongController());
    updateSelectedSong();
  }
  
  private boolean isPlayListSelected() {
    return Music.getCurrentPlayList() == controllingPlayList;
  }
  
  void onPlayButtonPressed() {
    if (isPlayListSelected()) {
      return;
    }
    onSongSelected(controllingPlayList.getStartingIndex());
  }
  
  void onSongSelected(Integer index) {
    if (!isPlayListSelected()) {
      Music.setCurrentPlayList(controllingPlayList);
    }
    Music.setIndexedSong(index);
  }
  
  private void addSongItems() {
    for (int i = 0; i < controllingPlayList.getDataList().size(); i++) {
      AudioMetaData songData = controllingPlayList.getData(i);
      if (songData != null) {
        String songTitle = songData.title();
        songList.addItem(songTitle, i);
      }
    }
  }
  
  private void updateSongListBox() {
    if (controllingPlayList == null) {
      return;
    }
    songList = new ListBox(songListPos, songListSize, 10, "onSongSelected", Integer.class);
    addSongItems();
    addElement(songList);
  }
  
  // Updates ListBox to reflect current song if it was set by other source
  private void updateSelectedSong() {
    if (controllingPlayList != null && !isPlayListSelected()) { // If a song was selected from a different playlist
      songList.setSelectedItem((ListItem)null);
      return;
    }
    if (isPlayListSelected()) {
      int currentSongIndex = Music.getCurrentDataIndex();
      songList.setSelectedItem(currentSongIndex);
    }
  }
  
  private void updatePlayButtonCol() {
    playButton.setCol(isPlayListSelected() ? color(0, 150, 255) : color(0));
  }
  
  private void onMusicUpdate() {
    updateSelectedSong();
    updatePlayButtonCol();
    Music.setUpdated(false);
  }
  
  void update() {
    if (Music.wasUpdated()) {
      onMusicUpdate();
    }
    super.update();
  }
}
