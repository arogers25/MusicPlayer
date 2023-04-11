class ShapeButton extends Button {
  private PShape buttonShape;
  
  ShapeButton(String labelText, PShape buttonShape, PVector pos, PVector size, color col, String clickMethodName, Object... clickArgs) {
    super(labelText, pos, size, col, clickMethodName, clickArgs);
    this.buttonShape = buttonShape;
    buttonShape.disableStyle();
  }
  
  ShapeButton(PShape buttonShape, PVector pos, PVector size, color col, String clickMethodName, Object... clickArgs) {
    super(pos, size, col, clickMethodName, clickArgs);
    this.buttonShape = buttonShape;
    buttonShape.disableStyle();
  }
  
  //If the size of the shape does not need to be changed
  ShapeButton(String labelText, PShape buttonShape, PVector pos, color col, String clickMethodName) {
    this(labelText, buttonShape, pos, new PVector(buttonShape.width, buttonShape.height), col, clickMethodName);
  }
  
  ShapeButton(PShape buttonShape, PVector pos, color col, String clickMethodName) {
    this(buttonShape, pos, new PVector(buttonShape.width, buttonShape.height), col, clickMethodName);
  }
  
  PShape getShape() {
    return buttonShape;
  }
  
  void setShape(PShape buttonShape) {
    this.buttonShape = buttonShape;
  }
  
  void render() {
    pushStyle();
    fill(col);
    shape(buttonShape, pos.x, pos.y, size.x, size.y);
    popStyle();
  }
}
