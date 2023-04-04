class PlayList {
  private boolean repeat;
  private boolean shuffle;
  private ArrayList<AudioMetaData> dataList;

  PlayList(boolean startEmpty) {
    dataList = new ArrayList<AudioMetaData>();
    if (!startEmpty) {
      loadSongData();
    }
  }
  
  void addSongFromPath(String path) {
    AudioPlayer tempSong = Music.loadFile(path);
    if (tempSong != null) {
      dataList.add(tempSong.getMetaData());
      tempSong.close();
    }
  }

  void addSongFromName(String name) {
    AudioPlayer tempSong = Music.loadSong(name);
    if (tempSong != null) {
      dataList.add(tempSong.getMetaData());
      tempSong.close();
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
