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

UnfoldingMap map;
GPXHandler gpxHandler;
PointVisualization ptVis;
StreetView strView;
Location[] pts;
SimpleLinesMarker linePoints;
String fileToParse = "marathon.xml";
color c = #3475CE;

void setup() {
  size(screen.width, screen.height, GLConstants.GLGRAPHICS);
  smooth();
  noStroke();
  
  int maxPanningDistance = 10; // in km
  int zoom = 13; //13 or 17

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
}

void draw() {
  linePoints.setColor(c);
  linePoints.setStrokeWeight(3);
  map.addMarkers(linePoints);
  map.draw();
  for(int i = 0; i < ptVis.markers.size(); i++){
    PointMarker currentMarker = ptVis.markers.get(i);
    currentMarker.update();
    currentMarker.display();
  }
 // gpxHandler.printAngleTest();
  ptVis.displayStart();
  checkImageDisplay();
}

void checkImageDisplay(){
  for(int i = 0; i < ptVis.markers.size(); i++){
    PointMarker marker = ptVis.markers.get(i);
    if(marker.isOver(mouseX, mouseY)) strView.display(i);
  }
}

