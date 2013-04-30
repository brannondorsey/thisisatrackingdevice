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
String fileToParse = "mccleanblock.xml";
color c = #3475CE;

void setup() {
  size(screen.width, screen.height, GLConstants.GLGRAPHICS);
  smooth();
  noStroke();
  
  int maxPanningDistance = 10; // in km
  int zoom = 17; //13 or 17

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
  PImage[] loadingGif = Gif.getPImages(this, "loading.gif");
  strView = new StreetView(loadingGif);
  
  info = new InfoDisplay(gpxHandler.trkpts);
  timeHand = new TimeHandler();
  
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
  }
  ptVis.displayStart();
  info.displayTimeString(mouseX, mouseY);
  info.displayStopwatches();
  checkImageDisplay();
}

void mousePressed(){
 if(info.nearby) info.addStopwatch(); 
 else info.diffList.clear();
}

void checkImageDisplay(){
  for(int i = 0; i < ptVis.markers.size(); i++){
    PointMarker marker = ptVis.markers.get(i);
    int offset = int(marker.s/2);
    if(marker.isOver(mouseX, mouseY)){ 
      strView.loading();
      strView.display(i);
    }
  }
}

