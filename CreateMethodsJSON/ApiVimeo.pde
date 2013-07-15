
class ApiVimeo extends Api {

  ApiVimeo(String urlFull, String urlBase, String urlHook) {
    super(urlFull, urlBase, urlHook);
  }

  ApiVimeo(String urlFull) {
    super(urlFull);
  }
  
  @Override
  JSONObject getMethod(String methodUrl) {
    JSONObject method = null;
  
    Document doc = getPage(methodUrl);
    
    if (doc != null) {
      if (bDebug) { println("Title: " + doc.title() + "\n"); }
      method = new JSONObject();
  
      String methodName = doc.select("h1").first().html();
      if (bDebug) { println("Method Name: " + methodName); }
      method.setString("Name", methodName);
  
      Elements block = doc.select("div.col_large");
      
      String methodDescription = block.select("p:first-child").html();
      if (bDebug) { println("Method Description: " + methodDescription); }
      method.setString("Description", methodDescription);
  
      if (bDebug) { println("Method Documentation: " + methodUrl); }
      method.setString("Documentation", methodUrl);
  
      String endpoint = "http://vimeo.com/api/rest/v2";
      if (bDebug) { println("Method Endpoint: " + endpoint); }
      method.setString("Endpoint", endpoint);
  
      JSONArray parameters = new JSONArray();

      if (bDebug) { 
        println();
        println("Parameter Name: method");
        println("Parameter Type: string");
        println("Parameter Description: The name of the method.");
        println("Parameter Required: true");
        println();
      }
      JSONObject parameter = new JSONObject();
      parameter.setString("Name", "method");
      parameter.setString("Type", "string");
      parameter.setString("Description", "The name of the method.");
      parameter.setBoolean("Required", true);
      parameters.append(parameter);
      
      Element parameterTable = block.select("table.params").first();
      if (parameterTable != null) {
        Elements headerElements = parameterTable.select("th");
        Elements trs = parameterTable.select("tr:has(td)");
        for (Element row : trs) {
          Elements tds = row.select("td");
          parameter = new JSONObject();
          for (int i=0; i<tds.size(); i++) {
            Element col = tds.get(i);
            String header = headerElements.get(i).html();
            String content = col.html();
            if (header.equals("Description")) {
              content = content.replace("(required) ", "");
            }
            if (bDebug) { println("Parameter " + header + ": " + content); }
            parameter.setString(header, content);
          }
          if (tds.size() > 0) {
            boolean required = tds.get(2).html().contains("(required)");
            if (bDebug) { println("Parameter Required: " + required + "\n"); }
            parameter.setBoolean("Required", required);
          }
          parameters.append(parameter);
        }
      }
      method.setJSONArray("Parameters", parameters);
    }
    return method;
  }

  @Override
  String getName() {
    return "Vimeo";
  }
}

