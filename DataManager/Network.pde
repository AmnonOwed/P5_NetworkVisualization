
class Network {
  String networkPath, networkName;
  Icon networkIcon;

  Network(String name) {
    networkName = name;
    networkPath = localPath + name + "/";
    networkIcon = new Icon(networkPath, networkName);
  }

  // continuous methods

  void run() {
    int DIM = 500;
    networkIcon.display(width/2-DIM/2, height/2-DIM/2, DIM, DIM);
  }

  void displayTabIcon() {
    networkIcon.displayTab();
  }

  // setters
  
  void setTabIconPosDim(PVector p) {
    networkIcon.setTabPosDim(p);
  }
}

