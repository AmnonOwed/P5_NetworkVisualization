
// this tab will contain all the code that handles the gui (controlP5)

import controlP5.*;

ControlP5 cp5;

String currentTab = "default";

void setupControlP5() {
  cp5 = new ControlP5(this);
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isTab()) {
    currentTab = theControlEvent.getTab().getName();
    if (bDebug) { println("Got an event from Tab: " + currentTab); }
  }
}

