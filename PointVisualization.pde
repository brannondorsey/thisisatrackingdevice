class PointVisualization {

  GeoUtils geo; 
  ArrayList<ScreenPosition> screenpos;
  ArrayList<PointMarker> markers;
  ScreenPosition currentScreenpos;
  float pointFrequency = 150; //in km
  PImage cube;

  PointVisualization() {
    //geo = new GeoUtils();
    screenpos = new ArrayList<ScreenPosition>();
    markers = new ArrayList<PointMarker>();
    cube = loadImage("cube.png");
  }

  //  void init() {
  //    TrackPoint currentTrackPoint = gpxHandler.trkpts.get(0);
  //    for (int j = 0; j <gpxHandler.trkpts.size(); i++) {
  //      if (j != i) testTrackpoint = gpxHandler.trkpts.get(j);
  //      if (testTrackpoint != null) {
  //        if (geo.getDistance(currentTrackpoint, testTrackpoint) >= pointFrequency) {
  //          //draw marker here
  //          break;
  //        }
  //        else continue;
  //      }
  //    }
  //  }

  void display() {
  }

  void displayStart() {
    int cubeSize = 30;
    tint(150, 150, 255);
    ScreenPosition startPos = screenpos.get(0);
    image(cube, startPos.x-(cubeSize/2), startPos.y-(cubeSize/2), cubeSize, cubeSize);
    tint(255, 255, 255);
  }

  void createMarker() {
    markers.add(new PointMarker(currentScreenpos));
  }

  void initMarkers(ArrayList<Location> pointLocations) {
    int index = pointLocations.size();
    for (int i = 0; i < index; i++) {
      Location currentPoint = pointLocations.get(i);
      SimplePointMarker tempMarker = new SimplePointMarker(currentPoint);
      screenpos.add(tempMarker.getScreenPosition(map));
    }
  }

  void createMarkers() {
    currentScreenpos = screenpos.get(0);
    testScreenpos();
  }

  void testScreenpos() {
    int index = screenpos.indexOf(currentScreenpos);
    if (index < screenpos.size()) {
      for (int i = index+1; i < screenpos.size(); i++) {
        ScreenPosition testScreenpos = screenpos.get(i);
        if (dist(currentScreenpos.x, currentScreenpos.y, testScreenpos.x, testScreenpos.y) >= pointFrequency) {
          //reset currentScreenpos
          createMarker();
          currentScreenpos = screenpos.get(i);
          break;
        }
        else continue;
      }
      if(index < 1000) testScreenpos();
    }
  }

  void clearScreenpos() {
    screenpos.clear();
  }
}

