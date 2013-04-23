class PointMarker {

  Location loc;

  PointMarker(Location _loc) {
    loc = _loc;
  }

  void display() {
    fill(#3475CE);
    int s = 15;
    SimplePointMarker m = new SimplePointMarker(loc);
    ScreenPosition pos =  m.getScreenPosition(map);
    ellipse(pos.x, pos.y, s, s);
  }
}

