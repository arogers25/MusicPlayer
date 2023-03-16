abstract class Button extends PositionedElement {
  protected String labelText;
  protected color col;
  private String clickMethodName;
  private Method clickMethod; // The method to be activated on click
  private Object[] clickArgs; // The arguments that will be passed to the click method, may be empty
  
  Button(String labelText, PVector pos, PVector size, color col, String clickMethodName, Object... args) {
    super(pos, size);
    this.labelText = labelText;
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
  
  String getlabelText() {
    return labelText;
  }
  
  void setlabelText(String labelText) {
    this.labelText = labelText;
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
