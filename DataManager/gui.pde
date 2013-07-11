
// this tab will contain all gui-related code (controlP5)

ControlP5 cp5;

String currentTab;
PFont font, fontBold;
PGraphics pgControlP5;
int tabHeight = 30;

void setupGUI() {
  cp5 = new ControlP5(this);
  pgControlP5 = createGraphics(width, height, JAVA2D);
  cp5.setAutoDraw(false);
  font = createFont("Arial", 13, true);
  fontBold = createFont("Arial Bold", 13, true);
  setupTabsForLocalNetworks();
}

void setupTabsForLocalNetworks() {
  ArrayList <String> names = nMan.getNamesOfLocalNetworks();
  if (names.size() > 0) {
    cp5.getTab("default").setVisible(false);
    int w = (width-(names.size()-1))/names.size()-3;
    int h = tabHeight;
    for (int i=0; i<names.size(); i++) {
      String name = names.get(i);
      cp5.addTab(name).activateEvent(true).setWidth(w).setHeight(h).getCaptionLabel().align(CENTER, CENTER);
      Network network = nMan.getNetwork(name);
      PVector tabIconPosDim = new PVector((w+4)*i+4, 4, tabHeight-8);
      network.setTabIconPosDim(tabIconPosDim);
    }
    currentTab = names.get(0);
    cp5.getTab(currentTab).bringToFront();
  }
}

void preRenderGUI() {
  // temporary hack to draw ControlP5 into a JAVA2D PGraphics,
  // because the P2D/P3D renderers cause anti-aliasing text blur
  // forum post: https://forum.processing.org/topic/controlp5-and-processing-2-0-p2d-p3d-renderers
  // googlecode issue: http://code.google.com/p/controlp5/issues/detail?id=81 
  pgControlP5.clear();
  beginRecord(pgControlP5);
  cp5.draw();
  endRecord();
}

void drawGUI() {
  image(pgControlP5, 0, 0);
  nMan.displayTabIcons();
  if (bDebug) {
    fill(0);
    textFont(fontBold);
    text("DEBUG MODE", 6, height-17);
    noStroke();
    fill(255, 0, 0);
    rect(0, height-10, width, 10);
  }
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isTab()) {
    currentTab = theControlEvent.getTab().getName();
    if (bDebug) { 
      println("Got an event from Tab: " + currentTab);
    }
  }
}

