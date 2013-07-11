
class Network {
  String networkPath, networkName;
  NetworkIcon icon;

  Network(String name) {
    networkName = name;
    networkPath = localPath + name + "/";
    icon = new NetworkIcon(networkPath, networkName);
  }

  // continuous methods

  void run() {
    int DIM = 500;
    icon.display(width/2-DIM/2, height/2-DIM/2, DIM, DIM);
  }

  void displayTabIcon() {
    icon.displayTab();
  }

  // setters
  
  void setTabIconPosDim(PVector p) {
    icon.setTabPosDim(p);
  }
}

