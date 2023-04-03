class PlayList {
  private int currentIndex;
  private boolean repeat;
  private boolean shuffle;
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
  
  private int getRandomIndex() {
    return (int)random(0, dataList.size());
  }
  
  void play() {
    if (shuffle) {
      currentIndex = getRandomIndex();
      return;
    }
    currentIndex = 0;
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
  
  boolean isShuffled() {
    return shuffle;
  }
  
  void setShuffle(boolean shuffle) {
    this.shuffle = shuffle;
  }
  
  void toggleShuffle() {
    setShuffle(!shuffle);
  }
  
  boolean isRepeating() {
    return repeat;
  }
  
  void setRepeating(boolean repeat) {
    this.repeat = repeat;
  }
  
  void toggleRepeating() {
    setRepeating(!repeat);
  }
  
  AudioMetaData getCurrentData() {
    if (currentIndex == -1) {
      return null;
    }
    return dataList.get(currentIndex);
  }
}
