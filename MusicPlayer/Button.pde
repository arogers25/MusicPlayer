abstract class Button extends PositionedElement {
  protected String label;
  protected color col;
  private String clickMethodName;
  private Method clickMethod; // The method to be activated on click
  private Object[] clickArgs; // The arguments that will be passed to the click method, may be empty
  
  Button(String label, PVector pos, PVector size, color col, String clickMethodName, Object... args) {
    super(pos, size);
    this.label = label;
    this.col = col;
    this.clickMethodName = clickMethodName;
    clickArgs = args;
  }
  
  Button(PVector pos, PVector size, color col, String clickMethodName, Object... args) {
    super(pos, size);
    this.col = col;
    this.clickMethodName = clickMethodName;
    clickArgs = args;
  }
  
  // getMethod() requires the classes of the arguments, so we get them automatically instead of having them be manually passed to the constructor
  protected Class[] getArgTypes() {
    Class[] argTypes = new Class[clickArgs.length];
    if (clickArgs.length > 0) {
      for (int i = 0; i < clickArgs.length; i++) {
        argTypes[i] = clickArgs[i].getClass();
      }
    }
    return argTypes;
  }
  
  void setParent(ParentableElement element) {
    super.setParent(element);
    if (parentElement != null) {
      Class[] argTypes = getArgTypes();
      clickMethod = getParentMethod(clickMethodName, argTypes);
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
        clickMethod.invoke(parentElement, clickArgs);
      } catch (Exception e) { // This should be handled better
        e.printStackTrace();
      }
    }
  }
}
