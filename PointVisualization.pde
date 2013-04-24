class PointVisualization {

  GeoUtils geo; 
  ArrayList<PointMarker> markers;
  ArrayList<TrackPoint> trkptsCopy;
  Location currentLocation;
  Location nextLocation;
  float pointFrequency = 100;
  PImage cube;
  int markerIndex = 0;

  PointVisualization(ArrayList<TrackPoint> _trkptsCopy) {
    //geo = new GeoUtils();
    trkptsCopy = _trkptsCopy;
    markers = new ArrayList<PointMarker>();
    cube = loadImage("cube.png");
  }

  void display() {
  }

  void displayStart() {
    int cubeSize = 30;
    tint(150, 150, 255);
    TrackPoint tempTrkpt = trkptsCopy.get(1);
    Location startLoc = tempTrkpt.loc;
    SimplePointMarker m = new SimplePointMarker(startLoc);
    ScreenPosition startPos = m.getScreenPosition(map);
    //image(cube, startPos.x-(cubeSize/2), startPos.y-(cubeSize/2), cubeSize, cubeSize);
    tint(255, 255, 255);
  }

  void createMarker() {
    markers.add(new PointMarker(markerIndex, currentLocation, nextLocation));
    markerIndex++;
  }

  void createMarkers() {
    currentLocation = gpxHandler.trkpts.get(0).loc;
    nextLocation = gpxHandler.trkpts.get(1).loc;
    testScreenpos();
  }

  void testScreenpos() {
    int index = getIndexOf(currentLocation); //this might not work because it is querying the arraylist of TrackPoints for a Location that a trackpoint will contain
    if (index < trkptsCopy.size()) {
      SimplePointMarker tempMarker = new SimplePointMarker(currentLocation);
      ScreenPosition currentScreenpos = tempMarker.getScreenPosition(map);
      for (int i = index+1; i < trkptsCopy.size(); i++) {
        TrackPoint testTrkpt = trkptsCopy.get(i);
        TrackPoint nextTestTrkpt = trkptsCopy.get(i+1);
        SimplePointMarker m = new SimplePointMarker(testTrkpt.loc);
        SimplePointMarker nextM = new SimplePointMarker(nextTestTrkpt.loc);
        ScreenPosition testScreenpos = m.getScreenPosition(map);
        ScreenPosition nextTestScreenpos = nextM.getScreenPosition(map);
        if (dist(currentScreenpos.x, currentScreenpos.y, testScreenpos.x, testScreenpos.y) >= pointFrequency) {
          //reset currentScreenpos
          createMarker();
          currentLocation = m.getLocation();
          nextLocation = nextM.getLocation();
          break;
        }
        else continue;
      }
      if (index < 1000) testScreenpos();
    }
  }
  
  int getIndexOf(Location targetLoc){
    ArrayList<Location> temp = new ArrayList<Location>();
    for(int i = 0; i<trkptsCopy.size(); i++){
      TrackPoint tempTrkpt = trkptsCopy.get(i);
      temp.add(tempTrkpt.loc);
    }
    return temp.indexOf(targetLoc);
  }

  void clearScreenpos() {
    markers.clear();
  }
}

