class Button extends PositionedElement {
  private String label;
  
  Button(String label, PVector pos, PVector size) {
    super(pos, size);
    this.label = label;
  }
  
  Button(PVector pos, PVector size) {
    super(pos, size);
  }
  
  String getLabel() {
    return label;
  }
  
  void setLabel(String label) {
    this.label = label;
  }
  
  void render() {
    pushStyle();
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
  }
}
