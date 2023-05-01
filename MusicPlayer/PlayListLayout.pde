final class PlayListLayout extends ListBoxControlLayout {
  private PlayListContainer playListContainer;
  private PlayList selectedPlayList;
  
  PlayListLayout() {
    super(new PVector(width * 0.10, height * 0.15), new PVector(width * 0.80, height * 0.60), height * 0.10);
    this.playListContainer = Music.getPlayListContainer();
    createControllingListBox();
  }
  
  void onPlayListSelected(PlayList playList) {
    if (playList != null && selectedPlayList == playList) { // PlayLists must be double clicked to open them
      currentLayout = new SongListLayout(selectedPlayList);
    }
    selectedPlayList = playList;
  }
  
  protected void createControllingListBox() {
    controllingListBox = new ListBox(listBoxPos, listBoxSize, 10, "onPlayListSelected", PlayList.class);
    addListBoxItems();
    super.createControllingListBox();
  }
  
  protected void onListBoxUpdate() {
    listBoxUpdated = false;
  }
  
  protected void onMusicUpdate() {
    Music.setUpdated(false);
  }
  
  void addListBoxItems() {
    for (int i = 0; i < playListContainer.getPlayLists().size(); i++) {
      PlayList playList = playListContainer.getIndexedPlayList(i);
      if (playList != null) {
        controllingListBox.addItem(playList.getName(), playList);
      }
    }
  }
  
  void onAddItemButtonPressed() {
  }
  
  // If no PlayList has been clicked and no PlayList is playing, allow the user to deselect a clicked PlayList by clicking outside of the ListBox
  private void updateItemClick() {
    if (Input.isMousePressed(LEFT) && !controllingListBox.isMouseHovering()) {
      selectedPlayList = null;
      controllingListBox.setSelectedItem((ListItem)null);
    }
  }
  
  void update() {
    if (playListContainer.getCurrentPlayList() == null) {
      updateItemClick();
    }
    super.update();
  }
}
