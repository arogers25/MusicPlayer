import processing.core.*;

final class Input {
  private static final int KEY_AMOUNT = 256;
  private static final int MOUSE_BUTTON_AMOUNT = 4; 
  private static final int RELEASED = 0, PRESSED = 1, HELD = 2;
  private static int keyStates[];
  private static int mouseStates[];
  private static PApplet appInst;
  
  static {
    keyStates = new int[KEY_AMOUNT];
    mouseStates = new int[MOUSE_BUTTON_AMOUNT];
  }
  
  public static void setAppInst(PApplet newAppInst) {
    appInst = newAppInst;
  }
  
  // While currentKey can be more than 255, any key that needs to be used is below it
  private static boolean isKeyValid(int currentKey) {
    return currentKey >= 0 && currentKey < KEY_AMOUNT;
  }
  
  // Takes Processing's current mouse button (LEFT = 37, CENTER = 3, RIGHT = 39) and maps them from 0-3 so they can be put in an array 
  private static int getMouseIndex(int currentMouseButton) {
    final int BUTTON_OFFSET = 3;
    final int BUTTON_MOD = 5;
    return (currentMouseButton + BUTTON_OFFSET) % BUTTON_MOD;
  }
  
  // Checks to see if a key has been pressed for more than one frame and makes it held
  private static void updateKeyStates() {
    for (int keyIndex = 0; keyIndex < KEY_AMOUNT; keyIndex++) {
      if (keyStates[keyIndex] == PRESSED) {
        keyStates[keyIndex] = HELD;
      }
    }
  }
  
  private static void updateMouseStates() {
    for (int mouseIndex = 0; mouseIndex < MOUSE_BUTTON_AMOUNT; mouseIndex++) {
      if (mouseStates[mouseIndex] == PRESSED) {
        mouseStates[mouseIndex] = HELD;
      }
    }
  }
  
  // States should be updated after all elements have been updated, or at the end of the sketch's draw() loop
  public static void updateStates() {
    updateKeyStates();
    updateMouseStates();
  }
  
  public static boolean isMouseReleased(int currentMouseButton) {
    return mouseStates[getMouseIndex(currentMouseButton)] == RELEASED;
  }
  
  public static boolean isMousePressed(int currentMouseButton) {
    return mouseStates[getMouseIndex(currentMouseButton)] == PRESSED;
  }
  
  public static boolean isMouseHeld(int currentMouseButton) {
    return mouseStates[getMouseIndex(currentMouseButton)] == HELD;
  }
  
  public static boolean isKeyReleased(int currentKey) {
    if (isKeyValid(currentKey)) {
      return keyStates[currentKey] == RELEASED;
    }
    return false;
  }
  
  public static boolean isKeyPressed(int currentKey) {
    if (isKeyValid(currentKey)) {
      return keyStates[currentKey] == PRESSED;
    }
    return false;
  }
  
  public static boolean isKeyHeld(int currentKey) {
    if (isKeyValid(currentKey)) {
      return keyStates[currentKey] == HELD;
    }
    return false;
  }
  
  public static void doMousePressed() {
    mouseStates[getMouseIndex(appInst.mouseButton)] = PRESSED;
  }
  
  public static void doMouseReleased() {
   mouseStates[getMouseIndex(appInst.mouseButton)] = RELEASED;
  }
  
  public static void doKeyPressed() {
    if (isKeyValid(appInst.keyCode)) {
      keyStates[appInst.keyCode] = PRESSED;
    }
  }
  
  public static void doKeyReleased() {
    if (isKeyValid(appInst.keyCode)) {
      keyStates[appInst.keyCode] = RELEASED;
    }
  }
}
