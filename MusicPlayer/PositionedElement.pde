abstract class PositionedElement extends ChildElement {
  protected PVector pos;
  protected PVector size;
  protected ParentableElement parentElement;
  
  PositionedElement(PVector pos, PVector size) {
    this.pos = pos;
    this.size = size;
  }
  
  final PVector getPos() {
    return pos;
  }
  
  final void setPos(PVector pos) {
    this.pos.set(pos);
  }
  
  final PVector getSize() {
    return size;
  }
  
  final void setSize(PVector size) {
    this.size.set(size);
  }
  
  final boolean isMouseHovering() {
    return mouseX >= pos.x && mouseX <= (pos.x + size.x) && mouseY >= pos.y && mouseY <= (pos.y + size.y);
  }
  
  abstract void render();
  
  abstract void doInput();
  
  void update() {
    render();
    doInput();
  }
}
