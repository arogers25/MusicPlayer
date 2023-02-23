// A MusicController contains all music control elements
class MusicController extends ChildElement implements ParentableElement {
  private ArrayList<ChildElement> controllerElements;
  
  MusicController() {
    controllerElements = new ArrayList<ChildElement>();
    addChildElement(new Slider(new PVector(100.0, 400.0), new PVector(300.0, 10.0), color(255), color(70), 0.0, 0.0, 100.0));
  }
  
  void addChildElement(ChildElement childElement) {
    childElement.setParentElement(this);
    controllerElements.add(childElement);
  }
  
  boolean containsChildElement(ChildElement childElement) {
    return controllerElements.contains(childElement);
  }
  
  void update() {
    for (ChildElement element : controllerElements) {
      element.update();
    }
  }
}
