class PlayList {
  private String name;
  private boolean repeat;
  private boolean shuffle;
  private ArrayList<AudioMetaData> dataList;

  PlayList(boolean startEmpty) {
    dataList = new ArrayList<AudioMetaData>();
    if (!startEmpty) {
      loadSongData();
    }
  }
  
  PlayList(String name, boolean startEmpty) {
    this(startEmpty);
    this.name = name;
  }
  
  String getName() {
    return name;
  }
  
  void setName(String name) {
    this.name = name;
  }
  
  void addSongFromPath(String path) {
    AudioMetaData songData = Music.loadMetaData(path);
    if (songData != null) {
      dataList.add(songData);
    }
  }

  void addSongFromName(String name) {
    AudioMetaData songData = Music.loadMetaData("songs/" + name);
    if (songData != null) {
      dataList.add(songData);
    }
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
      addSongFromName(songFileName);
    }
  }

  ArrayList<AudioMetaData> getDataList() {
    return dataList;
  }
  
  int getLatestIndex() {
    return dataList.size() - 1;
  }

  AudioMetaData getData(int index) {
    if (index < 0 || index >= dataList.size()) {
      return null;
    }
    return dataList.get(index);
  }

  int getRandomIndex() {
    return (int)random(0, dataList.size());
  }

  int getStartingIndex() {
    if (shuffle) {
      return getRandomIndex();
    }
    return 0;
  }

  int getSkippedIndex(int currentIndex, int skipBy) {
    if (shuffle) {
      return getRandomIndex();
    }
    int skippedIndex = currentIndex + skipBy;
    int maxIndex = dataList.size();
    if (!repeat) {
      if (skippedIndex > maxIndex - 1) {
        return -1; // If the next song is out of the playlist, return -1 to show that the playlist has ended
      }
      return constrain(skippedIndex, 0, maxIndex - 1);
    } else {
      return skippedIndex % maxIndex;
    }
  }
}
