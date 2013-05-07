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
  size(screen.width, screen.height/2, GLConstants.GLGRAPHICS);
  smooth();
  noStroke();
  
  int maxPanningDistance = 10; // in km
  int zoom = 14; //13 or 14 or 17

  map = new UnfoldingMap(this, new OpenStreetMap.CloudmadeProvider("038dee0bec3441f495c0dee8b72467fd", 93093));
  MapUtils.createDefaultEventDispatcher(this, map);
  XMLElement gpxDoc = new XMLElement(this, fileToParse);
  gpxHandler = new GPXHandler(gpxDoc);
  ptVis = new PointVisualization(gpxHandler.trkpts);
  
  Location cent = gpxHandler.getCenter();
  map.zoomAndPanTo(cent, zoom);
  map.setPanningRestriction(cent, maxPanningDistance);
  map.setZoomRange(zoom-1, 18);
  
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
 if(info.checkIsNearby(mouseX, mouseY)) info.addStopwatch(); 
 if(contains(overMarkers)) strView.displaying = true;
 else strView.displaying = false;
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

