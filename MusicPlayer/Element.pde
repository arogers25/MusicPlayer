// Any object rendered on the screen is an Element
interface Element {
  void update();
}

// These interfaces and abstract classes are to ensure parent and child elements are held in a proper type

// Any ParentableElement can contain ChildableElements
// This should hold every ChildableElement's click event unless specified otherwise
interface ParentableElement<T extends ChildableElement> extends Element {
  void addElement(T element);
  boolean containsElement(T element);
}

// ParentableElement is given a default implementation so code like traversing the list of child elements does not have to be duplicated
class BaseParentElement<T extends ChildableElement> implements ParentableElement<T> {
  private ParentableElement parentRef;
  private ArrayList<T> childElements;
  
  BaseParentElement() {
    parentRef = this;
    childElements = new ArrayList<T>();
  }
  
  BaseParentElement(ParentableElement parentRef) {
    setParentRef(parentRef);
    childElements = new ArrayList<T>();
  }
  
  final ParentableElement getParentRef() {
    return parentRef;
  }
  
  // If an element extends AbstractChildElement and implements ParentableElement, it can have a BaseParentElement as a member so behaviour and methods can be shared
  final void setParentRef(ParentableElement parentRef) {
    if (parentRef != null) {
      this.parentRef = parentRef;
    } else {
      this.parentRef = this;
    }
  }
  
  final void addElement(T element) {
    if (!containsElement(element)) {
      element.setParent(parentRef);
      childElements.add(element);
    }
  }
  
  final boolean containsElement(T element) {
    return childElements.contains(element);
  }
  
  final ArrayList<T> getChildElements() {
    return childElements;
  }
  
  final void clearElements() {
    childElements.clear();
  }
  
  final T getElementAt(int index) {
    return childElements.get(index);
  }
  
  final int getElementsSize() {
    return childElements.size();
  }
  
  void update() {
    for (T element : childElements) {
      element.update();
    }
  }
}

// All ChildableElements are contained in a ParentableElement
interface ChildableElement extends Element {
  ParentableElement getParent();
  void setParent(ParentableElement element);
  Method getParentMethod(String name, Class... args);
}


abstract class AbstractChildElement implements ChildableElement {
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
  
  void invokeMethod(Method methodToInvoke, Object... invokeArgs) {
    if (methodToInvoke == null) {
      return;
    }
    try {
      methodToInvoke.invoke(parentElement, invokeArgs);
    } catch (Exception e) { // This should be handled better
      e.printStackTrace();
    }
  }
}
