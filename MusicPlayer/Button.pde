class Button extends PositionedElement {
  private String label;
  
  Button(String label, PVector pos, PVector size) {
    super(pos, size);
    this.label = label;
  }
  
  Button(PVector pos, PVector size) {
    super(pos, size);
  }
  
  void render() {
    pushStyle();
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
  }
}
