
class Network {
  String networkPath, networkName;
  NetworkIcon icon;
  NetworkKeys keys;
  NetworkApi api;

  Network(String name) {
    networkName = name;
    networkPath = localPath + name + "/";
    icon = new NetworkIcon(networkPath, networkName);
    keys = new NetworkKeys(networkPath, networkName);
    api = new NetworkApi(networkPath, networkName); 
  }

  // continuous methods

  void run() {
    int DIM = 500;
    icon.display(width/2-DIM/2, height/2-DIM/2, DIM, DIM);
  }

  void displayTabIcon() {
    icon.displayTab();
  }
  
  // getters

  boolean iconLoaded() {
    return icon.exists;
  }
  
  boolean keysLoaded() {
    return keys.exists;
  }

  boolean apiLoaded() {
    return api.exists;
  }
  
  String[] getInfo() {
    return new String[] {
      networkName,
      str(iconLoaded()),
      str(keysLoaded()),
      str(apiLoaded()),
      bNoKeyNetworkTabs?"true":str(keysLoaded())
    };
  }

  // setters
  
  void setTabIconPosDim(PVector p) {
    icon.setTabPosDim(p);
  }
}

