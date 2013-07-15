
class ApiVimeo extends Api {

  ApiVimeo(String urlFull, String urlBase, String urlHook) {
    super(urlFull, urlBase, urlHook);
  }

  ApiVimeo(String urlFull) {
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
  
      Elements block = doc.select("div.col_large");
      
      String methodDescription = block.select("p:first-child").html();
      println("Method Description: " + methodDescription);
  
      println("Method Documentation: " + methodUrl);
  
      String endpoint = "http://vimeo.com/api/rest/v2";
      println("Method Endpoint: " + endpoint);
  
      println();
  
      println("Parameter Name: method");
      println("Parameter Type: string");
      println("Parameter Description: The name of the method.");
      println("Parameter Required: true");
      
      Element parameterTable = block.select("table.params").first();
      if (parameterTable != null) {
        Elements header = parameterTable.select("th");
        Elements trs = parameterTable.select("tr");
        for (Element row : trs) {
          Elements tds = row.select("td");
          for (int i=0; i<tds.size(); i++) {
            Element col = tds.get(i);
            String parameter = header.get(i).html();
            String content = col.html();
            if (parameter.equals("Description")) {
              content = content.replace("(required) ", "");
            }
            println("Parameter " + parameter + ": " + content);
          }
          if (tds.size() > 0) {
            println("Parameter Required: " + tds.get(2).html().contains("(required)"));
          }
          println();
        }
      }
    }
  }

  @Override
  String getName() {
    return "Vimeo";
  }
}

