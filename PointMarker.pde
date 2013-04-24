class PointMarker {

  Location loc;
  Location nextLoc;
  ScreenPosition pos;
  SimplePointMarker m;
  PImage markerImg;
  int s;
  int minS = 15;
  int maxS = 30;
  int growDistance = 100; 
  float angle;
  int index;

  PointMarker(int _index, Location _loc, Location _nextLoc) {
    loc = _loc;
    nextLoc = _nextLoc;
    index = _index;
    s = 15;
    m = new SimplePointMarker(loc);
    pos = m.getScreenPosition(map);
    SimplePointMarker n = new SimplePointMarker(nextLoc);
    ScreenPosition nextPos = n.getScreenPosition(map);
    markerImg = loadImage("marker.png");
    angle =  degrees((float) GeoUtils.getAngleBetween(loc, nextLoc));
    println("the angle is "+angle);
    //println("the current location is "+loc.getLat()+", "+loc.getLon()+". the next location is "+nextLoc.getLat()+", "+nextLoc.getLon()+".");
  }
  
  //updates screen positions
  void update(){
    pos = m.getScreenPosition(map);
  }

  void display() {
    float distFromMarker = dist(mouseX, mouseY, pos.x, pos.y);
    float distM = constrain(distFromMarker, 0, growDistance);
    s = int(map(distM, 0, growDistance, maxS, minS));
   
    //s = 15;
    fill(#3475CE);
    SimplePointMarker m = new SimplePointMarker(loc);
    ScreenPosition pos =  m.getScreenPosition(map);

    //pushMatrix();
    //rotate(angle);
    imageMode(CENTER);
    image(markerImg, pos.x, pos.y, s, s);
    imageMode(CORNER);
    //popMatrix();
  }

  boolean isOver(int mx, int my) {
    float x = pos.x;
    float y = pos.y;
    if (dist(mx, my, pos.x, pos.y) <= s) return true;
    else return false;
  }
}

