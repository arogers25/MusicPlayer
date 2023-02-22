class ShapeButton extends Button {
  private PShape buttonShape;
  
  ShapeButton(String label, PShape buttonShape, PVector pos, color col, String clickMethodName) {
    super(label, pos, new PVector(buttonShape.width, buttonShape.height), col, clickMethodName);
    this.buttonShape = buttonShape;
  }
  
  ShapeButton(PShape buttonShape, PVector pos, color col, String clickMethodName) {
    super(pos, new PVector(buttonShape.width, buttonShape.height), col, clickMethodName);
    this.buttonShape = buttonShape;
  }
  
  void render() {
    pushStyle();
    fill(col);
    shape(buttonShape, pos.x, pos.y);
    popStyle();
  }
}
