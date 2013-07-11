
class Network {
  String networkPath, networkName;
  boolean networkIconExists;
  color networkIconColor, tabIconColor;
  PVector tabIconPosDim;
  PShape networkIcon;

  Network(String name) {
    networkName = name;
    networkPath = localPath + name + "/";
    setupIcon();
  }

  void setupIcon() {
    String iconPath = networkPath + networkName + "-icon.svg";
    networkIconExists = new File(iconPath).isFile();
    if (networkIconExists) {
      networkIcon = loadShape(iconPath);
      networkIcon.disableStyle();
    } else {
      networkIcon = createCustomIcon();
    }
    networkIconColor = color(0);
    tabIconColor = color(255);
    tabIconPosDim = new PVector();
  }

  void run() {
    display();
  }

  void display() {
    if (networkIconExists) {
      fill(networkIconColor);
      stroke(networkIconColor);
    } else {
      networkIcon.setFill(networkIconColor);
    }
    int DIM = 500;
    shape(networkIcon, width/2-DIM/2, height/2-DIM/2, DIM, DIM);
  }

  void displayTabIcon() {
    if (networkIconExists) {
      fill(tabIconColor);
      stroke(tabIconColor);
    } else {
      networkIcon.setFill(tabIconColor);
    }
    shape(networkIcon, tabIconPosDim.x, tabIconPosDim.y, tabIconPosDim.z, tabIconPosDim.z);
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

