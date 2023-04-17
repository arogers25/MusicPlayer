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
  private float visibleItems, totalItemHeight;
  private PVector itemSize;
  private PVector scrollPos;
  private PositionedElement scrollBar;
  private Class[] argTypes;
  private String clickMethodName;
  private Method itemClickMethod;
  private ListItem selectedItem;
  private boolean isScrolling;
  
  ListBox(PVector pos, PVector size, float visibleItems, String clickMethodName, Class... argTypes) {
    super(pos, size);
    baseParent = new BaseParentElement(this);
    this.visibleItems = visibleItems == 0 ? 1 : visibleItems;
    itemSize = new PVector(size.x, size.y / this.visibleItems);
    scrollPos = new PVector();
    this.clickMethodName = clickMethodName;
    this.argTypes = argTypes;
    createScrollBar();
  }
  
  private void createScrollBar() {
    PVector scrollBarSize = new PVector(size.x * 0.10, size.y);
    PVector scrollBarPos = new PVector(pos.x + size.x - scrollBarSize.x, pos.y);
    float minScrollY = pos.y;
    float maxScrollY = pos.y + size.y;    
    scrollBar = new PositionedElement(scrollBarPos, scrollBarSize) {
      void render() {
        pushStyle();
        fill(100);
        rect(pos.x, pos.y, size.x, size.y);
        popStyle();
      }
      
      private void doScroll() {
        scrollBarPos.y += mouseY - pmouseY;
        float maxScrollPos = maxScrollY - size.y;
        pos.y = constrain(pos.y, minScrollY, maxScrollPos);
        scrollPos.y = -map(pos.y, minScrollY, maxScrollPos, 0, totalItemHeight - (maxScrollY - minScrollY));
      }
      
      void doInput() {
        if (isScrolling) {
          isScrolling = Input.isMouseHeld(LEFT);
          doScroll();
        } else {
          isScrolling = isMouseHovering() && Input.isMousePressed(LEFT);
        }
      }
    };
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
    float scrollArea = (size.y / totalItemHeight) * size.y;
    boolean canScroll = (totalItemHeight > size.y);
    scrollBar.setSize(new PVector(canScroll ? size.x * 0.10 : 0.0, (scrollArea / totalItemHeight) * size.y));
    itemSize.x = size.x - scrollBar.getSize().x;
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
  
  void render() {
    pushStyle();
    fill(30);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
  }
  
  void update() {
    clip(pos.x, pos.y, size.x + 1, size.y + 1);
    super.update();
    scrollBar.update();
    baseParent.update();
    noClip();
  }
}
