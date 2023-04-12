import processing.core.*;
import ddf.minim.*;
import java.util.ArrayList;

class Music {
  private static Minim minim;
  private static AudioPlayer currentSong;
  private static boolean updated = false;
  private static MusicPlayer appInst;
  private static MusicPlayer.PlayList currentPlayList;
  private static int currentDataIndex = -1;

  public static void setAppInst(MusicPlayer newAppInst) {
    appInst = newAppInst;
    minim = new Minim(appInst);
    //currentPlayList = appInst.new PlayList();
  }

  public static AudioPlayer loadFile(String path) {
    return minim.loadFile(path);
  }

  public static AudioPlayer loadSong(String name) {
    return loadFile("songs/" + name);
  }
  
  public static AudioMetaData loadMetaData(String path) {
    return minim.loadMetaData(path);
  }

  public static AudioPlayer getCurrentSong() {
    return currentSong;
  }
  
  public static void removeCurrentSong() {
    if (currentSong != null) {
      currentSong.close(); // Allow old song to be garbage collected
      currentSong = null;
      setUpdated(true);
    }
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


  public static void setCurrentSong(String name) {
    setCurrentSong(loadSong(name));
  }

  public static void setCurrentSongFile(String path) {
    setCurrentSong(loadFile(path));
  }

  public static void setCurrentSong(AudioMetaData data) {
    if (data == null) {
      return;
    }
    setCurrentSong(loadFile(data.fileName()));
  }

  public static int getCurrentDataIndex() {
    return currentDataIndex;
  }

  public static void setIndexedSong(int index) {
    if (currentPlayList == null || index == currentDataIndex) {
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
    if (skippedIndex == -1) {
      removeCurrentPlayList();
      return;
    }
    setIndexedSong(skippedIndex);
  }

  public static MusicPlayer.PlayList getCurrentPlayList() {
    return currentPlayList;
  }
  
  public static void removeCurrentPlayList() {
    removeCurrentSong();
    currentDataIndex = -1;
    currentPlayList = null;
  }

  // If the play button is pressed on a playlist instead of directly selecting a song
  public static void setCurrentPlayList(MusicPlayer.PlayList newPlayList) {
    currentPlayList = newPlayList;
    if (currentPlayList != null) {
      currentDataIndex = currentPlayList.getStartingIndex();
      setCurrentSong(currentPlayList.getData(currentDataIndex));
    }
  }
  
  public static void setCurrentPlayList(MusicPlayer.PlayList newPlayList, int index) {
    currentPlayList = newPlayList;
    if (currentPlayList != null) {
      currentDataIndex = index;
      setCurrentSong(currentPlayList.getData(currentDataIndex));
    }
  }
  
  public static boolean isCurrentPlayList(MusicPlayer.PlayList comparePlayList) {
    if (currentPlayList == null) {
      return false;
    }
    return comparePlayList == currentPlayList;
  }

  public static ArrayList<AudioMetaData> getDataList() {
    if (currentPlayList == null) {
      return null;
    }
    return currentPlayList.getDataList();
  }

  public static AudioMetaData getIndexedData(int index) {
    if (currentPlayList == null) {
      return null;
    }
    return currentPlayList.getData(index);
  }

  public static boolean wasUpdated() {
    return updated;
  }

  public static void setUpdated(boolean statusToSet) {
    updated = statusToSet;
  }

  public static boolean isPlaying() {
    if (currentSong == null) {
      return false;
    }
    return currentSong.isPlaying();
  }

  public static void setPlaying(boolean playing) {
    if (currentSong != null) {
      if (playing) {
        currentSong.play();
      } else {
        currentSong.pause();
      }
    }
  }

  public static void togglePlaying() {
    if (currentSong == null) {
      return;
    }
    boolean statusToSet = !isPlaying();
    setPlaying(statusToSet);
  }
}
