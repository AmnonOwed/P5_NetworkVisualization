
class NetworkKeys {
  boolean exists;
  
  String CONSUMER_KEY;
  String CONSUMER_SECRET;
  String ACCESS_TOKEN;
  String ACCESS_TOKEN_SECRET;
  
  NetworkKeys(String networkPath, String networkName) {
    String path = networkPath + networkName + "-keys.json";
    exists = new File(path).isFile();
    if (exists) {
      JSONObject json = loadJSONObject(path);
      String NETWORK = json.getString("NETWORK");
      if (NETWORK.equals(networkName)) {
        CONSUMER_KEY = json.getString("CONSUMER_KEY");
        CONSUMER_SECRET = json.getString("CONSUMER_SECRET");
        ACCESS_TOKEN = json.getString("ACCESS_TOKEN");
        ACCESS_TOKEN_SECRET = json.getString("ACCESS_TOKEN_SECRET");
      } else {
        exists = false;
        if (bDebug) {
          println("Error in network [" + networkName + "] : unmatching network name in JSON keys file (" + NETWORK + ")");
        }
      }
    } else {
      if (bDebug) {
        println("Error in network [" + networkName + "] : no network keys found");
      }
    }
  }
}

