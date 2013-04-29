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
      String time = "";
      if(nearest != null)time = timeHand.getTime(nearest.timestamp);
      if(time != "") println("the time here was "+time);
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
    float closest = 0;
    for (int i = 0; i < nearbyTrkpts.size()-1; i++) {
      TrackPoint trkpt1 = nearbyTrkpts.get(i);
      println("the distances array is "+distances);
      TrackPoint trkpt2 = nearbyTrkpts.get(i+1);
      float tempMin = min(trkpt1.distAway, trkpt2.distAway);
      distances.add((float) tempMin);   
      closest = min(minDist, tempMin);
    }

//    println("the distances array holds "+distances.size());
//    println("the value that it is looking for is "+closest);
    println("closest is "+closest);
    int index = distances.indexOf(closest);
    println("the value of index is "+index);
    println("the size of the distances array is "+distances.size());
    if(distances.size() != 0) return nearbyTrkpts.get(index);
    else return null;
  }
}

