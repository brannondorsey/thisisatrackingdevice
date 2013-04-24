class PointMarker {

  Location loc;
  Location nextLoc;
  ScreenPosition pos;
  SimplePointMarker m;
  PImage markerImg;
  int s;
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

  void display() {
    fill(#3475CE);
    SimplePointMarker m = new SimplePointMarker(loc);
    ScreenPosition pos =  m.getScreenPosition(map);
//    ellipseMode(CENTER);
//    ellipse(pos.x, pos.y, s, s);
    //pushMatrix();
   //rotate(angle);
    imageMode(CENTER);
    image(markerImg, pos.x, pos.y, s, s);
    imageMode(CORNER);
    //popMatrix();
  }

  void update() {
    pos = m.getScreenPosition(map);
    if (isOver(mouseX, mouseY)){
      s = 30;
    }
    else s = 15;
    }

  boolean isOver(int mx, int my) {
      float x = pos.x;
      float y = pos.y;
      if(dist(mx, my, x-(s/2), pos.y-(s/2)) <= s) return true;
      else return false;
    }
}

