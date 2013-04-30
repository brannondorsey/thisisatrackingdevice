class InfoDisplay {
  ArrayList<TrackPoint> trkptsCopy;
  ArrayList<TrackPoint> nearbyTrkpts;
  int tSize;
  


  InfoDisplay(ArrayList<TrackPoint> trkpts) {
    trkptsCopy = trkpts;
    nearbyTrkpts = new ArrayList<TrackPoint>();
    tSize = 24;
    textSize(tSize);
    PFont font = createFont("lato", tSize);
    textFont(font);
  }

  void displayTimeString(int mx, int my) {
    if (checkIsNearby(mx, my)) {
      TrackPoint nearest = getNearest();
      String time = "";
      if(nearest != null) time = timeHand.getTime(nearest.timestamp);
      if(time != ""){
        displayBox(time, nearest);
        println("the time here was "+time);
      }
      nearbyTrkpts.clear();
    }
  }
  
  void displayBox(String time, TrackPoint nearest){
    int offsetX = 20;
    int offsetY = 40;
    int padding = 10;
    int awayFromPoint = 3; 
    
    fill(#3475CE);
    rect(nearest.pos.x + offsetX-padding, nearest.pos.y - offsetY-padding, textWidth(time)+padding*2, tSize+padding);
    beginShape();
    vertex(nearest.pos.x+offsetX-padding, nearest.pos.y - 50);
    vertex(nearest.pos.x+awayFromPoint, nearest.pos.y-awayFromPoint);
    vertex(nearest.pos.x+offsetX-padding + 50, nearest.pos.y - offsetY);
    endShape();
    fill(255);
    text(time, nearest.pos.x+offsetX , nearest.pos.y-offsetY+padding/2+tSize/2);
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
    if(distances.size() != 0) return nearbyTrkpts.get(index);
    else return null;
  }
}

