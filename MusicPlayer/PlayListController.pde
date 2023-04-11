class PlayListController extends AbstractChildElement implements ParentableElement<PositionedElement> {
  private BaseParentElement<PositionedElement> baseParent;
  private PlayList controllingPlayList;
  private ListBox songList;
  
  PlayListController(PlayList controllingPlayList) {
    super();
    this.controllingPlayList = controllingPlayList;
    baseParent = new BaseParentElement(this);
    updateSongListBox();
    updateSelectedSong();
  }
  
  private boolean isPlayListSelected() {
    return Music.getCurrentPlayList() == controllingPlayList;
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
    songList = new ListBox(new PVector(width * 0.10, height * 0.10), new PVector(width * 0.80, height * 0.70), 10, "onSongSelected", Integer.class);
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
  
  private void onMusicUpdate() {
    updateSelectedSong();
    Music.setUpdated(false);
  }
  
  void addElement(PositionedElement element) {
    baseParent.addElement(element);
  }
  
  boolean containsElement(PositionedElement element) {
    return baseParent.containsElement(element);
  }
  
  void update() {
    if (Music.wasUpdated()) {
      onMusicUpdate();
    }
    baseParent.update();
  }
}
