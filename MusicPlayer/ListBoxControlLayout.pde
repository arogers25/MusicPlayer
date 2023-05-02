abstract class ListBoxControlLayout extends Layout {
  protected ListBox controllingListBox;
  protected PVector listBoxPos, listBoxSize, controlElementSize;
  protected boolean listBoxUpdated;
  
  ListBoxControlLayout(PVector listBoxPos, PVector listBoxSize, PVector controlElementSize) {
    super();
    this.listBoxPos = listBoxPos;
    this.listBoxSize = listBoxSize;
    this.controlElementSize = controlElementSize;
    createControlElements();
  }
  
  ListBoxControlLayout(PVector listBoxPos, PVector listBoxSize, float squareControlElementSize) {
    this(listBoxPos, listBoxSize, new PVector(squareControlElementSize, squareControlElementSize));
  }
  
  protected final PVector getAboveListPos() {
    return new PVector(listBoxPos.x, listBoxPos.y - controlElementSize.y);
  }
  
  protected final void createSongController() {
    addElement(new SongController());
  }
  
  protected final void createAddItemButton() {
    final PVector buttonPos = getAboveListPos().add(listBoxSize.x - controlElementSize.x, 0);
    ShapeButton addSongButton = new ShapeButton(currentStyle.plusShape, buttonPos, controlElementSize, currentStyle.black, "onAddItemButtonPressed");
    addElement(addSongButton);
  }
  
  protected void createControllingListBox() {
    addElement(controllingListBox);
    createSongController();
  }
  
  protected void onListBoxUpdate() {
    listBoxUpdated = false;
  }
  
  protected void onMusicUpdate() {
    Music.setUpdated(false);
  }
  
  protected void createControlElements() {
    createAddItemButton();
  }
  
  protected abstract void addIndexedItem(int index);
  
  protected abstract void addListBoxItems();
  
  abstract void onAddItemButtonPressed();
  
  void update() {
    if (listBoxUpdated) {
      onListBoxUpdate();
    }
    if (Music.wasUpdated()) {
      onMusicUpdate();
    }
    super.update();
  }
}
