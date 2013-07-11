
// this tab will contain all gui-related code (controlP5)

import controlP5.*;

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
      cp5.addTab(name).activateEvent(true).setWidth(w).setHeight(h)
         .getCaptionLabel().align(CENTER, CENTER);
      nMan.setNetworkIconPosition(name, new PVector((w+4)*i+4, 4, tabHeight-8) );
    }
    currentTab = names.get(0);
    cp5.getTab(currentTab).bringToFront();
  }
}

void drawGUI() {
  // hack to draw ControlP5 into a JAVA2D PGraphics,
  // because the P2D/P3D renderers cause anti-aliasing text blur
  pgControlP5.clear();
  beginRecord(pgControlP5);
  cp5.draw();
  endRecord();
  image(pgControlP5, 0, 0);
  nMan.drawTabIcons();
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isTab()) {
    currentTab = theControlEvent.getTab().getName();
    if (bDebug) { 
      println("Got an event from Tab: " + currentTab);
    }
  }
}

