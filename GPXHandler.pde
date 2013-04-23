class GPXHandler {
  ArrayList<TrackPoint> trkpts;
  float minLat, maxLat, minLon, maxLon;
  XMLElement gpxDoc;

  GPXHandler(XMLElement _gpxDoc) {
    gpxDoc = _gpxDoc;
    trkpts = new ArrayList();
    parseData();
    //    for (int i = 0; i < parsedDataMarkers.size();i++) {
    //      Marker pt = parsedDataMarkers.get(i);
    //      println("this points location is "+pt.getLocation());
    //      pts.add(pt.getLocation());
    //    }
    minLat = getMinOrMax("min", "lat");
    maxLat = getMinOrMax("max", "lat");
    minLon = getMinOrMax("min", "lon");
    maxLon = getMinOrMax("max", "lon");
  }

  void parseData() {
    int numEntries = gpxDoc.getChildCount();
    // println(numEntries);
    for (int i = 0; i < numEntries; i++) {
      XMLElement allChildren = gpxDoc.getChild(i);
      //println(allChildren);
    }
    XMLElement trk = gpxDoc.getChild(2);
    XMLElement[] trkseg = trk.getChild(2).getChildren();
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

