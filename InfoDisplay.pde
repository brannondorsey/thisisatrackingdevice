class InfoDisplay {
  ArrayList<TrackPoint> trkptsCopy;
  ArrayList<TrackPoint> nearbyTrkpts;
  ArrayList<TrackPoint> diffList; //for time difference between two points
  PImage watchImg;
  PImage waypointImg;
  int tSize;
  int opacity = 0;
  int opacIncr = 20; //speed at which opacity increases
  
  int offsetX;
  int offsetY = 40;
  int padding = 10;
  int awayFromPoint = 3;
  
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
        timeBox(time, nearest);
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
       TrackPoint waypoint = (waypoint1.id > waypoint2.id) ? waypoint1 : waypoint2;
       diffString = timeHand.getDiffString(waypoint1.timestamp, waypoint2.timestamp);
       diffBox(diffString, waypoint);
      }
  }

  //box to show time of trackpoint
  void timeBox(String time, TrackPoint nearest) {
    if (opacity >= 255) opacity = 255;
    offsetX = 20; 
    fill(#3475CE, opacity);
    rect(nearest.pos.x + offsetX-padding, nearest.pos.y - offsetY-padding, textWidth(time)+padding*2, tSize+padding);
    beginShape();
    vertex(nearest.pos.x+offsetX-padding, nearest.pos.y - 50);
    vertex(nearest.pos.x+awayFromPoint, nearest.pos.y-awayFromPoint); //center point
    vertex(nearest.pos.x+offsetX-padding + 50, nearest.pos.y - offsetY);
    endShape();
    fill(255, opacity);
    text(time, nearest.pos.x+offsetX, nearest.pos.y-offsetY+padding/2+tSize/2);
    opacity += opacIncr;
  }
  
  //box to show time differance between two trackpoints
  void diffBox(String timeDiff, TrackPoint furtherTrkpt){
    fill(#4f4f4f);
    offsetX = 40;
    rect(furtherTrkpt.pos.x - offsetX - textWidth(timeDiff) - padding, furtherTrkpt.pos.y - offsetY-padding, textWidth(timeDiff)+padding*2, tSize+padding);
    beginShape();
    vertex(furtherTrkpt.pos.x-offsetX+padding, furtherTrkpt.pos.y - 50);
    vertex(furtherTrkpt.pos.x-awayFromPoint, furtherTrkpt.pos.y-awayFromPoint); //center point
    vertex(furtherTrkpt.pos.x-offsetX, furtherTrkpt.pos.y - offsetY + padding*2);
    endShape();
    fill(255);
    text(timeDiff, furtherTrkpt.pos.x - textWidth(timeDiff) - offsetX, furtherTrkpt.pos.y-offsetY+padding/2+tSize/2);
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

