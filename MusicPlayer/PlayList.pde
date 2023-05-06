class PlayList {
  private String name = "Unnamed Playlist";
  private ArrayList<AudioMetaData> dataList;
  private boolean shouldSave;

  PlayList(boolean startEmpty) {
    dataList = new ArrayList<AudioMetaData>();
    if (!startEmpty) {
      loadSongData();
    }
    shouldSave = startEmpty;
  }
  
  PlayList(String name, boolean startEmpty) {
    this(startEmpty);
    setName(name);
  }
  
  String getName() {
    return name;
  }
  
  void setName(String name) {
    this.name = name.isEmpty() ? "Unnamed Playlist" : name;
  }
  
  private String addToSongsFolder(String path) {
    File pathToCheck = new File(path);
    String fileName = pathToCheck.getName();
    File newFilePath = new File(sketchPath() + "/data/songs/" + fileName);
    if (!newFilePath.exists()) {
      saveStream(newFilePath, pathToCheck.getPath());
    }
    return newFilePath.getPath();
  }
  
  void addSongFromPath(String path) {
    String songsPath = addToSongsFolder(path);
    AudioMetaData songData = Music.loadMetaData(songsPath);
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

  int getDataSize() {
    return dataList.size();
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
    if (Music.isShuffling()) {
      return getRandomIndex();
    }
    return 0;
  }

  int getSkippedIndex(int currentIndex, int skipBy) {
    if (Music.isShuffling()) {
      return getRandomIndex();
    }
    int skippedIndex = currentIndex + skipBy;
    int maxIndex = dataList.size();
    if (Music.getRepeatMode() == Music.REPEAT_PLAYLIST) {
      return skippedIndex % maxIndex;
    } else {
      if (skippedIndex > maxIndex - 1) {
        return -1; // If the next song is out of the playlist, return -1 to show that the playlist has ended
      }
      return max(0, skippedIndex);
    }
  }
  
  JSONObject asJsonObject() {
    JSONObject tempJson = new JSONObject();
    tempJson.setString("name", name);
    JSONArray dataArray = new JSONArray();
    for (int i = 0; i < dataList.size(); i++) {
      JSONObject dataObj = new JSONObject();
      dataObj.setString("filePath", dataList.get(i).fileName());
      dataArray.setJSONObject(i, dataObj);
    }
    tempJson.setJSONArray("songs", dataArray);
    return tempJson;
  }
  
  boolean shouldBeSaved() {
    return shouldSave && dataList.size() > 0; // Default "Songs Folder" PlayList and empty PlayLists should not be saved
  }
}
