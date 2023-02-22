class RectangleButton extends Button {
  
  RectangleButton(String label, PVector pos, PVector size, color col, String clickMethodName) {
    super(label, pos, size, col, clickMethodName);
  }
  
  RectangleButton(PVector pos, PVector size, color col, String clickMethodName) {
    super(pos, size, col, clickMethodName);
  }
  
  void render() {
    pushStyle();
    fill(col);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
}
