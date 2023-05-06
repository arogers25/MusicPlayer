// For draw() see AppEngine.pde

void setup() {
  fullScreen();
  setupAppEngine();
  Music.createMinim(this);
  setCurrentLayout(new PlayListLayout());
}
