import processing.core.*;
import ddf.minim.*;
import java.util.ArrayList;

class Music {
  private static Minim minim;
  private static AudioPlayer currentSong;
  private static boolean updated = false;
  private static MusicPlayer appInst;
  private static MusicPlayer.PlayList currentPlayList;
  
  public static void setAppInst(MusicPlayer newAppInst) {
    appInst = newAppInst;
    minim = new Minim(appInst);
    currentPlayList = appInst.new PlayList();
  }
  
  public static AudioPlayer loadFile(String path) {
    return minim.loadFile(path);
  }
  
  public static AudioPlayer loadSong(String name) {
    return loadFile("songs/" + name);
  }
  
  public static AudioPlayer getCurrentSong() {
    return currentSong;
  }
  
  public static void setCurrentSong(AudioPlayer newSong) {
    if (currentSong == newSong) {
      return;
    }
    boolean wasPlaying = isPlaying();
    if (currentSong != null) {
      currentSong.close(); // Allow old song to be garbage collected
    }
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
    setCurrentSongFile(data.fileName());
  }
  
  public static void setCurrentPlayList(MusicPlayer.PlayList newPlayList) {
    currentPlayList = newPlayList;
  }
  
  public static MusicPlayer.PlayList getCurrentPlayList() {
    return currentPlayList;
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
