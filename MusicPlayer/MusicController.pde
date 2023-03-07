// A MusicController contains all music control elements
class MusicController extends ChildElement implements ParentableElement<PositionedElement> {
  private ArrayList<PositionedElement> controllerElements;
  private ShapeButton playPauseButton;
  private Slider progressBar;
  private boolean paused = false;
  private PShape playShape, pauseShape, skipNextShape, skipPreviousShape;
  
  MusicController() {
    controllerElements = new ArrayList<PositionedElement>();
    playShape = loadShape("icons/playCircle.svg");
    pauseShape = loadShape("icons/pauseCircle.svg");
    skipNextShape = loadShape("icons/skipNext.svg");
    skipPreviousShape = loadShape("icons/skipPrevious.svg");
    createPlayPauseButton();
    createProgressBar();
    createSkipButtons();
  }
  
  private void createProgressBar() {
    PVector progressBarSize = new PVector(width * (5.0 / 6.0), height * (1.0/70.0));
    PVector progressBarPos = new PVector((width - progressBarSize.x) / 2.0, height * (5.0 / 6.0));
    progressBar = new Slider(progressBarPos, progressBarSize, color(255), color(70), 0.0, 0.0, 100.0);
    addElement(progressBar);
  }
  
  private void createPlayPauseButton() {
    float playPauseSize = width * (1.0 / 14.0);
    PVector playPausePos = new PVector((width / 2.0) - (playPauseSize / 2.0), height * (6.0 / 7.0));
    playPauseButton = new ShapeButton(pauseShape, playPausePos, new PVector(playPauseSize, playPauseSize), color(0), "onTestButtonClicked");
    addElement(playPauseButton);
  }
  
  private void createSkipButtons() {
    float skipButtonSize = width * (1.0 / 14.0);
    PVector buttonAlignPos = new PVector((width / 2.0) - (skipButtonSize / 2.0), height * (6.0 / 7.0));
    float buttonOffsetX = width / 6.0;
    addElement(new ShapeButton(skipPreviousShape, new PVector(buttonAlignPos.x - buttonOffsetX, buttonAlignPos.y), new PVector(skipButtonSize, skipButtonSize), color(0), "onTestButtonClicked"));
    addElement(new ShapeButton(skipNextShape, new PVector(buttonAlignPos.x + buttonOffsetX, buttonAlignPos.y), new PVector(skipButtonSize, skipButtonSize), color(0), "onTestButtonClicked"));
  }
  
  void onTestButtonClicked() {
    paused = !paused;
    playPauseButton.setShape(paused ? playShape : pauseShape);
  }
  
  void addElement(PositionedElement element) {
    if (!containsElement(element)) {
      element.setParent(this);
      controllerElements.add(element);
    }
  }
  
  boolean containsElement(PositionedElement element) {
    return controllerElements.contains(element);
  }
  
  void update() {
    for (ChildElement element : controllerElements) {
      element.update();
    }
  }
}
