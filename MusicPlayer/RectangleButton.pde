class RectangleButton extends Button {
  private float labelTextSize = 32.0;
  
  RectangleButton(String label, PVector pos, PVector size, color col, String clickMethodName, Object... clickArgs) {
    super(label, pos, size, col, clickMethodName, clickArgs);
    adjustLabelSize();
  }
  
  RectangleButton(PVector pos, PVector size, color col, String clickMethodName, Object... clickArgs) {
    super(pos, size, col, clickMethodName, clickArgs);
    adjustLabelSize();
  }
  
  private void adjustLabelSize() {
    if (label.length() == 0) {
      return;
    }
    pushStyle();
    textSize(labelTextSize);
    while (textWidth(label) > (size.x * 0.90)) {
      textSize(labelTextSize--);
    }
    popStyle();
  }
  
  void render() {
    pushStyle();
    fill(col);
    rect(pos.x, pos.y, size.x, size.y);
    fill(255);
    textSize(labelTextSize);
    textAlign(CENTER, CENTER);
    text(label, pos.x + size.x / 2.0, pos.y + size.y / 2.0);
    popStyle();
  }
}
