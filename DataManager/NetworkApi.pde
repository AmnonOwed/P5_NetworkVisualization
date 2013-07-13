
class NetworkApi {
  boolean exists;
  
  NetworkApi(String networkPath, String networkName) {
    String path = networkPath + networkName + "-methods.json";
    exists = new File(path).isFile();
    if (exists) {
      JSONObject json = loadJSONObject(path);
      String NETWORK = json.getString("NETWORK");
      if (NETWORK.equals(networkName)) {
        // load api methods from JSON file here
        // todo: determine how to store methods in JSON file
      } else {
        exists = false;
        if (bDebug) {
          println("Error in network [" + networkName + "] : unmatching network name in JSON methods file (" + NETWORK + ")");
        }
      }
    } else {
      if (bDebug) {
        println("Error in network [" + networkName + "] : no network methods found");
      }
    }
  }
}

