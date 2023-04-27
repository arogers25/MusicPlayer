import processing.core.*;
import ddf.minim.*;

class Music {
  private static Minim minim;
  private static AudioPlayer currentSong;
  private static MusicPlayer.PlayList currentPlayList;
  private static int currentDataIndex = -1;
  private static boolean updated = false;

  public static void createMinim(MusicPlayer appInst) {
    minim = new Minim(appInst);
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

  public static void setIndexedSong(int index) {
    if (currentPlayList == null || index == currentDataIndex) {
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
    if (currentPlayList == null) {
      return;
    }
    int skippedIndex = currentPlayList.getSkippedIndex(currentDataIndex, skipBy);
    setIndexedSong(skippedIndex);
  }

  public static MusicPlayer.PlayList getCurrentPlayList() {
    return currentPlayList;
  }
  
  public static void setCurrentPlayList(MusicPlayer.PlayList newPlayList, int index) {
    currentPlayList = newPlayList;
    if (currentPlayList != null) {
      currentDataIndex = index;
      setCurrentSong(currentPlayList.getData(currentDataIndex));
    }
  }
  
  public static void removeCurrentPlayList() {
    removeCurrentSong();
    currentDataIndex = -1;
    currentPlayList = null;
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
  
  public static boolean wasUpdated() {
    return updated;
  }

  public static void setUpdated(boolean statusToSet) {
    updated = statusToSet;
  }
}
