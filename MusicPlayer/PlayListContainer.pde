public class PlayListContainer {
  private ArrayList<PlayList> playLists;
  private PlayList currentPlayList;
  private int currentPlayListIndex = -1;
  
  PlayListContainer() {
    this.playLists = new ArrayList<PlayList>();
    loadSavedPlayLists();
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
  
  PlayList getPlayListFromJson(String path) {
    try {
      JSONObject tempJson = loadJSONObject(path);
      if (tempJson == null) {
        return null;
      }
      String playListName = tempJson.getString("name");
      PlayList tempPlayList = new PlayList(playListName, true);
      JSONArray dataList = tempJson.getJSONArray("songs");
      for (int i = 0; i < dataList.size(); i++) {
        String filePath = dataList.getJSONObject(i).getString("filePath");
        tempPlayList.addSongFromPath(filePath);
      }
      return tempPlayList;
    } catch (Exception e) { // Catch all exceptions if the JSON has been corrupted or modified incorrectly
      println(e);
      return null;
    }
  }
  
  void loadSavedPlayLists() {
    playLists.clear();
    playLists.add(new PlayList("Songs Folder", false));
    File playListsDirectory = new File(sketchPath() + "/data/playLists");
    File[] playListFiles = playListsDirectory.listFiles();
    for (File playListFile : playListFiles) {
      String playListPath = playListFile.getAbsolutePath();
      playLists.add(getPlayListFromJson(playListPath));
    }
  }
  
  boolean containsPlayList(PlayList playList) {
    return playLists.contains(playList);
  }
  
  int getPlayListsSize() {
    return playLists.size();
  }
}
