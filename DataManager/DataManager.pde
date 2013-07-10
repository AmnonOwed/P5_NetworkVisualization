
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
 2. It enables the programmer (aka me) to code efficiently and write a generic code base that can handle different networks.
 
 Note 2 beforehand:
 At the time of writing (July 11th 2013) this is just ideas, theories, plans and an empty skeleton sketch.
 Let's see how this plays out! Hopefully I'll learn some new things and perhaps create something interesting. ;-)

 Built with:
 - Processing 2.0.1
 - ControlP5 2.0.4
 - Scribe 1.3.5 + Apache Commons Codec 1.8

*/

// The central path on YOUR computer where the local data for all networks is stored (keys, user data, images)
// Each individual network folder will have it's 'Networkname' and contain:
// - a file "Networkname-keys.json" as created with the 'CreateKeysJSON' sketch
// - a file "Networkname-icon.svg" with an SVG icon that represents the network
// - a subfolder 'images' that stores image data from the network (for example avatars) locally
// - a subfolder 'users' that stores user data from the network in JSON format locally
String localPath = "C:/Documents and Settings/mainframe/My Documents/ProcessingSources/Networks/";

boolean bDebug = true;
PFont font, fontBold;
NetworkManager nMan;

void setup() {
  size(1280, 720);
  setupControlP5();
  font = createFont("Arial", 13, true);
  fontBold = createFont("Arial Bold", 13, true);
  nMan = new NetworkManager();
}

void draw() {
  background(255);
  nMan.display();
}

