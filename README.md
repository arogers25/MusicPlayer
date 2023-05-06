# MusicPlayer
A simple music player app made with Processing 4

![mainScreenShot](https://user-images.githubusercontent.com/98920817/236632560-1d112a2f-2330-4d25-a21e-48cdfd5faa7b.png)

## Features
- .mp3 file playback
- Unlimited custom song addition
- Playlists for grouping songs
- Saving and loading for playlists
- Shuffle button for random song selection
- Repeat button for playlists and songs

## Resources Used
- App made using [Processing 4 for Java](https://processing.org)
- Music playback done using [Minim library for Processing](https://github.com/ddf/Minim)
- All app icons provided by [Google Fonts Material Symbols](https://fonts.google.com/icons)
- Default music provided by YouTube Audio Library

# AppEngine
A custom set of Processing code to make GUI and app creation easier

## Features
- Various GUI elements that allow for a wide range of app control
- Input system to make handling mouse and key presses easier than default Processing
- Color, font, and shape customizability using Style class
- Uses no external libraries
- AppEngine files can be copied directly into projects and be used immediately

# File Layout
AppEngine files made to be copied across projects (Bolded files **must** be copied to use AppEngine):
- **AppEngine.pde**
- **Style.pde**
- **Element.pde** 
- **Input.java**
- **Layout.pde**
- **Style.pde**
- Button.pde
- Label.pde
- ListBox.pde
- ListItem.pde
- PositionedElement.pde
- RectangleButton.pde
- ShapeButton.pde
- Slider.pde

Files made specifically for MusicPlayer:
- MusicPlayer.pde
- ListBoxControlLayout.pde
- Music.java 
- PlayList.pde
- PlayListContainer.pde
- PlayListLayout.pde
- PlaybackSlider.pde
- SongController.pde
- SongListLayout.pde
