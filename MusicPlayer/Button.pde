class Button extends PositionedElement {
  private String label;
  private String clickMethodName;
  private Method clickMethod; // The method to be activated on click
  
  Button(String label, PVector pos, PVector size, String clickMethodName) {
    super(pos, size);
    this.label = label;
    this.clickMethodName = clickMethodName;
  }
  
  Button(PVector pos, PVector size, String clickMethodName) {
    super(pos, size);
    this.clickMethodName = clickMethodName;
  }
  
  void setParentElement(ParentableElement parentElement) {
    super.setParentElement(parentElement);
    if (parentElement != null) {
      clickMethod = getParentMethod(clickMethodName);
    }
  }
  
  String getLabel() {
    return label;
  }
  
  void setLabel(String label) {
    this.label = label;
  }
  
  void render() {
    pushStyle();
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
    if (isMouseHovering() && input.isMousePressed(LEFT) && clickMethod != null) {
      try {
        clickMethod.invoke(parentElement);
      } catch (Exception e) { // This should be handled better
        println(e);
      }
    }
  }
}
