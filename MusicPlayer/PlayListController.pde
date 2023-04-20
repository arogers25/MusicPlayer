public class PlayListController extends Layout {
  private PlayList controllingPlayList;
  private PVector songListPos, songListSize;
  private ListBox songList;
  private ShapeButton playButton;
  
  PlayListController(PlayList controllingPlayList) {
    super();
    this.controllingPlayList = controllingPlayList;
    songListPos = new PVector(width * 0.10, height * 0.15);
    songListSize = new PVector(width * 0.80, height * 0.60);
    updateSongListBox();
    createControlElements();
    updateSelectedSong();
  }
  
  private void createPlayButton(PVector buttonSize, float posY) {
    playButton = new ShapeButton(currentStyle.playShape, new PVector(songListPos.x, posY), buttonSize, currentStyle.black, "onPlayButtonPressed");
    addElement(playButton);
  }
  
  private void createAddSongButton(PVector buttonSize, float posY) {
    float posX = songListPos.x + songListSize.x - buttonSize.x;
    ShapeButton addSongButton = new ShapeButton(currentStyle.plusShape, new PVector(posX, posY), buttonSize, currentStyle.black, "onAddSongButtonPressed");
    addElement(addSongButton);
  }
  
  private void createControlElements() {
    PVector controlButtonSize = new PVector(height * 0.10, height * 0.10);
    float aboveSongListY = songListPos.y - controlButtonSize.y;
    createPlayButton(controlButtonSize, aboveSongListY);
    createAddSongButton(controlButtonSize, aboveSongListY);
    addElement(new SongController());
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
  
  void addSelectedSongFile(File selectedFile) {
    if (selectedFile == null) {
      return;
    }
    controllingPlayList.addSongFromPath(selectedFile.getPath());
    int latestSongIndex = controllingPlayList.getLatestIndex();
    AudioMetaData songData = controllingPlayList.getData(latestSongIndex);
    if (songData != null) {
      String songTitle = songData.title();
      songList.addItem(songTitle, latestSongIndex);
    }
  }
  
  void onAddSongButtonPressed() {
    if (controllingPlayList == null) {
      return;
    }
    selectInput("Select a song to add to this playlist:", "addSelectedSongFile", null, this);
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
    playButton.setCol(isPlayListSelected() ? currentStyle.highlightColor : currentStyle.black);
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
