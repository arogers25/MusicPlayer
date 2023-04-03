class PlayList {
  private int currentIndex;
  private boolean repeat;
  private ArrayList<AudioMetaData> dataList;
  
  PlayList() {
    currentIndex = -1;
    dataList = new ArrayList<AudioMetaData>();
    loadSongData();
  }
  
  void loadSongData() {
    if (dataList == null) {
      dataList = new ArrayList<AudioMetaData>();
    } else {
      dataList.clear();
    }
    File songsDirectory = new File(sketchPath() + "/data/songs");
    File[] songFiles = songsDirectory.listFiles();
    for (File songFile : songFiles) {
      String songFileName = songFile.getName();
      AudioPlayer tempSong = Music.loadSong(songFileName);
      if (tempSong != null) {
        dataList.add(tempSong.getMetaData());
        tempSong.close();
      }
    }
  }
  
  ArrayList<AudioMetaData> getDataList() {
    return dataList;
  }
  
  AudioMetaData getData(int index) {
    if (index < 0 || index >= dataList.size()) {
      return null;
    }
    return dataList.get(index);
  }
  
  void play(int index) {
    if (index < 0 || index >= dataList.size()) {
      return;
    }
    currentIndex = index;
  }
  
  int getCurrentIndex() {
    return currentIndex;
  }
  
  AudioMetaData getCurrentData() {
    if (currentIndex == -1) {
      return null;
    }
    return dataList.get(currentIndex);
  }
}
