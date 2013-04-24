class StreetView{
 Location hoveredLoc;
 PImage[] imgs;
 StreetView(){
  
  for(int i = 0; i < imgs.length; i++){
    PointMarker marker = ptVis.markers.get(i);
    double lat = marker.loc.getLat();
    double lon = marker.loc.getLon();
    imgs[i] = loadImage("http://maps.googleapis.com/maps/api/streetview?size=640x400&location="+lat+",%20"+lon+"&fov=110&heading=235&pitch=00&sensor=false");
  }
 } 
 
 void update(Location _hoveredLoc){
   hoveredLoc = _hoveredLoc;
 }
 
 void display(){
   
 }
 
}
