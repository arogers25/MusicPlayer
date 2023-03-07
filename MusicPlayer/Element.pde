// Any object rendered on the screen is an Element
interface Element {
  void update();
}

// These interfaces and abstract classes are to ensure parent and child elements are held in a proper type

// Any ParentableElement can contain ChildElements
// This should hold every ChildElement's click event unless specified otherwise
interface ParentableElement<T extends ChildElement> extends Element {
  void addElement(T element);
  boolean containsElement(T element);
}

// All ChildElements are contained in a ParentElement
abstract class ChildElement implements Element {
  protected ParentableElement parentElement;

  ParentableElement getParent() {
    return parentElement;
  }

  void setParent(ParentableElement element) {
    parentElement = element;
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
