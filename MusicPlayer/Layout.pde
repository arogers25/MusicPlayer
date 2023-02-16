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

// The main page for all music player controls
class MainLayout extends Layout {
  MainLayout() {
    super();
    addChildElement(new Button(new PVector(100.0, 100.0), new PVector(100.0, 100.0)));
  }
}
