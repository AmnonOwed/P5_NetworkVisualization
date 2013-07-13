
class NetworkManager {
  ArrayList <String> namesOfNetworks = new ArrayList <String> ();
  HashMap <String, Network> networks;
  int numNetworks;

  NetworkManager() {
    loadNamesOfNetworks();
    loadNetworks();
  }

  // setup methods

  void loadNamesOfNetworks() {
    File networkFolder = new File(localPath);
    if (networkFolder.exists()) {
      File[] networkFolders = networkFolder.listFiles();
      for (int i=0; i<networkFolders.length; i++) {
        if (networkFolders[i].isDirectory()) {
          namesOfNetworks.add( networkFolders[i].getName() );
        }
      }
      numNetworks = namesOfNetworks.size();
      if (bDebug) {
        if (namesOfNetworks.size() > 0) {
          println("The Network Manager found " + namesOfNetworks.size()
            + " locally stored networks: " + namesOfNetworks);
        } else {
          println("No local networks were found.");
        }
      }
    } else {
      println("The localPath you have set does not exist. Exiting application.");
      exit();
    }
  }

  void loadNetworks() {
    networks = new HashMap <String, Network> (namesOfNetworks.size());
    for (String name : namesOfNetworks) {
      networks.put(name, new Network(name));
    }
  }

  // continuous methods

  void run() {
    if (currentTab.equals("Add Network")) {
      displayNetworkInformation();
    } else {
      getNetwork(currentTab).run();
    }
  }

  void displayTabIcons() {
    for (String name : tabList) {
      getNetwork(name).displayTabIcon();
    }
  }

  void displayNetworkInformation() {
    String[] titles = {
      "NetworkName",
      "Has SVG Icon",
      "Has Authentication Keys",
      "Had API Methods",
      "Has GUI Tab"
    };
    
    int numLines = numNetworks+5;
    int padding = tabHeight;
    int titleHeight = tabHeight;
    
    int aX = workAreaX + padding;
    int aY = workAreaY + padding;
    int aW = workAreaW - padding * 2;
    int aH = workAreaH - padding * 2 - titleHeight;
    
    float cellHeight = aH / float(numLines); 
    float cellWidth = aW / float(titles.length); 
    
    pushMatrix();

    textAlign(CENTER, CENTER);

    translate(aX, aY);
    textFont(fontBold);
    fill(0);
    for (int x=0; x<titles.length; x++) {
      float cX = x * cellWidth;
      text(titles[x], cX, 0, cellWidth, titleHeight);
    }

    translate(0, titleHeight);
    int mX = mouseX - aX;
    int mY = mouseY - aY - titleHeight;
    float eY = numNetworks * cellHeight;
    
    textFont(font);
    for (int y=0; y<numLines; y++) {
      float cY = y * cellHeight;

      if (y<numNetworks) {
        noStroke();
        if (y%2==0) { fill(198, 212, 225); } else { noFill(); }
        rect(0, cY, aW, cellHeight);
        stroke(0);
        if (y==0) { line(0, cY, aW, cY); }
        if (y==numNetworks-1) { line(0, eY, aW, eY); }

        fill(0);
        String[] networkInfo = getNetwork(y).getInfo();
        for (int x=0; x<titles.length; x++) {
          float cX = x * cellWidth;
          String item = networkInfo[x]; 
          if (item.equals("false")) {
            if (mX >= cX && mX < cX+cellWidth && mY >= cY && mY < cY+cellHeight) {
              String solution = getSolution(networkInfo[0], titles[x]);
              fill(255, 0, 0, 50);
              noStroke();
              rect(cX, cY, cellWidth, cellHeight);
              rect(0, eY, aW, cellHeight);
              fill(0);
              text(solution, 0, eY, aW, cellHeight);
              stroke(0);
              line(0, eY+cellHeight, aW, eY+cellHeight);
            }
            fill(255, 0, 0);
          } else {
            fill(0);
          }
          text(item, cX, cY, cellWidth, cellHeight);
        }
      }
    }
    
    popMatrix();
  }

  // getters
  
  String getSolution(String networkName, String problem) {
    if (problem.equals("Has SVG Icon")) { return "Place '" + networkName + "-icon.svg' in '" + localPath + networkName +"/'"; }
    if (problem.equals("Has Authentication Keys")) { return "Place '" + networkName + "-keys.json' in '" + localPath + networkName +"/'"; }
    if (problem.equals("Had API Methods")) { return "Place '" + networkName + "-methods.json' in '" + localPath + networkName +"/'"; }
    if (problem.equals("Has GUI Tab")) { return "Set bNoKeyNetworkTabs to true or place '" + networkName + "-keys.json' in '" + localPath + networkName +"/'"; }
    return "Problem not recognised.";
  }
  
  int getNumberOfNetworks() {
    return numNetworks;
  }

  ArrayList <String> getNamesOfNetworks() {
    return namesOfNetworks;
  }

  Network getNetwork(int index) {
    return getNetwork(namesOfNetworks.get(index));
  }

  Network getNetwork(String name) {
    return networks.get(name);
  }
}

