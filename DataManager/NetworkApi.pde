
class NetworkApi {
  boolean exists;
  
  NetworkApi(String networkPath, String networkName) {
    String path = networkPath + networkName + "-methods.json";
    exists = new File(path).isFile();
    if (exists) {
      JSONObject json = loadJSONObject(path);
      String networkNameJSON = json.getString("Network Name");
      if (networkNameJSON.equals(networkName)) {
        // todo: load api methods from JSON file
      } else {
        exists = false;
        if (bDebug) {
          println("Error in network [" + networkName + "] : unmatching network name in JSON methods file (" + networkNameJSON + ")");
        }
      }
    } else {
      if (bDebug) {
        println("Error in network [" + networkName + "] : no network methods found");
      }
    }
  }
}

