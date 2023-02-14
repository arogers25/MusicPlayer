// A Layout holds all interactable Elements and updates them when the Layout is being displayed
// This should hold every Element's click event unless specified otherwise
abstract class Layout implements Element {
  private ArrayList<PositionedElement> childElements;
  
  Layout() {
    this.childElements = new ArrayList<PositionedElement>();
  }
  
  void update() {
    for (PositionedElement element : childElements) {
      element.update();
    }
  }
  
  void addChildElement(PositionedElement childElement) {
    childElement.setParentElement(this);
    childElements.add(childElement);
  }
  
  /*void doMousePressed() {
    input.doMousePressed();
  }
  
  void doMouseReleased() {
    input.doMouseReleased();
  }
  
  void doKeyPressed() {
    input.doMouseReleased();
  }
  
  void doKeyReleased() {
    input.doKeyReleased();
  }*/
}
