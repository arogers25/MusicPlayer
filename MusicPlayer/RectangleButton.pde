class RectangleButton extends Button {
  RectangleButton(String label, PVector pos, PVector size, color col, String clickMethodName, Object... clickArgs) {
    super(label, pos, size, col, clickMethodName, clickArgs);
  }
  
  RectangleButton(PVector pos, PVector size, color col, String clickMethodName, Object... clickArgs) {
    super(pos, size, col, clickMethodName, clickArgs);
  }
  
  void render() {
    pushStyle();
    fill(col);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
}
