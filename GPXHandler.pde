class GPXHandler {
  ArrayList<TrackPoint> trkpts;
  float minLat, maxLat, minLon, maxLon;
  XMLElement gpxDoc;

  GPXHandler(XMLElement _gpxDoc) {
    gpxDoc = _gpxDoc;
    trkpts = new ArrayList();
    parseData();
    minLat = getMinOrMax("min", "lat");
    maxLat = getMinOrMax("max", "lat");
    minLon = getMinOrMax("min", "lon");
    maxLon = getMinOrMax("max", "lon");
  }
  
     void parseData() {
    int numEntries = gpxDoc.getChildCount();
    // println(numEntries);
    //    for (int i = 0; i < numEntries; i++) {
    //      XMLElement allChildren = gpxDoc.getChild(i);
    //      //println(allChildren);
    //    }
    int trkIndex = getNodeIndex("trk", numEntries);
    XMLElement trk = gpxDoc.getChild(trkIndex);
    int trkSegIndex = getNodeIndex("trkseg", trk.getChildCount());
    XMLElement[] trkseg = trk.getChild(trkSegIndex).getChildren();
    int numTrkChildren = trkseg.length;
    println("the number of trackpoints is "+trkseg.length);
    for (int i = 0; i <numTrkChildren; i++) {
      float lat = trkseg[i].getFloat("lat");
      float lon = trkseg[i].getFloat("lon");

      XMLElement trkPtTimestamp = trkseg[i].getChild(1);
      String timestamp = trkPtTimestamp.getContent();
      trkpts.add(new TrackPoint(lat, lon, timestamp));
    }
  }

  //finds location of desired node in gpxDoc
  int getNodeIndex(String reqNode, int numChildren) {
    for (int j = 0; j < numChildren; j++) {
      XMLElement currentChild = gpxDoc.getChild(j);
      if (currentChild.getName().equals("trk")) {
        return j;
      }
    }
    return -1; //did not find desired node
  }

  //i.e. getMin("max", "lat");
  float getMinOrMax(String minOrMax, String latOrLon) {
    float[] allPts = new float[trkpts.size()];
    for (int i = 0; i < allPts.length; i++) {
      Location currentPt = trkpts.get(i).loc;
      if (latOrLon.equals("lat")) allPts[i] = (float) currentPt.getLat();
      else if (latOrLon.equals("lon")) allPts[i] = (float) currentPt.getLon();
    }
    if (minOrMax.equals("min")) {
      return min(allPts);
    }
    else return max(allPts);
  }

  Location getCenter() {
    double centerLat = maxLat-((maxLat-minLat)/2);
    double centerLon = maxLon-((maxLon-minLon)/2);
    return new Location(centerLat, centerLon);
  }

  ArrayList<Location> getLocations() {
    ArrayList<Location> trkptsLocations = new ArrayList<Location>();
    for (int i = 0; i < trkpts.size(); i++) {
      TrackPoint currentTrackpoint = trkpts.get(i);
      trkptsLocations.add(currentTrackpoint.loc);
    }
    return trkptsLocations;
  }
}

