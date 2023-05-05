// A SongController contains all individual song control elements
class SongController extends AbstractChildElement implements ParentableElement<PositionedElement> {
  private BaseParentElement<PositionedElement> baseParent;
  private ShapeButton playPauseButton, repeatSongButton, shuffleButton;
  private PlaybackSlider progressBar;
  private Label titleLabel;
  
  SongController() {
    super();
    baseParent = new BaseParentElement(this);
    createProgressBar();
    createControlElements();
    createTitleLabel();
    onMusicUpdate();
  }
  
  private PVector getCenteredButtonPos(PVector pos, PVector size) {
    return new PVector(pos.x - (size.x / 2.0), pos.y - (size.y / 2.0));
  }
  
  private PVector getCenteredButtonPos(PVector pos, float squareSize) {
    return getCenteredButtonPos(pos, new PVector(squareSize, squareSize));
  }
  
  private void createProgressBar() {
    progressBar = new PlaybackSlider(currentStyle.progressBarPos, currentStyle.progressBarSize, currentStyle.progressBarPlayedColor, currentStyle.secondaryColor, null);
    addElement(progressBar);
  }
  
  private void createControlElements() {
    float progressBarMaxY = (currentStyle.progressBarPos.y + currentStyle.progressBarSize.y);
    float heightUnderProgressBar = (height - progressBarMaxY);
    PVector playbackControlCenter = new PVector(currentStyle.center.x, (height + progressBarMaxY) / 2.0);
    createPlayPauseButton(playbackControlCenter, heightUnderProgressBar);
    createShuffleRepeatButtons(playbackControlCenter, heightUnderProgressBar);
    createSkipButtons(playbackControlCenter, heightUnderProgressBar);
  }
  
  private void createPlayPauseButton(PVector posToCenter, float maxHeight) {
    float playPauseSize = maxHeight / 1.1;
    PVector playPausePos = getCenteredButtonPos(posToCenter, playPauseSize);
    playPauseButton = new ShapeButton(currentStyle.pauseShape, playPausePos, new PVector(playPauseSize, playPauseSize), currentStyle.black, "onPlayPauseButtonClicked");
    updatePlayPauseShape();
    addElement(playPauseButton);
  }
  
  private void createShuffleRepeatButtons(PVector posToCenter, float maxHeight) {
    float controlButtonSize = maxHeight / 2.0;
    PVector buttonAlignPos = getCenteredButtonPos(posToCenter, controlButtonSize);
    PVector buttonOffset = new PVector(width / 4.0, 0.0);
    repeatSongButton = new ShapeButton(currentStyle.repeatShape, PVector.add(buttonAlignPos, buttonOffset), new PVector(controlButtonSize, controlButtonSize), currentStyle.black, "onRepeatSongButtonClicked");
    updateRepeatSongButton();
    addElement(repeatSongButton);
    shuffleButton = new ShapeButton(currentStyle.shuffleShape, PVector.sub(buttonAlignPos, buttonOffset), new PVector(controlButtonSize, controlButtonSize), currentStyle.black, "onShuffleButtonClicked");
    updateShuffleButton();
    addElement(shuffleButton);
  }
  
  private void createSkipButtons(PVector posToCenter, float maxHeight) {
    float skipButtonSize = maxHeight / 1.2;
    PVector buttonAlignPos = getCenteredButtonPos(posToCenter, skipButtonSize);
    PVector buttonOffset = new PVector(width / 6.0, 0.0); 
    addElement(new ShapeButton(currentStyle.skipPreviousShape, PVector.sub(buttonAlignPos, buttonOffset), new PVector(skipButtonSize, skipButtonSize), currentStyle.black, "onSkipButtonClicked", -1));
    addElement(new ShapeButton(currentStyle.skipNextShape, PVector.add(buttonAlignPos, buttonOffset), new PVector(skipButtonSize, skipButtonSize), currentStyle.black, "onSkipButtonClicked", 1));
  }
  
  private void createTitleLabel() {
    PVector labelSize = new PVector(currentStyle.progressBarSize.x, height * currentStyle.titleLabelHeightScale);
    PVector labelPos = new PVector(currentStyle.progressBarPos.x, height * currentStyle.titleLabelYScale);
    titleLabel = new Label("", labelPos, labelSize, currentStyle.black, LEFT, BASELINE);
    addElement(titleLabel);
  }
  
  void updatePlayPauseShape() {
    playPauseButton.setShape(Music.isPlaying() ? currentStyle.pauseShape : currentStyle.playShape);
  }
  
  void onPlayPauseButtonClicked() {
    Music.togglePlaying();
    updatePlayPauseShape();
  }
  
  void onRepeatSongButtonClicked() {
    int newRepeatMode = Music.getRepeatMode() + 1;
    Music.setRepeatMode(newRepeatMode);
    updateRepeatSongButton();
  }
  
  void updateRepeatSongButton() {
    int repeatMode = Music.getRepeatMode();
    repeatSongButton.setCol((repeatMode != Music.REPEAT_NONE) ? currentStyle.highlightColor : currentStyle.black);
    repeatSongButton.setShape((repeatMode == Music.REPEAT_SONG) ? currentStyle.repeatSongShape : currentStyle.repeatShape);
  }
  
  void onShuffleButtonClicked() {
    Music.setShuffling(!Music.isShuffling());
    updateShuffleButton();
  }
  
  void updateShuffleButton() {
    shuffleButton.setCol(Music.isShuffling() ? currentStyle.highlightColor : currentStyle.black);
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
  
  private void playNextSong() {
    if (Music.getRepeatMode() == Music.REPEAT_SONG) {
      Music.getCurrentSong().cue(0); // If the song is already playing, it can be cued to the start instead of having to be reloaded
    } else {
      Music.skipToIndexedSong(1);
    }
    Music.setPlaying(true); // In some cases, the next song will not play automatically because Minim itself considers the song "ended" and the state is incorrectly transferred
  }
  
  void update() {
    baseParent.update();
    if (hasSongEnded()) {
      playNextSong();
    }
    if (Music.wasUpdated()) {
      onMusicUpdate();
    }
  }
}
