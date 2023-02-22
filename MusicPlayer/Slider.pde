class Slider extends PositionedElement {
  private float currentValue, minValue, maxValue;
  private color progressCol, emptyCol;
  private float valuePercentage;
  
  Slider(PVector pos, PVector size, color progressCol, color emptyCol, float startingValue, float minValue, float maxValue) {
    super(pos, size);
    this.progressCol = progressCol;
    this.emptyCol = emptyCol;
    currentValue = startingValue;
    this.minValue = minValue;
    this.maxValue = maxValue;
    updateValuePercentage();
  }
  
  private void updateValuePercentage() {
    valuePercentage = currentValue / maxValue;
  }
  
  float getValuePercentage() {
    return valuePercentage;
  }
  
  float getCurrentValue() {
    return currentValue;
  }
  
  void setCurrentValue(float currentValue) {
    this.currentValue = currentValue;
  }
  
  float getMinValue() {
    return minValue;
  }
  
  void setMinValue(float minValue) {
    this.minValue = minValue;
  }
  
  float getMaxValue() {
    return maxValue;
  }
  
  void setMaxValue(float maxValue) {
    this.maxValue = maxValue;
  }
  
  void render() {
    pushStyle();
    fill(emptyCol);
    rect(pos.x, pos.y, size.x, size.y);
    fill(progressCol);
    float progressWidth = size.x * valuePercentage;
    rect(pos.x, pos.y, progressWidth, size.y);
    popStyle();
  }
  
  void doInput() {
    if (isMouseHovering() && input.isMouseHeld(LEFT)) {
      currentValue = map(mouseX - pos.x, pos.x, size.x, minValue, maxValue);
      currentValue = constrain(currentValue, minValue, maxValue);
      updateValuePercentage();
    }
  }
}
