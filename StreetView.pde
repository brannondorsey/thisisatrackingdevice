class StreetView {
  Location hoveredLoc;
  PGraphics[] pgs;
  int currentImageIndex = 0;

  int imgHeight = 400; 
  int imgWidth = 640;
  int gifFrame = 0;
  float wide;
  float tall;
  float aspectRatio;
  boolean displaying = false;

  StreetView() {
    aspectRatio = imgWidth/imgHeight;
    wide = screen.width;
    tall = screen.height;//wide/aspectRatio;
    pgs = new PGraphics[ptVis.markers.size()];
    for (int i = 0; i < ptVis.markers.size(); i++) {
      PointMarker marker = ptVis.markers.get(i);
      float lat = marker.loc.getLat();
      float lon = marker.loc.getLon();
      float angle = int(marker.angle);
      PImage currentImg = loadImage("http://maps.googleapis.com/maps/api/streetview?size="+imgWidth+"x"+imgHeight+"&location="+lat+",%20"+lon+"&fov=120&heading="+angle+"&pitch=00&sensor=false&sensor=false.png");
      println("loaded image number "+i);
      currentImg.resize(int(wide), int(tall));
      stylePgs(i, currentImg);
    }
  } 

  void display() {
    image(pgs[currentImageIndex], 0, screen.height-tall, wide, tall);
  }
  
  void updateImage(int i){
    currentImageIndex = i;
  }

  void stylePgs(int i, PImage img) {
    int pixelSize = 10;
    img.loadPixels();
    pgs[i] = createGraphics((int) wide, (int) tall, P2D);
    pgs[i].beginDraw();
    pgs[i].background(255);
    for (int x = 0; x < img.width; x += pixelSize) {
      for (int y = 0; y < img.height; y += pixelSize) {
        int pixLoc = int(x + y*img.width);
        int fillColor = img.pixels[pixLoc];
        pgs[i].fill(fillColor);
        pgs[i].noStroke();
        pgs[i].stroke(0);
        pgs[i].rect(x, y, pixelSize, pixelSize);
      }
    }
    pgs[i].endDraw();
  }
}

