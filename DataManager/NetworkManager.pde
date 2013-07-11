
import org.scribe.builder.*;
import org.scribe.extractors.*;
import org.scribe.builder.api.*;
import org.scribe.services.*;
import org.scribe.utils.*;
import org.scribe.oauth.*;
import org.scribe.model.*;
import org.scribe.exceptions.*;

class NetworkManager {
  ArrayList <String> namesOfLocalNetworks = new ArrayList <String> ();
  HashMap <String, Network> localNetworks;
  
  NetworkManager() {
    loadNamesOfLocalNetworks();
    loadLocalNetworks();
  }
  
  // setup methods
  
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
  
  void loadLocalNetworks() {
    localNetworks = new HashMap <String, Network> (namesOfLocalNetworks.size());
    for (String name : namesOfLocalNetworks) {
      localNetworks.put(name, new Network(name));
    }
  }

  // continuous methods
  
  void run() {
    Network localNetwork = localNetworks.get(currentTab);
    if (localNetwork != null) { localNetwork.run(); }
  }
  
  void drawTabIcons() {
    for (String name : localNetworks.keySet()) {
      localNetworks.get(name).displayTabIcon();
    }
  }

  // getters
  
  ArrayList <String> getNamesOfLocalNetworks() {
    return namesOfLocalNetworks;
  }
  
  // setters
  
  void setNetworkIconPosition(String networkName, PVector p) {
    localNetworks.get(networkName).tabIconPosDim.set(p.x, p.y, p.z);
  }
}

