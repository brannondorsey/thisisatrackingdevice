class StreetView{
 Location hoveredLoc;
 PImage[] imgs;
 PGraphics[] pgs;
 PImage currentImg;
 int imgHeight = 400; 
 int imgWidth = 640;
 float wide;
 float tall;
 float aspectRatio;
 StreetView(){
  aspectRatio = imgWidth/imgHeight;
  wide = screen.width;
  tall = screen.height;//wide/aspectRatio;
  imgs = new PImage[ptVis.markers.size()];
  pgs = new PGraphics[imgs.length];
  for(int i = 0; i < imgs.length; i++){
    PointMarker marker = ptVis.markers.get(i);
    float lat = marker.loc.getLat();
    float lon = marker.loc.getLon();
    float angle = int(marker.angle);
    println("lat is "+lat);
    PImage currentImg = loadImage("http://maps.googleapis.com/maps/api/streetview?size="+imgWidth+"x"+imgHeight+"&location="+lat+",%20"+lon+"&fov=120&heading="+angle+"&pitch=00&sensor=false&sensor=false.png");
    currentImg.resize(int(wide), int(tall));
    imgs[i] = currentImg;
    stylePgs(i, imgs[i]);  
}
  println(imgs.length);
 } 
 
 void display(int markerIndex){
   //tint(#BED5F5);
   image(pgs[markerIndex], 0, screen.height-tall, wide, tall); 
   //tint(255);
 }
 
 void stylePgs(int i, PImage img){
   int pixelSize = 10;
   img.loadPixels();
   pgs[i] = createGraphics((int) wide,(int) tall, P2D);
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
