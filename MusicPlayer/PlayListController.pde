class PlayListController extends AbstractChildElement implements ParentableElement<PositionedElement> {
  private BaseParentElement<PositionedElement> baseParent;
  private PlayList controllingPlayList;
  private PVector songListPos;
  private ListBox songList;
  private PShape playShape;
  private ShapeButton playButton;
  
  PlayListController(PlayList controllingPlayList) {
    super();
    this.controllingPlayList = controllingPlayList;
    baseParent = new BaseParentElement(this);
    songListPos = new PVector(width * 0.10, height * 0.10);
    updateSongListBox();
    playShape = loadShape("icons/playCircle.svg");
    PVector playButtonSize = new PVector(height * 0.10, height * 0.10);
    playButton = new ShapeButton(playShape, new PVector(songListPos.x, songListPos.y - playButtonSize.y), playButtonSize, color(0), "onPlayButtonPressed");
    updateSelectedSong();
    addElement(playButton);
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
  
  private void updatePlayButtonCol() {
    playButton.setCol(isPlayListSelected() ? color(0, 150, 255) : color(0));
  }
  
  private void onMusicUpdate() {
    updateSelectedSong();
    updatePlayButtonCol();
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
