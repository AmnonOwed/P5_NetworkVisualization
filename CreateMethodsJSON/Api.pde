
class Api {
  String urlFull, urlBase, urlHook;
  JSONObject json;
  
  Api(String urlFull, String urlBase, String urlHook) {
    this.urlFull = urlFull;
    this.urlBase = urlBase;
    this.urlHook = urlHook;
  }

  Api(String urlFull) {
    this.urlFull = urlFull;
    String start = urlFull.startsWith("https://")?"https://":"http://";
    urlBase = match(urlFull, start+".*?/")[0];
    urlBase = urlBase.substring(0, urlBase.length()-1);
    urlHook = urlFull.replace(urlBase, "");
  }

  void retrieve() {
    if (!bDebug) {
      println("Retrieving the complete " + getName() + " API (please be patient, this may take a few minutes)");
      println("To get console feedback, please set 'bDebug' to true");
    }
    json = new JSONObject();

    String name = getName();
    json.setString("Network Name", name);
    if (bDebug) { println("Network Name: " + name + "\n"); }
    json.setString("DateTime", new Date().toString());

    JSONObject application = new JSONObject();
    application.setString("Name", "CreateMethodsJSON by Amnon Owed");
    application.setString("Description", "The application can be used to parse methods and parameters of (social network) API's from HTML into a valid JSON file");
    application.setString("URL", "https://github.com/AmnonOwed/P5_NetworkVisualization");
    json.setJSONObject("Application", application);
    
    ArrayList <String> methodUrls = getMethodUrls();
    ArrayList <String> missedMethods = new ArrayList <String> ();
    ArrayList <String> missedMethods2 = new ArrayList <String> ();
    
    if (methodUrls != null && methodUrls.size() > 0) {
      JSONArray methods = new JSONArray();
      for (int i=0; i<methodUrls.size(); i++) {
        if (bDebug) { println("Method " + i + " of " + methodUrls.size() + " selected"); }
        JSONObject method = getMethod( methodUrls.get(i) );
        if (method == null) {
          missedMethods.add( methodUrls.get(i) );
        } else {
          methods.append(method);
        }
      }

      if (missedMethods.size() == 0) {
        if (bDebug) { println("No methods missed in first attempt"); }
      } else {
        if (bDebug) { println("Error : " + missedMethods.size() + " methods missed in first attempt > trying these methods again\n"); }
        for (int i=missedMethods.size()-1; i>=0; i--) {
          if (bDebug) { println("Method " + (missedMethods.size()-i) + " of " + missedMethods.size() + " selected"); }
          JSONObject method = getMethod( missedMethods.get(i) );
          if (method == null) {
            missedMethods2.add( methodUrls.get(i) );
          } else {
            methods.append(method);
          }
        }
      }
      
      if (missedMethods2.size() == 0) {
        if (bDebug) { println("No methods missed in second attempt, all methods retreived"); }
      } else {
        if (bDebug) { println(missedMethods2.size() + " methods missed in second attempt:"); }
        println("Error : " + missedMethods2.size() + " methods were not retreived:");
        for (String s : missedMethods2) {
          println(s);
        }
      }
      
      json.setJSONArray("Methods", methods);
    } else {
      if (bDebug) { println("No methods were retrieved."); }
    }
  }
  
  void print() {
    if (bDebug) { println("The full JSON object:\n"); }
    println(json);
  }
  
  void save() {
    String fileName = getName() + "-methods.json";
    boolean succes = saveJSONObject(json, "data/" + fileName);
    if (succes) {
      println(fileName + " successfully saved in the data folder");
    } else {
      println("Error : " + fileName + " not saved.");
    }
  }
  
  ArrayList <String> getMethodUrls() {
    if (bDebug) { println("Retrieving method URLs"); }

    Document doc = getPage(urlFull);

    if (doc != null) {
      if (bDebug) { println("Title: " + doc.title()); }
      Elements methodLinks = doc.select("a[href^=" + urlHook +"]");
      Set <String> uniqueLinks = new LinkedHashSet <String> ();
      for (Element e : methodLinks) {
        String url = e.attr("href");
        if (!url.startsWith("http://")) { url = urlBase + url; }
        uniqueLinks.add( url );
      }
      if (bDebug) { println("Links returned: " + uniqueLinks.size() + " (unique) of " + methodLinks.size() + " (all)\n"); }
      return new ArrayList <String> (uniqueLinks);
    }
    return null;
  }

  Document getPage(String url) {
    try {
      Document doc = Jsoup.connect(url).get();
      if (bDebug) { println("Loaded: " + url); }
      return doc;
    } catch (IOException e) {
      if (bDebug) { println("Not found: " + url); }
    }
    return null;
  }
  
  JSONObject getMethod(String name) {
    println("The Api class does not implement getMethod() because the online documentation of network API's differs too much");
    println("Therefore getMethod() must be overridden and implemented in the specific APIS's subclass");
    return null;
  }
  
  String getName() {
    return "This method must be overridden and implemented in the specific API's subclass";
  }
}

