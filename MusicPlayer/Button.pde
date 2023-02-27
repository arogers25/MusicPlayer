abstract class Button extends PositionedElement {
  protected String label;
  protected color col;
  private String clickMethodName;
  private Method clickMethod; // The method to be activated on click
  
  Button(String label, PVector pos, PVector size, color col, String clickMethodName) {
    super(pos, size);
    this.label = label;
    this.col = col;
    this.clickMethodName = clickMethodName;
  }
  
  Button(PVector pos, PVector size, color col, String clickMethodName) {
    super(pos, size);
    this.col = col;
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
  
  color getColor() {
    return col;
  }
  
  void setCol(color col) {
    this.col = col;
  }
  
  void doInput() {
    if (isMouseHovering() && input.isMousePressed(LEFT) && clickMethod != null) {
      try {
        clickMethod.invoke(parentElement);
      } catch (Exception e) { // This should be handled better
        e.printStackTrace();
      }
    }
  }
}
