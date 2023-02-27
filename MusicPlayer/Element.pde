// Any object rendered on the screen is an Element
interface Element {
  void update();
}

// These interfaces and abstract classes are to ensure parent and child elements are held in a proper type

// Any ParentableElement can contain ChildElements
// This should hold every ChildElement's click event unless specified otherwise
interface ParentableElement extends Element {
  void addChildElement(ChildElement childElement);
  boolean containsChildElement(ChildElement childElement);
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
  
  boolean containsChildElement(ChildElement childElement) {
    return childElements.contains(childElement);
  }
}

// All ChildElements are contained in a ParentElement
abstract class ChildElement implements Element {
  protected ParentableElement parentElement;

  ParentableElement getParentElement() {
    return parentElement;
  }

  void setParentElement(ParentableElement parentElement) {
    this.parentElement = parentElement;
  }
  
  Method getParentMethod(String name, Class... args) {
    if (parentElement == null) {
      return null;
    }
    Method parentMethod = null;
    try {
      parentMethod = parentElement.getClass().getMethod(name, args);
    } catch (NoSuchMethodException e) {
      println("Could not find method", name);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return parentMethod;
  }
}
