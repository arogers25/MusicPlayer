// Input assigns states to each button (released, pressed, held) so Element input can be handled by objects every frame without Processing's input events
// Since all Processing sketches are already extended from PApplet, this causes conflicts with static fields. Instantiate Input as a "global" object instead

final class Input {
  private final int KEY_AMOUNT = 256;
  private final int RELEASED = 0, PRESSED = 1, HELD = 2;
  private int keyStates[];
  
  Input() {
    keyStates = new int[KEY_AMOUNT];
  }
  
  boolean isKeyValid(int currentKey) {
    return currentKey >= 0 && currentKey < KEY_AMOUNT;
  }
  
  // Checks to see if a key has been pressed for more than one frame and makes it held
  void updateKeyStates() {
    for (int keyIndex = 0; keyIndex < KEY_AMOUNT; keyIndex++) {
      if (keyStates[keyIndex] == PRESSED) {
        keyStates[keyIndex] = HELD;
      }
    }
  }
  
  void doMousePressed() {
  }
  
  void doMouseReleased() {
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
