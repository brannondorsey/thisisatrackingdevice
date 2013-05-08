class StreetView {
  Location hoveredLoc;
  int currentImageIndex = 0;
  int imgHeight = 400; 
  int imgWidth = 640;
  PImage[] imgs;
  float wide;
  float tall;
  float aspectRatio;
  boolean displaying = false;

  StreetView() {
    aspectRatio = imgWidth/imgHeight;
    wide = screen.width;
    tall = screen.height; 
    imgs = new PImage[ptVis.markers.size()];
//    for (int i = 0; i < imgs.length; i++) {
//      PointMarker marker = ptVis.markers.get(i);
//      float lat = marker.loc.getLat();
//      float lon = marker.loc.getLon();
//      float angle = int(marker.angle);
//      PImage currentImg = loadImage("http://maps.googleapis.com/maps/api/streetview?size="+imgWidth+"x"+imgHeight+"&location="+lat+",%20"+lon+"&fov=120&heading="+angle+"&pitch=00&sensor=false&sensor=false.png");
//      println("loaded image number "+i);
//      currentImg.resize(int(wide), int(tall));
//      stylePgs(i, currentImg);
//    }
    for(int i = 0; i<imgs.length; i++){
      imgs[i] = loadImage("streetview_images/"+i+".jpg");
    }
  } 

  void display() {
    image(imgs[currentImageIndex], 0, screen.height-tall, wide, tall);
  }
  
  void updateImage(int i){
    currentImageIndex = i;
  }

  void stylePgs(int i, PImage img) {
    int pixelSize = 10;
    img.loadPixels();
    PGraphics pgs = createGraphics((int) wide, (int) tall, P2D);
    pgs.beginDraw();
    pgs.background(255);
    for (int x = 0; x < img.width; x += pixelSize) {
      for (int y = 0; y < img.height; y += pixelSize) {
        int pixLoc = int(x + y*img.width);
        int fillColor = img.pixels[pixLoc];
        pgs.fill(fillColor);
        pgs.noStroke();
        pgs.stroke(0);
        pgs.rect(x, y, pixelSize, pixelSize);
      }
    }
    pgs.endDraw();
    pgs.save("streetview_images/"+i+".jpg");
  }
}

