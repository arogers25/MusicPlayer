import processing.core.*;
import ddf.minim.*;

class Music {
  private static Minim minim;
  private static AudioPlayer currentSong;
  private static MusicPlayer.PlayList currentPlayList;
  private static MusicPlayer.PlayListContainer playListContainer;
  private static boolean repeatingSong;
  private static int currentDataIndex = -1;
  private static boolean updated = false;

  public static void createMinim(MusicPlayer appInst) {
    minim = new Minim(appInst);
    playListContainer = appInst.new PlayListContainer();
  }

  public static AudioPlayer loadFile(String path) {
    return minim.loadFile(path);
  }
  
  public static AudioMetaData loadMetaData(String path) {
    return minim.loadMetaData(path);
  }

  public static AudioPlayer getCurrentSong() {
    return currentSong;
  }
  
  public static void setCurrentSong(AudioPlayer newSong) {
    if (currentSong == newSong) {
      return;
    }
    boolean wasPlaying = currentSong == null ? true : isPlaying(); // If there is no current song playing, it can be presumed the user wants a song to start as soon as it is selected
    removeCurrentSong();
    currentSong = newSong;
    if (currentSong != null) {
      setPlaying(wasPlaying); // Restore play/pause state from previous song so playlists can continue without user input
    }
    setUpdated(true);
  }
  
  public static void setCurrentSong(AudioMetaData data) {
    if (data == null) {
      return;
    }
    setCurrentSong(loadFile(data.fileName()));
  }
  
  public static void removeCurrentSong() {
    if (currentSong == null) {
      return;
    }
    currentSong.close(); // Allow old song to be garbage collected
    currentSong = null;
    setUpdated(true);
  }

  public static int getCurrentDataIndex() {
    return currentDataIndex;
  }
  
  private static boolean updateCurrentPlayList() {
    boolean playListUpdated = (playListContainer.getCurrentPlayList() != currentPlayList);
    currentPlayList = playListContainer.getCurrentPlayList();
    return playListUpdated;
  }

  public static void setIndexedSong(int index) {
    boolean songChanged = updateCurrentPlayList() || (currentDataIndex != index);
    if (currentPlayList == null || !songChanged) { // Prevent songs from being replayed by double clicking
      return;
    }
    if (index == -1) {
      removeCurrentPlayList();
      return;
    }
    AudioMetaData indexedSongData = currentPlayList.getData(index);
    if (indexedSongData != null) {
      currentDataIndex = index;
      setCurrentSong(indexedSongData);
    }
  }

  public static void skipToIndexedSong(int skipBy) {
    updateCurrentPlayList();
    if (currentPlayList == null) {
      return;
    }
    int skippedIndex = currentPlayList.getSkippedIndex(currentDataIndex, skipBy);
    setIndexedSong(skippedIndex);
  }
  
  public static void removeCurrentPlayList() {
    removeCurrentSong();
    currentDataIndex = -1;
    playListContainer.setCurrentPlayList(null);
    updateCurrentPlayList();
  }

  public static MusicPlayer.PlayListContainer getPlayListContainer() {
    return playListContainer;
  }
  
  public static boolean isPlaying() {
    if (currentSong == null) {
      return false;
    }
    return currentSong.isPlaying();
  }

  public static void setPlaying(boolean playing) {
    if (currentSong == null) {
      return;
    }
    if (playing) {
      currentSong.play();
    } else {
      currentSong.pause();
    }
  }

  public static void togglePlaying() {
    boolean statusToSet = !isPlaying();
    setPlaying(statusToSet);
  }
  
  public static boolean isRepeating() {
    return repeatingSong;
  }
  
  public static void setRepeating(boolean statusToSet) {
    repeatingSong = statusToSet;
  }
    
  
  public static boolean wasUpdated() {
    return updated;
  }

  public static void setUpdated(boolean statusToSet) {
    updated = statusToSet;
  }
}
