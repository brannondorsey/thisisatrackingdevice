class MapHandler{
  
 int maxPanningDistance = 10; // in km
 int zoom = 15; //13 or 14 or 17
 int maxZoom = 18;
 float rotAngle = 0.0;
 float rotIncrement = 0.05;
 float oIncrement = 7; //original increment
 float increment;
 boolean cPressed = false; //clockwise
 boolean cCPressed = false; //counter clockwise
 boolean u = false;
 boolean r = false;
 boolean d = false;
 boolean l = false;
    
 Location cent;
 
 MapHandler(){
  cent = gpxHandler.getCenter();
  increment = oIncrement;
  initPos();
 } 
 
 void initPos(){
   map.zoomAndPanTo(cent, zoom);
   map.setPanningRestriction(cent, maxPanningDistance);
   map.setZoomRange(zoom-1, maxZoom);
 }
 
 void handleZoom(){
   if(strView.displaying) map.setZoomRange(map.getZoomLevel(), map.getZoomLevel()); //disables zoom when viewing image
   else map.setZoomRange(mapHand.zoom-1, mapHand.maxZoom);
 }
 
 void panMapIfNeeded(){
  PVector cent = new PVector(width/2, height/2);
  if(u) map.panTo(cent.x, cent.y-increment);
  if(r) map.panTo(cent.x+increment, cent.y);
  if(d) map.panTo(cent.x, cent.y+increment);
  if(l) map.panTo(cent.x-increment, cent.y);
 }
 
 void rotateMapIfNeeded(){
   if(cPressed || cCPressed){
     if(cCPressed) rotAngle += rotIncrement;
     else rotAngle -= rotIncrement;
     map.rotateTo(rotAngle);
   }
 }
 
 void zoomIn(){
   map.zoomLevelIn();
 }
}
