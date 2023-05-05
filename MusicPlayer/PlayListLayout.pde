final class PlayListLayout extends ListBoxControlLayout {
  private PlayListContainer playListContainer;
  private PlayList clickedPlayList;
  private ShapeButton currentPlayListButton;
  
  PlayListLayout() {
    super(new PVector(width * 0.10, height * 0.15), new PVector(width * 0.80, height * 0.60), height * 0.10);
    this.playListContainer = Music.getPlayListContainer();
    if (playListContainer.getCurrentPlayList() != null) {
      createCurrentPlayListButton();
    }
    createControllingListBox();
  }
  
  void onPlayListSelected(PlayList playList) {
    if (playList != null && clickedPlayList == playList) { // PlayLists must be double clicked to open them
      currentLayout = new SongListLayout(clickedPlayList);
    }
    clickedPlayList = playList;
  }
  
  protected void createControllingListBox() {
    controllingListBox = new ListBox(listBoxPos, listBoxSize, 10, "onPlayListSelected", PlayList.class);
    addListBoxItems();
    super.createControllingListBox();
  }
  
  protected void addIndexedItem(int index) {
    PlayList playList = playListContainer.getIndexedPlayList(index);
    if (playList != null) {
      controllingListBox.addItem(playList.getName(), playList);
    }
  }
  
  protected void onListBoxUpdate() {
    int latestPlayListIndex = playListContainer.getPlayListsSize() - 1;
    addIndexedItem(latestPlayListIndex);
    super.onListBoxUpdate();
  }
  
  void addListBoxItems() {
    for (int i = 0; i < playListContainer.getPlayListsSize(); i++) {
      addIndexedItem(i);
    }
  }
  
  void onAddItemButtonPressed() {
    int playListCount = playListContainer.getPlayListsSize();
    Music.getPlayListContainer().createEmptyPlayList("Playlist " + playListCount);
    listBoxUpdated = true;
  }
  
  void onSongListButtonPressed() {
    currentLayout = new SongListLayout(playListContainer.getCurrentPlayList());
  }
  
  private void createCurrentPlayListButton() {
    currentPlayListButton = new ShapeButton(currentStyle.playListShape, new PVector(0, 0), controlElementSize, currentStyle.highlightColor, "onSongListButtonPressed");
    addElement(currentPlayListButton);
  }
  
  // Allow the user to deselect a clicked PlayList by clicking outside of the ListBox
  private void updateItemClick() {
    if (Input.isMousePressed(LEFT) && !controllingListBox.isMouseHovering()) {
      clickedPlayList = null;
    }
  }
  
  void update() {
    updateItemClick();
    super.update();
  }
}
