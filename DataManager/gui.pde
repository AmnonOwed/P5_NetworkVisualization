
// this tab will contain all gui-related code (controlP5)

ControlP5 cp5;

String currentTab;
PFont font, fontBold;
PGraphics pgControlP5;
int tabWidthAddNetwork = 75;
int tabHeight = 30;
int workAreaX, workAreaY;
int workAreaW, workAreaH;
ArrayList <String> tabList;

void setupGUI() {
  cp5 = new ControlP5(this);
  pgControlP5 = createGraphics(width, height, JAVA2D);
  cp5.setAutoDraw(false);
  font = createFont("Arial", 13, true);
  fontBold = createFont("Arial Bold", 13, true);
  setupTabsForLocalNetworks();
  workAreaX = 0;
  workAreaY = tabHeight;
  workAreaW = width;
  workAreaH = height - tabHeight;
}

void setupTabsForLocalNetworks() {
  ArrayList <String> allNames = nMan.getNamesOfNetworks();
  tabList = new ArrayList <String> ();
  
  if (bNoKeyNetworkTabs) {
    tabList = allNames;
  } else {
    for (String name : allNames) {
      Network network = nMan.getNetwork(name);
      if (network.keysLoaded()) {
        tabList.add(name);
      }
    }
  }
  
  if (tabList.size() > 0) {
    cp5.getTab("default").setVisible(false);
    int maxWidth = width-tabWidthAddNetwork+5;
    int w = (maxWidth-(tabList.size()-1))/tabList.size()-3;
    int h = tabHeight;
    for (int i=0; i<tabList.size(); i++) {
      String name = tabList.get(i);
      Tab t = cp5.addTab(name).activateEvent(true).setWidth(w).setHeight(h);
      t.getCaptionLabel().align(CENTER, CENTER);
      Network network = nMan.getNetwork(name);
      if (!network.keysLoaded()) {
        t.setColorBackground(color(198, 212, 225));
        t.setColorForeground(color(189, 184, 173));
      }
      PVector tabIconPosDim = new PVector((w+4)*i+4, 4, tabHeight-8);
      network.setTabIconPosDim(tabIconPosDim);
    }
    cp5.addTab("Add Network").activateEvent(true).setWidth(tabWidthAddNetwork).setHeight(h).getCaptionLabel().align(LEFT, CENTER).set("+ Add Network");
    currentTab = "Add Network";
    cp5.getTab(currentTab).bringToFront();
  }
}

void preRenderGUI() {
  // temporary hack to draw ControlP5 into a JAVA2D PGraphics,
  // because the P2D renderer causes anti-aliasing text blur and other artifacts
  // forum post: https://forum.processing.org/topic/controlp5-and-processing-2-0-p2d-p3d-renderers
  // googlecode issue: http://code.google.com/p/controlp5/issues/detail?id=81
  // github issue: https://github.com/processing/processing/issues/1964
  // github issue: https://github.com/processing/processing/issues/1972
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
    textAlign(LEFT, BOTTOM);
    text("DEBUG MODE", 6, height-13);
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

void keyPressed() {
  if (key == 'd') { bDebug = !bDebug; }
}

