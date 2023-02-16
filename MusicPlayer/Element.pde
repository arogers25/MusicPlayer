// Any object rendered on the screen is an Element
interface Element {
  void update();
}

// These interfaces and abstract classes are to ensure parent and child elements are held in a proper type

// Any ParentableElement can contain ChildElements
// This should hold every ChildElement's click event unless specified otherwise
interface ParentableElement extends Element {
  void addChildElement(ChildElement childElement);
  boolean containsChildElement();
}

// BaseParentElements are for parent elements that cannot also be made ChildElements
abstract class BaseParentElement implements ParentableElement {
  protected ArrayList<ChildElement> childElements;

  BaseParentElement() {
    childElements = new ArrayList<ChildElement>();
  }

  void addChildElement(ChildElement childElement) {
    childElement.setParentElement(this);
    childElements.add(childElement);
  }
}

// All ChildElements are contained in a ParentElement
abstract class ChildElement implements Element {
  private ParentableElement parentElement;

  ParentableElement getParentElement() {
    return parentElement;
  }

  void setParentElement(ParentableElement parentElement) {
    this.parentElement = parentElement;
  }
}
