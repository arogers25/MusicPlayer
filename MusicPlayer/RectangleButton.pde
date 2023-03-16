class RectangleButton extends Button {
  Label label;
  
  RectangleButton(String labelText, PVector pos, PVector size, color col, color textCol, String clickMethodName, Object... clickArgs) {
    super(labelText, pos, size, col, clickMethodName, clickArgs);
    this.label = new Label(labelText, pos, size, textCol, CENTER, CENTER);
    
  }
  
  RectangleButton(PVector pos, PVector size, color col, String clickMethodName, Object... clickArgs) {
    super(pos, size, col, clickMethodName, clickArgs);
  }
  
  void render() {
    pushStyle();
    fill(col);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
    if (label != null) {
      label.render();
    }
  }
}
