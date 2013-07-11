
import org.scribe.builder.*;
import org.scribe.extractors.*;
import org.scribe.builder.api.*;
import org.scribe.services.*;
import org.scribe.utils.*;
import org.scribe.oauth.*;
import org.scribe.model.*;
import org.scribe.exceptions.*;

// The main control class that holds the different networks and handles:
// - comparison and management of local network data
// - authentication and interaction with web API's
class NetworkManager {
  ArrayList <String> namesOfLocalNetworks = new ArrayList <String> ();
  
  NetworkManager() {
    loadNamesOfLocalNetworks();
    createTabsForLocalNetworks();
  }
  
  void loadNamesOfLocalNetworks() {
    File localNetworkFolder = new File(localPath);
    if (localNetworkFolder.exists()) {
      File[] networkFolders = localNetworkFolder.listFiles();
      for (int i=0; i<networkFolders.length; i++) {
        if (networkFolders[i].isDirectory()) {
          namesOfLocalNetworks.add( networkFolders[i].getName() );
        }
      }
      if (bDebug) {
        if (namesOfLocalNetworks.size() > 0) {
          println("The Network Manager found " + namesOfLocalNetworks.size()
          + " locally stored networks: " + namesOfLocalNetworks);
        } else {
          println("No local networks were found.");
        }
      }
    } else {
      println("The localPath you have set does not exist. Exiting application.");
      exit();
    }
  }
  
  void createTabsForLocalNetworks() {
    int w = width/(namesOfLocalNetworks.size()+1);
    int h = 20;
    // filed issue to change default Tab name: http://code.google.com/p/controlp5/issues/detail?id=80
    cp5.getTab("default").activateEvent(true).setSize(w,h).setLabel("Networks");
    for (String name : namesOfLocalNetworks) {
      cp5.addTab(name).activateEvent(true).setSize(w,h);
    }
  }
  
  void run() {
    if (currentTab.equals("default")) { displayLocalNetworkNames(); }
  }
  
  void displayLocalNetworkNames() {
    pushMatrix();
    translate(50, 80);
    fill(0);
    textFont(fontBold);
    text("LOCALLY FOUND NETWORKS (" + namesOfLocalNetworks.size() + ")", 0, 0);
    textFont(font);
    for (int i=0; i<namesOfLocalNetworks.size(); i++) {
      String name = namesOfLocalNetworks.get(i);
      text("• " + name, 0, (i+1) * 30);
    }
    popMatrix();
  }
}

