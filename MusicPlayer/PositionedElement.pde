abstract class PositionedElement extends AbstractChildElement {
  protected PVector pos;
  protected PVector size;
  
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
  
  final void setRefPos(PVector pos) {
    this.pos = pos;
  }
  
  final PVector getSize() {
    return size;
  }
  
  final void setSize(PVector size) {
    this.size.set(size);
  }
  
  final void setRefSize(PVector size) {
    this.size = size;
  }
  
  final boolean isMouseHovering(PVector otherPos, PVector otherSize) {
    return mouseX >= otherPos.x && mouseX <= (otherPos.x + otherSize.x) && mouseY >= otherPos.y && mouseY <= (otherPos.y + otherSize.y);
  }
  
  final boolean isMouseHovering() {
    return isMouseHovering(pos, size);
  }
  
  abstract void render();
  
  abstract void doInput();
  
  void update() {
    render();
    doInput();
  }
}
