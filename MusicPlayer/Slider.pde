class Slider extends PositionedElement {
  private float currentValue, minValue, maxValue;
  private color progressCol, emptyCol;
  private float valuePercentage;
  private boolean dragging; // Drag state is stored so mouse can move off slider while adjusting
  
  Slider(PVector pos, PVector size, color progressCol, color emptyCol, float startingValue, float minValue, float maxValue) {
    super(pos, size);
    this.progressCol = progressCol;
    this.emptyCol = emptyCol;
    setMinValue(minValue);
    setMaxValue(maxValue);
    setCurrentValue(startingValue);
  }
  
  private void updateValuePercentage() {
    valuePercentage = map(currentValue, minValue, maxValue, 0.0, 1.0);
  }
  
  float getValuePercentage() {
    return valuePercentage;
  }
  
  float getCurrentValue() {
    return currentValue;
  }
  
  boolean isDragging() {
    return dragging;
  }
  
  void setCurrentValue(float currentValue) {
    this.currentValue = constrain(currentValue, minValue, maxValue);
    updateValuePercentage();
  }
  
  float getMinValue() {
    return minValue;
  }
  
  void setMinValue(float minValue) {
    if (minValue < maxValue) {
      this.minValue = minValue;
    }
  }
  
  float getMaxValue() {
    return maxValue;
  }
  
  void setMaxValue(float maxValue) {
    if (maxValue > minValue) {
      this.maxValue = maxValue;
    }
  }
  
  void onDragBegin() {
    dragging = true;
  }
  
  void doDragEvent() {
    float clickValue = map(mouseX, pos.x, pos.x + size.x, minValue, maxValue);
    setCurrentValue(clickValue);
  }
  
  void onDragEnd() {
    dragging = false;
  }
  
  void render() {
    pushStyle();
    fill(emptyCol);
    rect(pos.x, pos.y, size.x, size.y);
    fill(progressCol);
    float progressWidth = size.x * valuePercentage;
    rect(pos.x, pos.y, progressWidth, size.y);
    circle(pos.x + progressWidth, pos.y + size.y / 2.0, size.y * 1.5);
    popStyle();
  }
  
  void doInput() {
    if (isMouseHovering() && input.isMouseHeld(LEFT) && !dragging) {
      onDragBegin();
    }
    if (dragging) {
      doDragEvent();
    }
    if (input.isMouseReleased(LEFT) && dragging) {
      onDragEnd();
    }
  }
}
