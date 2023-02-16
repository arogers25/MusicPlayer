// Input assigns states to each button (released, pressed, held) so Element input can be handled by objects every frame without Processing's input events
// Since all Processing sketches are already extended from PApplet, this causes conflicts with static fields. Instantiate Input as a "global" object instead

final class Input {
  private final int KEY_AMOUNT = 256;
  private final int MOUSE_BUTTON_AMOUNT = 4; 
  private final int RELEASED = 0, PRESSED = 1, HELD = 2;
  private int keyStates[];
  private int mouseStates[];
  
  Input() {
    keyStates = new int[KEY_AMOUNT];
    mouseStates = new int[MOUSE_BUTTON_AMOUNT];
  }
  
  // While currentKey can be more than 255, any key that needs to be used is below it
  private boolean isKeyValid(int currentKey) {
    return currentKey >= 0 && currentKey < KEY_AMOUNT;
  }
  
  // Takes Processing's current mouse button (LEFT = 37, CENTER = 3, RIGHT = 39) and maps them from 0-3 so they can be put in an array 
  private int getMouseIndex(int currentMouseButton) {
    final int BUTTON_OFFSET = 3;
    final int BUTTON_MOD = 5;
    return (currentMouseButton + BUTTON_OFFSET) % BUTTON_MOD;
  }
  
  // Checks to see if a key has been pressed for more than one frame and makes it held
  private void updateKeyStates() {
    for (int keyIndex = 0; keyIndex < KEY_AMOUNT; keyIndex++) {
      if (keyStates[keyIndex] == PRESSED) {
        keyStates[keyIndex] = HELD;
      }
    }
  }
  
  private void updateMouseStates() {
    for (int mouseIndex = 0; mouseIndex < MOUSE_BUTTON_AMOUNT; mouseIndex++) {
      if (mouseStates[mouseIndex] == PRESSED) {
        mouseStates[mouseIndex] = HELD;
      }
    }
  }
  
  void updateStates() {
    updateKeyStates();
    updateMouseStates();
  }
  
  boolean isMouseReleased(int currentMouseButton) {
    return mouseStates[getMouseIndex(currentMouseButton)] == RELEASED;
  }
  
  boolean isMousePressed(int currentMouseButton) {
    return mouseStates[getMouseIndex(currentMouseButton)] == PRESSED;
  }
  
  boolean isMouseHeld(int currentMouseButton) {
    return mouseStates[getMouseIndex(currentMouseButton)] == HELD;
  }
  
  boolean isKeyReleased(int currentKey) {
    if (isKeyValid(currentKey)) {
      return keyStates[currentKey] == RELEASED;
    }
    return false;
  }
  
  boolean isKeyPressed(int currentKey) {
    if (isKeyValid(currentKey)) {
      return keyStates[currentKey] == PRESSED;
    }
    return false;
  }
  
  boolean isKeyHeld(int currentKey) {
    if (isKeyValid(currentKey)) {
      return keyStates[currentKey] == HELD;
    }
    return false;
  }
  
  void doMousePressed() {
    mouseStates[getMouseIndex(mouseButton)] = PRESSED;
  }
  
  void doMouseReleased() {
   mouseStates[getMouseIndex(mouseButton)] = RELEASED;
  }
  
  void doKeyPressed() {
    if (isKeyValid(keyCode)) {
      keyStates[keyCode] = PRESSED;
    }
  }
  
  void doKeyReleased() {
    if (isKeyValid(keyCode)) {
      keyStates[keyCode] = RELEASED;
    }
  }
}
