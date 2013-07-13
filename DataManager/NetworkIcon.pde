
class NetworkIcon {
  boolean exists;
  color nColor, tColor;
  PVector tabPosDim;
  PShape iconShape;

  NetworkIcon(String networkPath, String networkName) {
    String path = networkPath + networkName + "-icon.svg";
    exists = new File(path).isFile();
    if (exists) {
      iconShape = loadShape(path);
      iconShape.disableStyle();
    } else {
      if (bDebug) {
        println("Error in network [" + networkName + "] : no svg icon found >> creating custom icon");
      }
      iconShape = createCustomIcon();
    }
    nColor = color(0);
    tColor = color(255);
    tabPosDim = new PVector();
  }

  void display(int x, int y, int w, int h) {
    if (exists) { 
      fill(nColor); 
      stroke(nColor);
    } else { 
      iconShape.setFill(nColor);
    }
    shape(iconShape, x, y, w, h);
  }
  
  void displayTab() {
    if (exists) {
      fill(tColor);
      stroke(tColor);
    } else {
      iconShape.setFill(tColor);
    }
    shape(iconShape, tabPosDim.x, tabPosDim.y, tabPosDim.z, tabPosDim.z);
  }
  
  void setTabPosDim(PVector p) {
    tabPosDim.set(p.x, p.y, p.z);
  }

  PShape createCustomIcon() {
    PShape s = createShape();

    s.beginShape();
    s.noStroke();
    s.fill(0);

    s.vertex(25, 0);
    s.vertex(50, 25);
    s.vertex(25, 50);
    s.vertex(0, 25);

    s.beginContour();
    s.vertex(25, 15);
    s.vertex(35, 25);
    s.vertex(25, 35);
    s.vertex(15, 25);
    s.endContour();

    s.endShape(CLOSE);

    return s;
  }
}

