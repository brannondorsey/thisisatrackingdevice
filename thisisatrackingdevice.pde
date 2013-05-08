import gifAnimation.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import processing.opengl.*;
import codeanticode.glgraphics.*;
import java.util.Calendar;
import java.text.ParseException;

UnfoldingMap map;
EventDispatcher eventDispatcher;
MapHandler mapHand;
GPXHandler gpxHandler;
PointVisualization ptVis;
StreetView strView;
TimeHandler timeHand;
InfoDisplay info;
Location[] pts;
SimpleLinesMarker linePoints;
boolean[] overMarkers;
String fileToParse = "chicago_tour.gpx";
color c = #3475CE;

void setup() {
  size(screen.width, screen.height*4/5, GLConstants.GLGRAPHICS);
  smooth();
  noStroke();
  
  map = new UnfoldingMap(this, new OpenStreetMap.CloudmadeProvider("038dee0bec3441f495c0dee8b72467fd", 93093));
  eventDispatcher = MapUtils.createDefaultEventDispatcher(this, map);
  eventDispatcher.unregister(map, "pan", map.getId());
  XMLElement gpxDoc = new XMLElement(this, fileToParse);
  gpxHandler = new GPXHandler(gpxDoc);
  ptVis = new PointVisualization(gpxHandler.trkpts);
  mapHand = new MapHandler();
  //mapHand.initPos();
  
  linePoints = new SimpleLinesMarker(gpxHandler.getLocations()); 
  ptVis.createMarkers();
  strView = new StreetView();
  info = new InfoDisplay(gpxHandler.trkpts);
  timeHand = new TimeHandler();
  overMarkers = new boolean[ptVis.markers.size()];
  
  
  linePoints.setColor(c);
  linePoints.setStrokeWeight(3);
  map.addMarkers(linePoints);
}

void draw() {
  mapHand.panMapIfNeeded();
  mapHand.rotateMapIfNeeded();
  map.draw();
  for(int i = 0; i < ptVis.markers.size(); i++){
    PointMarker currentMarker = ptVis.markers.get(i);
    currentMarker.update();
    currentMarker.display();
    if(currentMarker.isOver(mouseX, mouseY)) overMarkers[currentMarker.index] = true;
    else overMarkers[currentMarker.index] = false;
    if(!strView.displaying) checkImgNeedsChange(i);
  }
  info.displayTimeString(mouseX, mouseY);
  info.displayStopwatches();
  if(strView.displaying) strView.display();
  setMouse();
}

void mousePressed(){
 if(info.checkIsNearby(mouseX, mouseY) && !contains(overMarkers)) info.addStopwatch(); 
 if(contains(overMarkers) && !strView.displaying) strView.displaying = true;
 else strView.displaying = false;
 eventDispatcher.register(map, "pan", map.getId());
}

void mouseReleased(){
  eventDispatcher.unregister(map, "pan", map.getId());
}

void keyPressed(){
  if(key == '=') mapHand.zoomIn();
  else if(key == ' ') mapHand.cPressed = true;
  else if(keyCode == 157) mapHand.cCPressed = true;
  if(keyCode == UP) mapHand.u = true;
  if(keyCode == RIGHT) mapHand.r = true;
  if(keyCode == DOWN) mapHand.d = true;
  if(keyCode == LEFT) mapHand.l = true;
  if(keyCode == SHIFT) mapHand.increment = mapHand.oIncrement*2;
}

void keyReleased(){
  if(key == ' ') mapHand.cPressed = false;
  else if(keyCode == 157) mapHand.cCPressed = false;
  if(keyCode == UP) mapHand.u = false;
  if(keyCode == RIGHT) mapHand.r = false;
  if(keyCode == DOWN) mapHand.d = false;
  if(keyCode == LEFT) mapHand.l = false;
  if(keyCode == SHIFT) mapHand.increment = mapHand.oIncrement;
}

void setMouse(){
 if(contains(overMarkers)) cursor(HAND);
 else if(strView.displaying) cursor(HAND);
 else if(info.checkIsNearby(mouseX, mouseY)) cursor(info.watchImg);
 else cursor(ARROW);
}

boolean contains(boolean[] values){
  for(int i = 0; i<values.length; i++){
    if(values[i] == true) return true;
  }
  return false;
}

void checkImgNeedsChange(int i){
    PointMarker marker = ptVis.markers.get(i);
    int offset = int(marker.s/2);
    if(marker.isOver(mouseX, mouseY)){ 
      strView.updateImage(i);
    }
}

