
class ApiTwitter extends Api {

  ApiTwitter(String urlFull, String urlBase, String urlHook) {
    super(urlFull, urlBase, urlHook);
  }

  ApiTwitter(String urlFull) {
    super(urlFull);
  }

  @Override
  void getMethod(String methodUrl) {
    Document doc = null;
  
    try {
      doc = Jsoup.connect(methodUrl).get();
      println("Loaded: " + methodUrl);
    } catch (IOException e) {
      println("Not found: " + methodUrl);
    }
    
    if (doc != null) {
      println("Title: " + doc.title());
      println();
  
      String methodName = doc.select("h1").first().html();
      println("Method Name: " + methodName);
  
      String methodDescription = doc.select("p").first().html();
      methodDescription = methodDescription.replace("<tt>", "");
      methodDescription = methodDescription.replace("</tt>", "");
      println("Method Description: " + methodDescription);
  
      println("Method Documentation: " + methodUrl);
  
      String endpoint = doc.select("h2 ~ div.odd").first().html();
      println("Method Endpoint: " + endpoint);
  
      println();
  
      Elements parameters = doc.select("div.parameter");
      for (Element parameter : parameters) {
        Element param = parameter.select("span.param").first();
        println("Parameter Name: " + param.ownText());
        String description = parameter.select("p").first().html();
        description = description.replace("<tt>", "");
        description = description.replace("</tt>", "");
        println("Parameter Description: " + description);
        println("Parameter Required: " + param.html().contains("required"));
        println();
      }
    }
  }

  @Override
  String getName() {
    return "Twitter";
  }
}

