class PointVisualization {

  GeoUtils geo; 
  ScreenPosition[] screenpos;
  float pointFrequency = .3; //in km
  PImage cube;

  PointVisualization() {
    //geo = new GeoUtils();
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
    image(cube, screenpos[0].x-(cubeSize/2), screenpos[0].y-(cubeSize/2), cubeSize, cubeSize);
    tint(255, 255, 255);
  }
  
  void initMarkers(ArrayList<Location> pointLocations){
    int index = pointLocations.size();
    screenpos = new ScreenPosition[index];
    for(int i = 0; i < index; i++){
      Location currentPoint = pointLocations.get(i);
      SimplePointMarker tempMarker = new SimplePointMarker(currentPoint);
      screenpos[i] = tempMarker.getScreenPosition(map);
    }
  }
}

