// For draw() see AppEngine.pde

void settings() {
  final float sizeScale = (3.0 / 4.0);
  size((int)(displayWidth * sizeScale), (int)(displayHeight * sizeScale));
}

void setup() {
  setupAppEngine();
  Music.createMinim(this);
  setCurrentLayout(new PlayListLayout());
}
