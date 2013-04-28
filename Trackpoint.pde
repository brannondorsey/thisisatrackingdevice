class TrackPoint{
 Location loc;
 String timestamp;
 int nearbyThreshold = 10;
 float distAway;
 SimplePointMarker m;
 ScreenPosition pos;
 
 TrackPoint(double _lat, double _lon, String _timestamp){
  loc = new Location(_lat, _lon);
  timestamp = _timestamp;
  m = new SimplePointMarker(loc);
 }
 
 float getLat(){
   return loc.getLat();
 }
 
 float getLon(){
   return loc.getLon();
 }
 
 boolean isNearby(int mx, int my){
   pos = m.getScreenPosition(map);
   float distance = dist(mx, my, pos.x, pos.y);
   if (distance <= nearbyThreshold){
     distAway = distance;
     //println("nearby this trackpoint");
     return true;
   }
   else return false; 
 }
}
