// A Layout holds all interactable Elements and updates them when the Layout is being displayed
abstract class Layout extends BaseParentElement<ChildableElement> {
  Layout() {
    super();
  }
  
  protected void drawBackground() {
    background(currentStyle.white);
  }
  
  void update() {
    drawBackground();
    super.update();
  }
}
