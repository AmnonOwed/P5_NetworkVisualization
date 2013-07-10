
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
          println("The Network Manager found " + namesOfLocalNetworks.size() + " locally stored networks: " + namesOfLocalNetworks);
        } else {
          println("No local networks were found.");
        }
      }
    } else {
      println("The localPath you have set does not exist. Exiting application.");
      exit();
    }
  }
  
  void display() {
    fill(0);
    textFont(fontBold);
    text("LOCALLY FOUND NETWORKS (" + namesOfLocalNetworks.size() + ")", 100, 100);
    textFont(font);
    for (int i=0; i<namesOfLocalNetworks.size(); i++) {
      String name = namesOfLocalNetworks.get(i);
      text("• " + name, 100, 130+i*30);
    }
  }
}

