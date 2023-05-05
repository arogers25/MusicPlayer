public final class SongListLayout extends ListBoxControlLayout {
  private PlayListContainer playListContainer;
  private PlayList controllingPlayList;
  private ShapeButton playButton;
  
  SongListLayout(PlayList controllingPlayList) {
    super(new PVector(width * 0.10, height * 0.15), new PVector(width * 0.80, height * 0.60), height * 0.10);
    this.playListContainer = Music.getPlayListContainer();
    this.controllingPlayList = controllingPlayList;
    createControllingListBox();
    updateSelectedSong();
    updatePlayButtonCol();
  }
  
  protected void createControllingListBox() {
    if (controllingPlayList == null) {
      return;
    }
    controllingListBox = new ListBox(listBoxPos, listBoxSize, 10, "onSongSelected", Integer.class);
    addListBoxItems();
    super.createControllingListBox();
  }
  
  protected void addIndexedItem(int index) {
    AudioMetaData songData = controllingPlayList.getData(index);
    if (songData != null) {
      String songTitle = songData.title();
      controllingListBox.addItem(songTitle, index);
    }
  }
  
  // selectInput() runs on a different thread, so the song ListBox's elements are updated before iterating through them  
  protected void onListBoxUpdate() {
    int latestSongIndex = controllingPlayList.getDataSize() - 1;
    addIndexedItem(latestSongIndex);
    super.onListBoxUpdate();
  }
  
  protected void onMusicUpdate() {
    updateSelectedSong();
    updatePlayButtonCol();
    super.onMusicUpdate();
  }
  
  protected void createControlElements() {
    createPlayButton();
    createBackButton();
    super.createControlElements();
  }
  
  protected void addListBoxItems() {
    for (int i = 0; i < controllingPlayList.getDataSize(); i++) {
      addIndexedItem(i);
    }
  }
  
  void addSelectedSongFile(File selectedFile) {
    if (selectedFile == null) {
      return;
    }
    String filePath = selectedFile.getPath();
    if (!filePath.endsWith(".mp3")) {
      return;
    }
    controllingPlayList.addSongFromPath(filePath);
    listBoxUpdated = true;
  }
  
  void onAddItemButtonPressed() {
    if (controllingPlayList == null) {
      return;
    }
    selectInput("Select a song to add to this playlist:", "addSelectedSongFile", null, this);
  }
  
  private boolean isPlayListSelected() {
    return playListContainer.getCurrentPlayList() == controllingPlayList;
  }
  
  
  private void updatePlayButtonCol() {
    playButton.setCol(isPlayListSelected() ? currentStyle.highlightColor : currentStyle.black);
  }
  
  void onPlayButtonPressed() {
    if (isPlayListSelected()) {
      return;
    }
    onSongSelected(controllingPlayList.getStartingIndex());
  }
  
  private void createPlayButton() {
    playButton = new ShapeButton(currentStyle.playShape, getAboveListPos(), controlElementSize, currentStyle.black, "onPlayButtonPressed");
    addElement(playButton);
  }
  
  void onBackButtonPressed() {
    currentLayout = new PlayListLayout();
  }
  
  private void createBackButton() {
    ShapeButton backButton = new ShapeButton(currentStyle.backArrowShape, new PVector(0, 0), controlElementSize, currentStyle.black, "onBackButtonPressed");
    addElement(backButton);
  }
  
  // Updates ListBox to reflect current song if it was set by other source
  private void updateSelectedSong() {
    if (controllingPlayList != null && !isPlayListSelected()) { // If a song was selected from a different playlist
      controllingListBox.setSelectedItem((ListItem)null);
      return;
    }
    if (isPlayListSelected()) {
      int currentSongIndex = Music.getCurrentDataIndex();
      controllingListBox.setSelectedItem(currentSongIndex);
    }
  }
  
  void onSongSelected(Integer index) {
    if (!isPlayListSelected()) {
      playListContainer.setCurrentPlayList(controllingPlayList);
    }
    Music.setIndexedSong(index, true);
  }
}
