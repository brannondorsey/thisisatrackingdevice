class PointMarker {

  Location loc;
  Location nextLoc;
  ScreenPosition pos;
  SimplePointMarker m;
  PImage markerImg;
  PImage marker1;
  PImage marker2;
  int s;
  int minS = 15;
  int maxS = 30;
  int growDistance = 100; 
  float angle;
  int index;
  boolean firstMarker;

  PointMarker(int _index, Location _loc, Location _nextLoc) {
    loc = _loc;
    nextLoc = _nextLoc;
    index = _index;
    s = 15;
    m = new SimplePointMarker(loc);
    pos = m.getScreenPosition(map);
    SimplePointMarker n = new SimplePointMarker(nextLoc);
    ScreenPosition nextPos = n.getScreenPosition(map);
    marker1 = loadImage("marker.png");
    marker2 = loadImage("marker2.png");
    firstMarker = true;
    markerImg = marker1;
    angle =  degrees((float) GeoUtils.getAngleBetween(loc, nextLoc));
    //println("the current location is "+loc.getLat()+", "+loc.getLon()+". the next location is "+nextLoc.getLat()+", "+nextLoc.getLon()+".");
  }

  //updates screen positions
  void update() {
    pos = m.getScreenPosition(map);
  }

  void changeColor() { 
    markerImg = marker2;
  }

  void display() {
    float distFromMarker = dist(mouseX, mouseY, pos.x, pos.y);
    float distM = constrain(distFromMarker, 0, growDistance);
    s = int(map(distM, 0, growDistance, maxS, minS));

    //s = 15;
    SimplePointMarker m = new SimplePointMarker(loc);
    ScreenPosition pos =  m.getScreenPosition(map);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(angle));
    image(markerImg, -s/2, -s/2, s, s);
    popMatrix();
  }

  boolean isOver(int mx, int my) {
    float x = pos.x;
    float y = pos.y;
    if (dist(mx, my, pos.x, pos.y) <= s/2) return true;
    else return false;
  }
}

