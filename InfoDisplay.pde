class InfoDisplay {
  ArrayList<TrackPoint> trkptsCopy;
  ArrayList<TrackPoint> nearbyTrkpts;


  InfoDisplay(ArrayList<TrackPoint> trkpts) {
    trkptsCopy = trkpts;
    nearbyTrkpts = new ArrayList<TrackPoint>();
  }

  void displayTimeString(int mx, int my) {
    if (checkIsNearby(mx, my)) {
      TrackPoint nearest = getNearest();
      String time = timeHand.getTime(nearest.timestamp);
      println("the time here was "+time);
      nearbyTrkpts.clear();
    }
  }

  boolean checkIsNearby(int mx, int my) {
    int trkptReducer = 2; //reduces number of trkpts to loop through to reduce lag
    for (int i = 0; i < trkptsCopy.size(); i += trkptReducer) {
      TrackPoint t = trkptsCopy.get(i);
      //println("the location of this trackpoint is "+i);
      //println("this trackpoints location is "+t.loc);
      if (t.isNearby(mx, my)) nearbyTrkpts.add(t);
    }
    if (nearbyTrkpts.size() == 0) return false;
    else return true;
  }

  //calculate minimum of all nearby trkpts
  TrackPoint getNearest() {
    ArrayList distances = new ArrayList();
    
    float minDist = 100;
    float closest = 100;
    //    println("the number of nearby trackpoints is "+nearbyTrkpts.size());
    for (int i = 0; i < nearbyTrkpts.size()-1; i++) {
      TrackPoint trkpt1 = trkptsCopy.get(i);
      TrackPoint trkpt2 = trkptsCopy.get(i+1);
      float tempMin = min(trkpt1.distAway, trkpt2.distAway);
      println("the distance away from this is "+trkpt1.distAway);
      closest = min(minDist, tempMin);
      distances.add((float) closest);
    }
    println(distances);
    //int index = distances.indexOf(closest);
    return trkptsCopy.get(1);
  }
}

