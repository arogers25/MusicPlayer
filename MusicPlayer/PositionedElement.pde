abstract class PositionedElement extends ChildElement {
  protected PVector pos;
  protected PVector size;
  protected ParentableElement parentElement;
  
  PositionedElement(PVector pos, PVector size) {
    this.pos = pos;
    this.size = size;
  }
  
  PVector getPos() {
    return pos;
  }
  
  void setPos(PVector pos) {
    this.pos.set(pos);
  }
  
  PVector getSize() {
    return size;
  }
  
  void setSize(PVector size) {
    this.size.set(size);
  }
  
  boolean isMouseHovering() {
    return mouseX >= pos.x && mouseX <= (pos.x + size.x) && mouseY >= pos.y && mouseY <= (pos.y + size.y);
  }
  
  abstract void render();
  
  abstract void doInput();
  
  void update() {
    render();
    doInput();
  }
}
