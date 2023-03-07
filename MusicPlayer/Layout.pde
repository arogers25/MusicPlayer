// A Layout holds all interactable Elements and updates them when the Layout is being displayed
abstract class Layout implements ParentableElement<ChildElement> {
  private ArrayList<ChildElement> childElements;
  
  Layout() {
    childElements = new ArrayList<ChildElement>();
  }
  
  void addElement(ChildElement element) {
    if (!containsElement(element)) {
      element.setParent(this);
      childElements.add(element);
    }
  }
  
  boolean containsElement(ChildElement element) {
    return childElements.contains(element);
  }
  
  void update() {
    for (ChildElement element : childElements) {
      element.update();
    }
  }
}

// The main page for all music player controls
class MainLayout extends Layout {
  MainLayout() {
    super();
    addElement(new MusicController());
  }
}
