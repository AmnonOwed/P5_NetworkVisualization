
class Api {
  String urlFull, urlBase, urlHook;
  
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
  
  ArrayList <String> getMethodUrls() {
    Document doc = null;
    println("Retreiving method URLs");
  
    try {
      doc = Jsoup.connect(urlFull).get();
      println("Loaded: " + urlFull);
    } catch (IOException e) {
      println("Not found: " + urlFull);
    }
    
    if (doc != null) {
      println("Title: " + doc.title());
      Elements methodLinks = doc.select("a[href^=" + urlHook +"]");
      Set <String> uniqueLinks = new LinkedHashSet <String> ();
      for (Element e : methodLinks) {
        String url = e.attr("href");
        if (!url.startsWith("http://")) { url = urlBase + url; }
        uniqueLinks.add( url );
      }
      println("Links returned: " + uniqueLinks.size() + " (unique) of " + methodLinks.size() + " (all)");
      return new ArrayList <String> (uniqueLinks);
    }
    return null;
  }

  void getMethod(String name) {
    println("The Api class does not implement getMethod(), because the online documentation of network API's differs too much");
    println("Therefore getMethod() must be overridden and implemented in the specific APIS's subclass");
  }
  
  String getName() {
    return "This method must be overriden and implemented in the specific API's subclass";
  }
}

