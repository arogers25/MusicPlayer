public class PlayListContainer {
  private ArrayList<PlayList> playLists;
  private PlayList currentPlayList;
  private int currentPlayListIndex = -1;
  
  PlayListContainer() {
    this.playLists = new ArrayList<PlayList>();
  }
  
  PlayList getCurrentPlayList() {
    return currentPlayList;
  }
  
  int getCurrentPlayListIndex() {
    return currentPlayListIndex;
  }
  
  void setCurrentPlayList(PlayList currentPlayList) {
    if (currentPlayList == null) {
      currentPlayListIndex = -1;
    }
    this.currentPlayList = currentPlayList;
  }
  
  PlayList getIndexedPlayList(int index) {
    if (index < 0 || index >= playLists.size()) {
      return null;
    }
    return playLists.get(index);
  }
  
  void setIndexedPlayList(int index) {
    setCurrentPlayList(getIndexedPlayList(index));
  }
  
  void addPlayList(PlayList playList) {
    if (playList == null || containsPlayList(playList)) {
      return;
    }
    playLists.add(playList);
  }
  
  void createEmptyPlayList(String name) {
    playLists.add(new PlayList(name, true));
  }
  
  boolean containsPlayList(PlayList playList) {
    return playLists.contains(playList);
  }
  
  int getPlayListsSize() {
    return playLists.size();
  }
}
