final class Style {
  final PVector center = new PVector(width / 2.0, height / 2.0);
  final PVector progressBarPos = new PVector(width / 12.0, height * (5.0 / 6.0));
  final PVector progressBarSize = new PVector(width * (5.0 / 6.0), height / 70.0);
  
  final PShape playShape = loadShape("icons/playCircle.svg");
  final PShape pauseShape = loadShape("icons/pauseCircle.svg");
  final PShape stopShape = loadShape("icons/stopCircle.svg");
  final PShape repeatShape = loadShape("icons/repeat.svg");
  final PShape repeatSongShape = loadShape("icons/repeatSong.svg");
  final PShape shuffleShape = loadShape("icons/shuffle.svg");
  final PShape skipNextShape = loadShape("icons/skipNext.svg");
  final PShape skipPreviousShape = loadShape("icons/skipPrevious.svg");
  final PShape plusShape = loadShape("icons/plus.svg");
  final PShape backArrowShape = loadShape("icons/backArrow.svg");
  final PShape playListShape = loadShape("icons/playList.svg");
  
  final float titleLabelHeightScale = 0.06;
  final float titleLabelYScale = (4.9 / 6.0);
  final float scrollBarWidthScale = 0.05;
  
  final color white = color(255);
  final color black = color(0);
  color highlightColor = color(0, 150, 255);
  color progressBarPlayedColor = white;
  color scrollBarColor = color(100);
  color unselectedColor = color(30);
  color secondaryColor = color(70);
  color backgroundColor = color(30);
  
  final PFont mainFont = createFont("Arial", 32);
}
