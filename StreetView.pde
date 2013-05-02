class StreetView {
  Location hoveredLoc;
  PImage[] imgs;
  PGraphics[] pgs;
  PImage currentImg;
  PImage[] loadingGif;
  PImage currentLoading;
  int imgHeight = 400; 
  int imgWidth = 640;
  int gifFrame = 0;
  float wide;
  float tall;
  float aspectRatio;

  StreetView(PImage[] _loadingGif) {
    loadingGif = _loadingGif;
    aspectRatio = imgWidth/imgHeight;
    wide = screen.width;
    tall = screen.height;//wide/aspectRatio;
    imgs = new PImage[ptVis.markers.size()];
    pgs = new PGraphics[imgs.length];
    currentLoading = loadingGif[0];
    gifFrame = 0;
    for (int i = 0; i < imgs.length; i++) {
      PointMarker marker = ptVis.markers.get(i);
      float lat = marker.loc.getLat();
      float lon = marker.loc.getLon();
      float angle = int(marker.angle);
      PImage currentImg = loadImage("http://maps.googleapis.com/maps/api/streetview?size="+imgWidth+"x"+imgHeight+"&location="+lat+",%20"+lon+"&fov=120&heading="+angle+"&pitch=00&sensor=false&sensor=false.png");
      currentImg.resize(int(wide), int(tall));
      imgs[i] = currentImg;
      stylePgs(i, imgs[i]);
    }
  } 

  void display(int markerIndex) {
    image(pgs[markerIndex], 0, screen.height-tall, wide, tall);
  }

  void loading() {
    if(frameCount % 5 == 0){
      gifFrame++;
      if(gifFrame == 12) gifFrame = 0;
    }
    currentLoading = loadingGif[gifFrame];
    imageMode(CENTER);
    image(currentLoading, width/2, height/2);
    imageMode(CORNER);
  }

  void stylePgs(int i, PImage img) {
    int pixelSize = 10;
    img.loadPixels();
    pgs[i] = createGraphics((int) wide, (int) tall, P2D);
    PGraphics pg = pgs[i];
    pg.beginDraw();
    pg.background(255);
    for (int x = 0; x < img.width; x += pixelSize) {
      for (int y = 0; y < img.height; y += pixelSize) {
        int pixLoc = int(x + y*img.width);
        int fillColor = img.pixels[pixLoc];
        pg.fill(fillColor);
        pg.noStroke();
        pg.stroke(0);
        pg.rect(x, y, pixelSize, pixelSize);
      }
    }
    pg.endDraw();
  }
}

