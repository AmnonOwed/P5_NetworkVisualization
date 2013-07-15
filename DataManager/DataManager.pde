
/*

 DataManager by Amnon Owed (July 2013)
 https://github.com/AmnonOwed
 http://vimeo.com/amnon

 This is the most essential sketch of this repo because it handles:
 - Authentication through OAuth
 - Sending API requests
 - Caching data locally in JSON files
 - Comparing API and local data
 - etc.
 
 Note beforehand:
 The integration of all networks into a single sketch is a design choice, mainly for two reasons:
 1. It enables the user (aka me) to manage all the network data from a single command and control center.
 2. It enforces the programmer (aka me) to code efficiently and write a generic code base that can handle different networks.
 
 Note 2 beforehand:
 At the time of writing (July 11th 2013) this is just ideas, theories, plans and an empty skeleton sketch.
 Let's see how this plays out! Hopefully I'll learn some new things and perhaps create something interesting. ;-)

 Built with:
 - Processing 2.0.1
 - ControlP5 2.0.4
 - Scribe 1.3.5 + Apache Commons Codec 1.8

*/

// Library imports as described above
import controlP5.*;
// relevant Scribe imports

// The central path on YOUR computer which contains all the network folders (e.g. Twitter, Vimeo)
// Each network folder contains resources (svg icon, keys, methods) and stores local data (user data, images)
// A network folder called 'NetworkName' should contain:
// - a file "NetworkName-icon.svg" with an SVG icon that represents the network
// - a file "NetworkName-keys.json" as created with the 'CreateKeysJSON' sketch
// - a file "NetworkName-methods.json" as created with the 'CreateMethodsJSON' sketch
String localPath = "C:/Documents and Settings/mainframe/My Documents/ProcessingSources/Networks/";

boolean bFullScreen = false; // toggle fullscreen
boolean bDebug = false; // toggle debug mode to print additional info to the console
boolean bNoKeyNetworkTabs = false; // toggle whether networks without authentication keys get a tab in the gui
int smoothLevel = 8;

NetworkManager nMan;

void setup() {
  size(bFullScreen?displayWidth:1280, bFullScreen?displayHeight:720, P2D);
  smooth(smoothLevel);
  nMan = new NetworkManager();
  setupGUI();
}

void draw() {
  preRenderGUI();
  background(255);
  nMan.run();
  drawGUI();
}

