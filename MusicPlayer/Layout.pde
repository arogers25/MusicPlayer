// A Layout holds all interactable Elements and updates them when the Layout is being displayed
// This should hold every Element's click event unless specified otherwise
abstract class Layout implements Element {
  private ArrayList<PositionedElement> elements;
  private Input input;
  
  Layout(Input input) {
    this.elements = new ArrayList<PositionedElement>();
    this.input = input;
  }
  
  void update() {
    for (PositionedElement element : elements) {
      element.update();
    }
  }
  
  Input getInput() {
    return input;
  }
  
  void doMousePressed() {
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
  }
}
