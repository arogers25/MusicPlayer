// A SongController contains all individual song control elements
class SongController extends AbstractChildElement implements ParentableElement<PositionedElement> {
  private BaseParentElement<PositionedElement> baseParent;
  private ShapeButton playPauseButton;
  private PlaybackSlider progressBar;
  private PShape playShape, pauseShape, skipNextShape, skipPreviousShape;
  private Label titleLabel;
  
  SongController() {
    super();
    baseParent = new BaseParentElement(this);
    playShape = loadShape("icons/playCircle.svg");
    pauseShape = loadShape("icons/pauseCircle.svg");
    skipNextShape = loadShape("icons/skipNext.svg");
    skipPreviousShape = loadShape("icons/skipPrevious.svg");
    createPlayPauseButton();
    createProgressBar();
    createSkipButtons();
    createTitleLabel();
    onMusicUpdate();
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
    updatePlayPauseShape();
    addElement(playPauseButton);
  }
  
  private void createSkipButtons() {
    float skipButtonSize = width * (1.0 / 14.0);
    PVector buttonAlignPos = new PVector((width / 2.0) - (skipButtonSize / 2.0), height * (6.0 / 7.0));
    float buttonOffsetX = width / 6.0;
    addElement(new ShapeButton(skipPreviousShape, new PVector(buttonAlignPos.x - buttonOffsetX, buttonAlignPos.y), new PVector(skipButtonSize, skipButtonSize), color(0), "onSkipButtonClicked", -1));
    addElement(new ShapeButton(skipNextShape, new PVector(buttonAlignPos.x + buttonOffsetX, buttonAlignPos.y), new PVector(skipButtonSize, skipButtonSize), color(0), "onSkipButtonClicked", 1));
  }
  
  private void createTitleLabel() {
    PVector labelSize = new PVector(width * (5.0 / 6.0), height * 0.07);
    PVector labelPos = new PVector((width - labelSize.x) / 2.0, height * (4.9 / 6.0));
    titleLabel = new Label("", labelPos, labelSize, color(0), LEFT, BASELINE);
    addElement(titleLabel);
  }
  
  void updatePlayPauseShape() {
    playPauseButton.setShape(Music.isPlaying() ? pauseShape : playShape);
  }
  
  void onPlayPauseButtonClicked() {
    Music.togglePlaying();
    updatePlayPauseShape();
  }
  
  void onSkipButtonClicked(Integer adjust) {
    Music.skipToIndexedSong(adjust);
  }
  
  private boolean hasSongEnded() {
    if (Music.getCurrentSong() == null || !Music.isPlaying()) {
      return false;
    }
    return (!progressBar.isDragging()) && (progressBar.getCurrentValue() == progressBar.getMaxValue());
  }
  
  void updateLabels() {
    if (Music.getCurrentSong() != null) {
      AudioMetaData songData = Music.getCurrentSong().getMetaData();
      titleLabel.setDisplayText(songData.author() + " - " + songData.title());
    } else {
      titleLabel.setDisplayText("No Song Playing");
    }
  }
  
  void onMusicUpdate() {
    updatePlayPauseShape();
    progressBar.setControlledSong(Music.getCurrentSong());
    updateLabels();
  }
  
  void addElement(PositionedElement element) {
    baseParent.addElement(element);
  }
  
  boolean containsElement(PositionedElement element) {
    return baseParent.containsElement(element);
  }
  
  void update() {
    baseParent.update();
    if (hasSongEnded()) {
      Music.skipToIndexedSong(1);
      Music.setPlaying(true); // In some cases, the next song will not play automatically because Minim itself considers the song "ended" and the state is incorrectly transferred
    }
    if (Music.wasUpdated()) {
      onMusicUpdate();
    }
  }
}
