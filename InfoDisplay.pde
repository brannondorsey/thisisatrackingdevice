class InfoDisplay {
  ArrayList<TrackPoint> trkptsCopy;
  ArrayList<TrackPoint> nearbyTrkpts;
  ArrayList<TrackPoint> diffList; //for time difference between two points
  PImage watchImg;
  PImage waypointImg;
  int tSize;
  int opacity = 0;
  int opacIncr = 20; //speed at which opacity increases
  
  InfoDisplay(ArrayList<TrackPoint> trkpts) {
    trkptsCopy = trkpts;
    nearbyTrkpts = new ArrayList<TrackPoint>();
    diffList = new ArrayList<TrackPoint>();
    tSize = 24;
    textSize(tSize);
    PFont font = createFont("lato", tSize);
    textFont(font);
    watchImg = loadImage("watch.png");
    waypointImg = loadImage("waypoint.png");
  }

  void displayTimeString(int mx, int my) {
    if (checkIsNearby(mx, my)) {
      cursor(watchImg);
      TrackPoint nearest = getNearest();
      String time = "";
      if (nearest != null) time = timeHand.getTime(nearest.timestamp);
      if (time != "") {
        displayBox(time, nearest);
      }
      nearbyTrkpts.clear();
    }
    else {
      opacity = 0;
    }
    if (checkIsNearby(mouseX, mouseY)) cursor(watchImg);
    else cursor(ARROW);
  }

  void addStopwatch() {
    if (diffList.size() == 2) diffList.clear();
    if (diffList.size() < 2) {
      TrackPoint n = getNearest();
      if (n != null) diffList.add(n);
    }
  }

  void displayStopwatches() {
      for (int i = 0; i < diffList.size(); i++) {
        TrackPoint t = null;
        t = diffList.get(i);
        fill(0);
        float aspectRat = waypointImg.width/waypointImg.height;
        int imgS = 10;
        imageMode(CENTER);
        if (t != null) image(waypointImg, t.pos.x, t.pos.y-waypointImg.height/2);
        imageMode(CORNER);
      }
      String diffString;
      if(diffList.size() == 2){
       TrackPoint waypoint1 = diffList.get(0);
       TrackPoint waypoint2 = diffList.get(1);
       diffString = timeHand.getDiffString(waypoint1.timestamp, waypoint2.timestamp);
       displayBox(diffString, waypoint2);
      }
  }

  void displayBox(String time, TrackPoint nearest) {
    int offsetX = 20;
    int offsetY = 40;
    int padding = 10;
    int awayFromPoint = 3; 
    if (opacity >= 255) opacity = 255;
    fill(#3475CE); //add opacity here
    rect(nearest.pos.x + offsetX-padding, nearest.pos.y - offsetY-padding, textWidth(time)+padding*2, tSize+padding);
    beginShape();
    vertex(nearest.pos.x+offsetX-padding, nearest.pos.y - 50);
    vertex(nearest.pos.x+awayFromPoint, nearest.pos.y-awayFromPoint);
    vertex(nearest.pos.x+offsetX-padding + 50, nearest.pos.y - offsetY);
    endShape();
    fill(255); //add opacity here
    text(time, nearest.pos.x+offsetX, nearest.pos.y-offsetY+padding/2+tSize/2);
    opacity += opacIncr;
  }

  boolean checkIsNearby(int mx, int my) {
    int trkptReducer = 2; //reduces number of trkpts to loop through to reduce lag
    for (int i = 0; i < trkptsCopy.size(); i += trkptReducer) {
      TrackPoint t = trkptsCopy.get(i);
      if (t.isNearby(mx, my)) nearbyTrkpts.add(t);
    }
    if (nearbyTrkpts.size() == 0) return false;
    else return true;
  }

  //calculate minimum of all nearby trkpts
  TrackPoint getNearest() {
    ArrayList distances = new ArrayList();
    float minDist = 100;
    float closest = 0;
    for (int i = 0; i < nearbyTrkpts.size()-1; i++) {
      TrackPoint trkpt1 = nearbyTrkpts.get(i);
      TrackPoint trkpt2 = nearbyTrkpts.get(i+1);
      float tempMin = min(trkpt1.distAway, trkpt2.distAway);
      distances.add((float) tempMin);   
      closest = min(minDist, tempMin);
    }
    int index = distances.indexOf(closest);
    if (distances.size() != 0) return nearbyTrkpts.get(index);
    else return null;
  }
}

