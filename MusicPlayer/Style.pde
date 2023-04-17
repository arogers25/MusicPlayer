final class Style {
  final PVector center = new PVector(width / 2.0, height / 2.0);
  final PVector progressBarPos = new PVector(width / 12.0, height * (5.0 / 6.0));
  final PVector progressBarSize = new PVector(width * (5.0 / 6.0), height / 70.0);
  final float titleLabelHeightScale = 0.06;
  final float titleLabelYScale = (4.9 / 6.0);
  final float scrollBarWidthScale = 0.10;
  final color white = color(255);
  final color black = color(0);
  final color highlightColor = color(0, 150, 255);
  final color progressBarPlayedColor = white;
  final color scrollBarColor = color(100);
  final color unselectedColor = color(30);
  final color secondaryColor = color(70);
  final color backgroundColor = color(30);
}
