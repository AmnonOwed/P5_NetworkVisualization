
class NetworkIcon {
  boolean iconExists;
  color nColor, tColor;
  PVector tabPosDim;
  PShape iconShape;

  NetworkIcon(String networkPath, String networkName) {
    String iconPath = networkPath + networkName + "-icon.svg";    
    iconExists = new File(iconPath).isFile();
    if (iconExists) {
      iconShape = loadShape(iconPath);
      iconShape.disableStyle();
    } else {
      iconShape = createCustomIcon();
    }
    nColor = color(0);
    tColor = color(255);
    tabPosDim = new PVector();
  }

  void display(int x, int y, int w, int h) {
    if (iconExists) { 
      fill(nColor); 
      stroke(nColor);
    } else { 
      iconShape.setFill(nColor);
    }
    shape(iconShape, x, y, w, h);
  }
  
  void displayTab() {
    if (iconExists) {
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

