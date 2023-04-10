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
  private float visibleItems, totalItemHeight, scrollArea;
  private PVector itemSize;
  private PVector scrollPos, scrollBarPos, scrollBarSize;
  private Class[] argTypes;
  private String clickMethodName;
  private Method itemClickMethod;
  private ListItem selectedItem;
  private boolean canScroll, isScrolling;
  
  ListBox(PVector pos, PVector size, float visibleItems, String clickMethodName, Class... argTypes) {
    super(pos, size);
    scrollBarSize = new PVector(size.x * 0.10, size.y);
    scrollBarPos = new PVector(pos.x + size.x - scrollBarSize.x, pos.y);
    baseParent = new BaseParentElement(this);
    this.visibleItems = visibleItems == 0 ? 1 : visibleItems;
    itemSize = new PVector(size.x - scrollBarSize.x, size.y / this.visibleItems);
    scrollPos = new PVector();
    this.clickMethodName = clickMethodName;
    this.argTypes = argTypes;
  }
  
  void setParent(ParentableElement element) {
    super.setParent(element);
    if (element != null) {
      itemClickMethod = getParentMethod(clickMethodName, argTypes);
    }
  }
  
  void addElement(ListItem element) {
    baseParent.addElement(element);
  }
  
  void setSelectedItem(Integer itemIndex) {
    ListItem newSelectedItem = baseParent.getElementAt(itemIndex);
    setSelectedItem(newSelectedItem);
  }
  
  void setSelectedItem(ListItem selectedItem) {
    if (this.selectedItem != null) {
      this.selectedItem.setCol(color(30));
    }
    if (selectedItem != null) {
      selectedItem.setCol(color(0, 150, 255));
    }
    this.selectedItem = selectedItem;
  }
  
  void onItemSelected(Integer itemIndex, Object[] clickArgs) {
    setSelectedItem(itemIndex);
    invokeMethod(itemClickMethod, clickArgs);
  }
  
  void updateScrollArea() {
    totalItemHeight = baseParent.getElementsSize() * itemSize.y;
    scrollArea = (size.y / totalItemHeight) * size.y;
    scrollBarSize.y = size.y - scrollArea;
    canScroll = (totalItemHeight > size.y);
    scrollBarSize.x = canScroll ? size.x * 0.10 : 0;
    itemSize.x = size.x - scrollBarSize.x;
  }
  
  void addItem(String labelText, Object... clickArgs) {
    PVector adjustedPos = new PVector(pos.x, pos.y + totalItemHeight);
    ListItem itemToAdd = new ListItem(labelText, adjustedPos, scrollPos, itemSize, color(30), color(255), "onItemSelected", baseParent.getElementsSize(), clickArgs);
    itemToAdd.setVisibleBounds(pos.y, pos.y + size.y);
    addElement(itemToAdd);
    updateScrollArea();
  }
  
  boolean containsElement(ListItem element) {
    return baseParent.containsElement(element);
  }
  
  void renderScrollBar() {
    pushStyle();
    fill(100);
    rect(scrollBarPos.x, scrollBarPos.y, scrollBarSize.x, scrollBarSize.y);
    popStyle();
  }
  
  void render() {
    pushStyle();
    fill(30);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
    if (canScroll) {
      renderScrollBar();
    }
    //scrollPos.set(0, mouseY - pos.y);
  }
  
  void doScrollBarInput() {
    float scrollProg = (mouseY - pos.y) / (scrollBarSize.y);
    scrollBarPos.y += mouseY - pmouseY;
    float maxScrollPos = pos.y + size.y - scrollBarSize.y;
    scrollBarPos.y = constrain(scrollBarPos.y, pos.y, maxScrollPos);
    scrollPos.y = -map(scrollBarPos.y, pos.y, maxScrollPos, 0, totalItemHeight - size.y);
  }
  
  void doInput() {
    if (!isMouseHovering() && !isScrolling || !canScroll) {
      return;
    }
    if (!isScrolling) {
      isScrolling = isMouseHovering(scrollBarPos, scrollBarSize) && Input.isMouseHeld(LEFT);
    } else {
      isScrolling = Input.isMouseHeld(LEFT);
      doScrollBarInput();
    }
  }
  
  void update() {
    clip(pos.x, pos.y, size.x, size.y);
    super.update();
    baseParent.update();
    noClip();
  }
}
