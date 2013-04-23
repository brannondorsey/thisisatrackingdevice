class TrackPoint{
 Location loc;
 String timestamp;
 
 TrackPoint(float _lat, float _lon, String _timestamp){
  loc = new Location(_lat, _lon);
  timestamp = _timestamp;
 }
 
 float getLat(){
   return loc.getLat();
 }
 
 float getLon(){
   return loc.getLon();
 }
}
