// ListItems are RectangleButtons with special scroll behavior for ListBoxes
class ListItem extends RectangleButton {
  private PVector offsetPos;
  private PVector anchorPos;
  private float visibleMin, visibleMax;
  private boolean visible;
  
  ListItem(String labelText, PVector pos, PVector offsetPos, PVector size, color col, color textCol, String clickMethodName, Object... clickArgs) {
    super(labelText, pos, size, col, textCol, clickMethodName, clickArgs);
    anchorPos = new PVector().set(pos);
    this.offsetPos = offsetPos;
  }
  
  void adjustToOffset() {
    pos.set(PVector.add(anchorPos, offsetPos));
    float maxY = pos.y + size.y;
    visible = (pos.y > visibleMin && maxY < visibleMax) || (pos.y < visibleMax && maxY > visibleMin);
  }
  
  void setVisibleBounds(float visibleMin, float visibleMax) {
    this.visibleMin = visibleMin;
    this.visibleMax = visibleMax;
  }
  
  void doInput() {
    if (mouseY >= visibleMin && mouseY <= visibleMax) {
      super.doInput();
    }
  }
  
  void update() {
    adjustToOffset();
    if (visible) {
      super.update();
    }
  }
}
