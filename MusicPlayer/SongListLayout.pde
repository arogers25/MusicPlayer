public final class SongListLayout extends ListBoxControlLayout {
  private PlayListContainer playListContainer;
  private PlayList controllingPlayList;
  private ShapeButton playStopButton;
  
  SongListLayout(PlayList controllingPlayList) {
    super(new PVector(width * 0.10, height * 0.15), new PVector(width * 0.80, height * 0.60), height * 0.10);
    this.playListContainer = Music.getPlayListContainer();
    this.controllingPlayList = controllingPlayList;
    createControllingListBox();
    createPlayListTitleLabel();
    createSaveButton();
    updateSelectedSong();
    updatePlayStopButton();
  }
  
  protected void createControllingListBox() {
    if (controllingPlayList == null) {
      return;
    }
    controllingListBox = new ListBox(listBoxPos, listBoxSize, currentStyle.shownListItems, "onSongSelected", Integer.class);
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
    if (latestSongIndex == 0 && controllingPlayList.getDataSize() > 0) { // If the PlayList was previously empty, attempt to create a save button
      createSaveButton();
    }
    super.onListBoxUpdate();
  }
  
  protected void onMusicUpdate() {
    updateSelectedSong();
    updatePlayStopButton();
    super.onMusicUpdate();
  }
  
  protected void createControlElements() {
    createPlayStopButton();
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
  
  private void updatePlayStopButton() {
    boolean playListSelected = isPlayListSelected();
    playStopButton.setCol(playListSelected ? currentStyle.highlightColor : currentStyle.black);
    playStopButton.setShape(playListSelected ? currentStyle.stopShape : currentStyle.playShape);
  }
  
  void onPlayStopButtonPressed() {
    if (isPlayListSelected()) {
      Music.removeCurrentPlayList();
    } else {
      onSongSelected(controllingPlayList.getStartingIndex());
    }
  }
  
  private void createPlayStopButton() {
    playStopButton = new ShapeButton(currentStyle.playShape, getAboveListPos(), controlElementSize, currentStyle.black, "onPlayStopButtonPressed");
    addElement(playStopButton);
  }
  
  void onSaveButtonPressed() {
    JSONObject playListJson = controllingPlayList.asJsonObject();
    String playListFileName = "data/playLists/" + controllingPlayList.getName() + ".json";
    saveJSONObject(playListJson, playListFileName);
  }
  
  private void createSaveButton() {
    if (controllingPlayList == null || !controllingPlayList.shouldBeSaved()) {
      return;
    }
    ShapeButton saveButton = new ShapeButton(currentStyle.saveShape, new PVector(addButtonPos.x - controlElementSize.x, addButtonPos.y), controlElementSize, currentStyle.black, "onSaveButtonPressed");
    addElement(saveButton);
  }
  
  void onBackButtonPressed() {
    currentLayout = new PlayListLayout();
  }
  
  private void createBackButton() {
    ShapeButton backButton = new ShapeButton(currentStyle.backArrowShape, new PVector(0, 0), controlElementSize, currentStyle.black, "onBackButtonPressed");
    addElement(backButton);
  }
  
  private void createPlayListTitleLabel() {
    boolean shouldSave = controllingPlayList.shouldBeSaved();
    float titleOffsetX = shouldSave ? 1.5 : 1.0;
    float titleScaleX = shouldSave ? 3.0 : 2.0;
    PVector labelPos = getAboveListPos().add(controlElementSize.x * titleOffsetX, -textAscent() / 4.0);
    PVector labelSize = new PVector(listBoxSize.x - controlElementSize.x * titleScaleX, controlElementSize.y);
    Label playListTitleLabel = new Label(controllingPlayList.getName(), labelPos, labelSize, currentStyle.black, CENTER, CENTER);
    addElement(playListTitleLabel);
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
