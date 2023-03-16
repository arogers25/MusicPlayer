// A MusicController contains all music control elements
class MusicController extends AbstractChildElement implements ParentableElement<PositionedElement> {
  private BaseParentElement<PositionedElement> baseParent;
  private ShapeButton playPauseButton;
  private PlaybackSlider progressBar;
  private PShape playShape, pauseShape, skipNextShape, skipPreviousShape;
  
  MusicController() {
    super();
    baseParent = new BaseParentElement(this);
    playShape = loadShape("icons/playCircle.svg");
    pauseShape = loadShape("icons/pauseCircle.svg");
    skipNextShape = loadShape("icons/skipNext.svg");
    skipPreviousShape = loadShape("icons/skipPrevious.svg");
    createPlayPauseButton();
    createProgressBar();
    createSkipButtons();
    addPlaylistButtons();
  }
  
  private void createProgressBar() {
    PVector progressBarSize = new PVector(width * (5.0 / 6.0), height * (1.0/70.0));
    PVector progressBarPos = new PVector((width - progressBarSize.x) / 2.0, height * (5.0 / 6.0));
    progressBar = new PlaybackSlider(progressBarPos, progressBarSize, color(255), color(70), null);
    addElement(progressBar);
  }
  
  private void createPlayPauseButton() {
    float playPauseSize = width * (1.0 / 14.0);
    PVector playPausePos = new PVector((width / 2.0) - (playPauseSize / 2.0), height * (6.0 / 7.0));
    playPauseButton = new ShapeButton(pauseShape, playPausePos, new PVector(playPauseSize, playPauseSize), color(0), "onPlayPauseButtonClicked");
    addElement(playPauseButton);
  }
  
  private void createSkipButtons() {
    float skipButtonSize = width * (1.0 / 14.0);
    PVector buttonAlignPos = new PVector((width / 2.0) - (skipButtonSize / 2.0), height * (6.0 / 7.0));
    float buttonOffsetX = width / 6.0;
    addElement(new ShapeButton(skipPreviousShape, new PVector(buttonAlignPos.x - buttonOffsetX, buttonAlignPos.y), new PVector(skipButtonSize, skipButtonSize), color(0), "onPlayPauseButtonClicked"));
    addElement(new ShapeButton(skipNextShape, new PVector(buttonAlignPos.x + buttonOffsetX, buttonAlignPos.y), new PVector(skipButtonSize, skipButtonSize), color(0), "onPlayPauseButtonClicked"));
  }
  
  private void addPlaylistButtons() {
    File songsDirectory = new File(sketchPath() + "/data/songs");
    File[] songFiles = songsDirectory.listFiles();
    PVector songButtonSize = new PVector(width * 0.07, height * 0.05);
    for (int i = 0; i < songFiles.length; i++) {
      String songFileName = songFiles[i].getName();
      PVector songButtonPos = new PVector(width * 0.07, height * 0.07 + i * height * 0.05);
      addElement(new RectangleButton(songFileName, songButtonPos, songButtonSize, color(30), "setSong", songFileName));
    }
  }
  
  void setSong(String songName) {
    music.setCurrentSong(songName);
  }
  
  void updatePlayPauseShape() {
    playPauseButton.setShape(music.isPlaying() ? pauseShape : playShape);
  }
  
  void onPlayPauseButtonClicked() {
    music.togglePlaying();
    updatePlayPauseShape();
  }
  
  void addElement(PositionedElement element) {
    baseParent.addElement(element);
  }
  
  boolean containsElement(PositionedElement element) {
    return baseParent.containsElement(element);
  }
  
  void onMusicUpdate() {
    updatePlayPauseShape();
    progressBar.setControlledSong(music.getCurrentSong());
    music.setUpdated(false);
  }
  
  void update() {
    if (music.wasUpdated()) {
      onMusicUpdate();
    }
    baseParent.update();
  }
}
