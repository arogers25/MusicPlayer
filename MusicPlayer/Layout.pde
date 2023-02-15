// A Layout holds all interactable Elements and updates them when the Layout is being displayed
abstract class Layout extends BaseParentElement {
  
  Layout() {
    super();
  }
  
  void update() {
    for (ChildElement element : childElements) {
      element.update();
    }
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
