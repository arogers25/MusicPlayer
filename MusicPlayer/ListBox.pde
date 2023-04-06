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

class ListBox extends PositionedElement implements ParentableElement<ListItem> {
  private BaseParentElement<ListItem> baseParent;
  private float visibleItems = 3;
  private PVector itemSize;
  private PVector scrollPos;
  private String clickMethodName;
  
  ListBox(PVector pos, PVector size, String clickMethodName) {
    super(pos, size);
    baseParent = new BaseParentElement(this);
    itemSize = new PVector(size.x, size.y / visibleItems);
    scrollPos = new PVector();
    this.clickMethodName = clickMethodName;
  }
  
  void setParent(ParentableElement element) {
    super.setParent(element);
    if (element != null) {
      baseParent.setParentRef(element);
    }
  }
  
  void render() {
    fill(255, 0, 255);
    rect(pos.x, pos.y, size.x, size.y);
    scrollPos.set(0, mouseY - pos.y);
  }
  
  void doInput() {
    if (!isMouseHovering()) {
      return;
    }
  }
  
  void addElement(ListItem element) {
    baseParent.addElement(element);
  }
  
  void addItem(String labelText, Object... clickArgs) {
    PVector adjustedPos = new PVector(pos.x, pos.y + baseParent.getElementsSize() * itemSize.y);
    ListItem itemToAdd = new ListItem(labelText, adjustedPos, scrollPos, itemSize, color(30), color(255), clickMethodName, clickArgs);
    itemToAdd.setVisibleBounds(pos.y, pos.y + size.y);
    addElement(itemToAdd);
  }
  
  boolean containsElement(ListItem element) {
    return baseParent.containsElement(element);
  }
  
  void update() {
    clip(pos.x, pos.y, size.x, size.y);
    super.update();
    baseParent.update();
    noClip();
  }
}
