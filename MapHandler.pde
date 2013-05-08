class MapHandler{
  
 int maxPanningDistance = 10; // in km
 int zoom = 15; //13 or 14 or 17
 int maxZoom = 18;
 float rotAngle = 0.0;
 float rotIncrement = 0.05;
 boolean cPressed = false; //clockwise
 boolean cCPressed = false; //counter clockwise
 
 Location cent;
 
 MapHandler(){
  cent = gpxHandler.getCenter();
  
 } 
 
 void initPos(){
   map.zoomAndPanTo(cent, zoom);
   map.setPanningRestriction(cent, maxPanningDistance);
   map.setZoomRange(zoom-1, maxZoom);
 }
 
 void handleZoom(){
   if(strView.displaying) map.setZoomRange(map.getZoomLevel(), map.getZoomLevel());
   else map.setZoomRange(mapHand.zoom-1, mapHand.maxZoom);
 }
 
 void handleMap(){
  
 }
 
 void rotateMap(){
   if(cPressed || cCPressed){
     if(cCPressed) rotAngle += rotIncrement;
     else rotAngle -= rotIncrement;
     map.rotateTo(rotAngle);
   }
 }
 
 void rotateC(){
   rotAngle -= rotIncrement;
   map.rotateTo(rotAngle);
 }
 
 void zoomIn(){
   map.zoomLevelIn();
 }
}
