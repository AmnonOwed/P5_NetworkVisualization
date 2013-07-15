
static class RetreiveMethods {
  static JSONObject network(Api api) {

    String name = api.getName();
    println("Network Name: " + name);
    println();
    
    ArrayList <String> methods = api.getMethodUrls();
    
    if (methods != null && methods.size() > 0) {
      println();
      int selection = 0; // a single example to test if it works
      println("Method " + selection + " of " + methods.size() + " selected");
      api.getMethod( methods.get(selection) );
    } else {
      println("No methods were retreived.");
    }

    // todo implement classes so that a JSONObject is created instead of just println's;
    return null;
  }
}

