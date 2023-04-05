class Label extends PositionedElement {
  private String displayText;
  private float adjustedTextSize;
  private PVector adjustedPos;
  private color col;
  private int alignX, alignY;

  Label(String displayText, PVector pos, PVector size, color col, int alignX, int alignY) {
    super(pos, size);
    this.displayText = displayText;
    this.col = col;
    adjustLabelSize();
    setAlignMode(alignX, alignY);
  }

  Label(String displayText, PVector pos, PVector size, color col) {
    super(pos, size);
    this.displayText = displayText;
    this.col = col;
    adjustLabelSize();
    setAlignMode(LEFT, BASELINE);
  }

  private void adjustLabelSize() {
    if (displayText.length() == 0) {
      return;
    }
    final float STARTING_SCALE_FACTOR = 0.60;
    final float SCALE_FIT_PERCENTAGE = 0.80;
    pushStyle();
    adjustedTextSize = size.y * STARTING_SCALE_FACTOR;
    textSize(adjustedTextSize);
    float currentTextWidth = textWidth(displayText);
    float targetTextWidth = size.x * SCALE_FIT_PERCENTAGE;
    if (currentTextWidth > targetTextWidth) {
      float targetWidthRatio = (targetTextWidth / currentTextWidth);
      adjustedTextSize = targetWidthRatio * adjustedTextSize;
      println(adjustedTextSize);
    }
    popStyle();
  }

  private void updateAdjustedPos() {
    adjustedPos = new PVector();
    adjustedPos.x = alignX == CENTER ? pos.x + size.x / 2.0 : pos.x;
    adjustedPos.y = alignY == CENTER ? pos.y + size.y / 2.0 : pos.y;
  }

  void setAlignMode(int alignX, int alignY) {
    this.alignX = alignX;
    this.alignY = alignY;
    updateAdjustedPos();
  }


  void render() {
    pushStyle();
    fill(col);
    textSize(adjustedTextSize);
    textAlign(alignX, alignY);
    updateAdjustedPos();
    text(displayText, adjustedPos.x, adjustedPos.y);
    popStyle();
  }

  void doInput() {
  }
}
