// A MusicController contains all music control elements
class MusicController extends ChildElement implements ParentableElement {
  private ArrayList<ChildElement> controllerElements;
  
  MusicController() {
    controllerElements = new ArrayList<ChildElement>();
    addChildElement(new RectangleButton(new PVector(100.0, 100.0), new PVector(100.0, 100.0), color(0), "onTestButtonClicked"));
    addChildElement(new ShapeButton(loadShape("icons/playCircle.svg"), new PVector(100.0, 300.0), color(0), "onTestButtonClicked"));
    addChildElement(new Slider(new PVector(100.0, 400.0), new PVector(300.0, 10.0), color(255), color(70), 0.0, 0.0, 100.0));
  }
  
  void onTestButtonClicked() {
    println("Test button clicked");
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
